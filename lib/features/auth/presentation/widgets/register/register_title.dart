import 'package:flutter/material.dart';
import 'package:techinng/shared/styles/app_text_styles.dart';

class RegisterTitle extends StatelessWidget {
  const RegisterTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Register now',
          style: AppTextStyles.headlineLarge.copyWith(fontSize: 36),
        ),
        const SizedBox(height: 8),
        Text(
          'Practice your most important skills!',
          style: AppTextStyles.bodyMedium.copyWith(color: Colors.black87),
        ),
      ],
    );
  }
}
