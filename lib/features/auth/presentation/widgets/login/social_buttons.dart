// lib/features/auth/presentation/widgets/login/social_buttons.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:techinng/features/auth/presentation/states/auth_state.dart';
import 'package:techinng/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:techinng/shared/styles/app_text_styles.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({Key? key}) : super(key: key);

  Widget _button({
    required String asset,
    required String label,
    required VoidCallback onPressed,
    required bool isLoading,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.grey.shade300),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: Colors.white,
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(asset, height: 20),
                  const SizedBox(width: 8),
                  Text(label, style: AppTextStyles.bodyMedium),
                ],
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, authViewModel, child) {
        final isLoading = authViewModel.state.isLoading;
        
        return Column(
          children: [
            // Separador + texto
            Row(
              children: [
                const Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'Or sign with',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                const Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 12),
            _button(
              asset: 'assets/images/google.png',
              label: 'Google',
              onPressed: () async {
                await authViewModel.signInWithGoogle();
              },
              isLoading: isLoading,
            ),
            const SizedBox(height: 8),
            _button(
              asset: 'assets/images/apple.png',
              label: 'Apple',
              onPressed: () {
                // TODO: Implementar Apple Sign In cuando esté disponible
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Apple Sign In coming soon!'),
                    backgroundColor: Colors.orange,
                  ),
                );
              },
              isLoading: false, // Apple no está implementado aún
            ),
          ],
        );
      },
    );
  }
}