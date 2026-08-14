class ApiConfig {
  ApiConfig._();

  /// Android emulators reach the development machine through 10.0.2.2.
  /// Override with --dart-define=MATCHING_API_BASE_URL=... for a device or
  /// production deployment.
  static const matchingBaseUrl = String.fromEnvironment(
    'MATCHING_API_BASE_URL',
    defaultValue: 'http://10.0.2.2:8000',
  );
}
