import 'package:flutter/material.dart';
import '../../../core/common_widgets/app_button.dart';
import '../../../core/common_widgets/app_text_field.dart';

class SearchFormScreen extends StatefulWidget {
  const SearchFormScreen({super.key});

  @override
  State<SearchFormScreen> createState() => _SearchFormScreenState();
}

class _SearchFormScreenState extends State<SearchFormScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Missing Person Details')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter as much information as possible to help our AI find a match.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              Center(
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: const Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    const Text('Upload Photo (Required)', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const AppTextField(
                label: 'Full Name',
                hint: 'Enter full name',
              ),
              const SizedBox(height: 16),
              const AppTextField(
                label: 'Age',
                hint: 'Enter age',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              const AppTextField(
                label: 'Last Known Location (Optional)',
                hint: 'Where was the person last seen?',
              ),
              const SizedBox(height: 16),
              const AppTextField(
                label: 'Additional Identifying Info (Optional)',
                hint: 'Tattoos, birthmarks, clothing, etc.',
                maxLines: 3,
              ),
              const SizedBox(height: 32),
              AppButton(
                text: 'Find Matches',
                onPressed: () {
                  // In a real app, validate form first
                  _showLoadingDialog();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 24),
              const Text('Analyzing records...', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text(
                'Comparing the information you provided with verified disaster records.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        );
      },
    );

    // Mock delay before showing results
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pop(context); // Close dialog
      Navigator.pushReplacementNamed(context, '/results');
    });
  }
}
