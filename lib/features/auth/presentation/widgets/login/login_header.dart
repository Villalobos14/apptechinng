import 'package:flutter/material.dart';
import 'package:techinng/shared/styles/app_text_styles.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),

        // Logo
        Image.asset('assets/images/apple.png', height: 30),

        const SizedBox(height: 16),

        // Ilustración principal
        Image.asset('assets/images/login.png', height: 200),

        const SizedBox(height: 16),

        // Título escalable
        SizedBox(
          width: double.infinity,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Welcome Back!',
              style:
                  AppTextStyles.headlineLarge.copyWith(fontSize: 48),
            ),
          ),
        ),

        const SizedBox(height: 8),

        // Subtítulo
        Text(
          "We're glad to have you back to learn!",
          style: AppTextStyles.bodyMedium.copyWith(color: Colors.black87),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
