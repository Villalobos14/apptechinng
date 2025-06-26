import 'package:flutter/material.dart';

class RegisterLogo extends StatelessWidget {
  const RegisterLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/apple.png', height: 30),
        const SizedBox(height: 16),
        Image.asset('assets/images/register.png', height: 250),
      ],
    );
  }
}
