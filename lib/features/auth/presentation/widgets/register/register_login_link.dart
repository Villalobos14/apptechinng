import 'package:flutter/material.dart';
import 'package:techinng/shared/styles/app_text_styles.dart';

class RegisterLoginLink extends StatelessWidget {
  const RegisterLoginLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          text: 'Do you already have an account? ',
          style: AppTextStyles.bodySmall,
          children: [
            TextSpan(
              text: 'Log in',
              style: AppTextStyles.bodySmall.copyWith(color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
