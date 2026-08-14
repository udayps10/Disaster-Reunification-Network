import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../../core/config/api_config.dart';
import '../models/match_request.dart';
import '../models/match_response.dart';

/// Contract for the future protected REST matching backend.
///
/// Uses the local FastAPI mock in development. The base URL is centralized in
/// [ApiConfig] and can be replaced without changing this service.
abstract interface class MatchApiService {
  Future<MatchResponse> findMatches(MatchRequest request);

  Future<MatchResponse> getMoreMatches(MatchPageRequest request);
}

class HttpMatchApiService implements MatchApiService {
  HttpMatchApiService({http.Client? client, String? baseUrl})
    : _client = client ?? http.Client(),
      _baseUrl = (baseUrl ?? ApiConfig.matchingBaseUrl).replaceFirst(RegExp(r'/$'), '');

  final http.Client _client;
  final String _baseUrl;

  static const _timeout = Duration(seconds: 12);

  @override
  Future<MatchResponse> findMatches(MatchRequest request) =>
      _post('/api/v1/match', request.toJson());

  @override
  Future<MatchResponse> getMoreMatches(MatchPageRequest request) =>
      _post('/api/v1/match/more', request.toJson());

  Future<MatchResponse> _post(String path, Map<String, dynamic> body) async {
    try {
      final response = await _client
          .post(
            Uri.parse('$_baseUrl$path'),
            headers: const {'Content-Type': 'application/json'},
            body: jsonEncode(body),
          )
          .timeout(_timeout);

      if (kDebugMode) {
        debugPrint('[MATCH API] $path status=${response.statusCode}');
        debugPrint('[MATCH API] response=${response.body}');
      }

      Map<String, dynamic>? decoded;
      if (response.body.trim().isNotEmpty) {
        final value = jsonDecode(response.body);
        if (value is! Map) throw const FormatException('Response is not an object');
        decoded = Map<String, dynamic>.from(value);
      }
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw MatchApiException.fromResponse(response.statusCode, decoded);
      }
      if (decoded == null) {
        throw const FormatException('Response body is empty');
      }
      try {
        return MatchResponse.fromJson(decoded);
      } on FormatException catch (error, stackTrace) {
        if (kDebugMode) {
          debugPrint('[MATCH API] response parsing failed: $error');
          debugPrint('$stackTrace');
        }
        rethrow;
      }
    } on MatchApiException {
      rethrow;
    } on TimeoutException {
      throw MatchApiException(
        statusCode: 0,
        code: 'timeout',
        message: 'Matching request timed out. Please try again.',
      );
    } on SocketException {
      throw MatchApiException(
        statusCode: 0,
        code: 'connection_failed',
        message: 'Matching service is unavailable. Please check your connection.',
      );
    } on FormatException catch (error, stackTrace) {
      if (kDebugMode) {
        debugPrint('[MATCH API] invalid response field/type: $error');
        debugPrint('$stackTrace');
      }
      throw MatchApiException(
        statusCode: 0,
        code: 'invalid_response',
        message: 'The matching service returned an invalid response.',
      );
    } catch (_) {
      throw MatchApiException(
        statusCode: 0,
        code: 'network_error',
        message: 'Unable to contact the matching service. Please try again.',
      );
    }
  }
}

class MatchApiException implements Exception {
  MatchApiException({required this.statusCode, required this.message, this.code});

  final int statusCode;
  final String message;
  final String? code;

  factory MatchApiException.fromResponse(
    int statusCode,
    Map<String, dynamic>? body,
  ) {
    final error = body?['error'];
    final errorMap = error is Map ? Map<String, dynamic>.from(error) : null;
    return MatchApiException(
      statusCode: statusCode,
      code: errorMap?['code'] as String?,
      message: errorMap?['message'] as String? ?? _defaultMessage(statusCode),
    );
  }

  static String _defaultMessage(int statusCode) => switch (statusCode) {
    400 => 'Invalid request',
    401 => 'Authentication required',
    403 => 'Not allowed',
    404 => 'Matching service or resource not found',
    429 => 'Too many requests',
    _ => 'Matching service unavailable',
  };

  @override
  String toString() => 'MatchApiException($statusCode): $message';
}
