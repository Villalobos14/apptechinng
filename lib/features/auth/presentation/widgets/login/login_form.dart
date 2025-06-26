// lib/features/auth/presentation/widgets/login/login_form.dart

import 'package:flutter/material.dart';
import 'package:techinng/shared/styles/app_colors.dart';
import 'package:techinng/shared/styles/app_text_styles.dart';

class LoginForm extends StatelessWidget {
  final VoidCallback onLogin;
  const LoginForm({Key? key, required this.onLogin}) : super(key: key);

  Widget _fieldMock(String hint) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(24), // 8px unificado
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      alignment: Alignment.centerLeft,
      child: Text(
        hint,
        style: AppTextStyles.bodyMedium.copyWith(
          color: Colors.grey.shade600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _fieldMock('Username'),
        const SizedBox(height: 12),
        _fieldMock('Password'),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: onLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24), // 8px unificado
              ),
            ),
            child: Text(
              'Login',
              style: AppTextStyles.labelLarge.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
