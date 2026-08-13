import 'package:flutter/material.dart';
import '../../../core/common_widgets/app_button.dart';
import '../../../core/theme/app_theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.people_alt, size: 100, color: AppTheme.primaryColor),
              const SizedBox(height: 32),
              const Text(
                'Welcome to DisasterConnect',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Connecting families with their loved ones during challenging times.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 48),
              AppButton(
                text: 'Login as Normal User',
                onPressed: () => Navigator.pushNamed(context, '/login_normal'),
              ),
              const SizedBox(height: 16),
              AppButton(
                text: 'Login as Official',
                color: AppTheme.secondaryColor,
                onPressed: () => Navigator.pushNamed(context, '/login_official'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
