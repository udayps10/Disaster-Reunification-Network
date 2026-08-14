import 'package:flutter/material.dart';
import '../../../core/common_widgets/app_button.dart';
import '../../../core/common_widgets/app_text_field.dart';
import '../../../features/matching/data/models/match_request.dart';

class SearchFormScreen extends StatefulWidget {
  const SearchFormScreen({super.key});

  @override
  State<SearchFormScreen> createState() => _SearchFormScreenState();
}

class _SearchFormScreenState extends State<SearchFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

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
                    const Text('Upload Photo (Highly Recommended)', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              AppTextField(
                label: 'Full Name (Required)',
                hint: 'Enter full name',
                controller: _nameController,
                validator: (val) => val == null || val.isEmpty ? 'Name is required' : null,
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Age (Required)',
                hint: 'Enter age',
                keyboardType: TextInputType.number,
                controller: _ageController,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Age is required';
                  if (int.tryParse(val) == null) return 'Enter a valid number';
                  return null;
                },
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
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushReplacementNamed(
                      context,
                      '/results',
                      arguments: MatchRequest(
                        name: _nameController.text.trim(),
                        age: int.parse(_ageController.text),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}
