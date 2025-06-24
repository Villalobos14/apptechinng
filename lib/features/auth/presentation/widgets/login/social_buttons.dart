import 'package:flutter/material.dart';
import 'package:techinng/shared/styles/app_text_styles.dart';
import 'package:techinng/shared/styles/app_colors.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({Key? key}) : super(key: key);

  Widget _button(String asset, String label) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.grey.shade300),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)),
          backgroundColor: Colors.white,
        ),
        child: Row(
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
                style:
                    AppTextStyles.bodySmall.copyWith(color: Colors.grey.shade600),
              ),
            ),
            const Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 12),
        _button('assets/images/google.png', 'Google'),
        const SizedBox(height: 8),
        _button('assets/images/apple.png', 'Apple'),
      ],
    );
  }
}
