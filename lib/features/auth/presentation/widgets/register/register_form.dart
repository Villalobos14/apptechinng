import 'package:flutter/material.dart';
import 'package:techinng/shared/styles/app_text_styles.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _passwordController = TextEditingController();
  String _confirmPassword = '';

  bool get _match =>
      _passwordController.text == _confirmPassword && _confirmPassword.isNotEmpty;

  Widget _input(String hint, {bool obscure = false, TextEditingController? controller, void Function(String)? onChanged}) {
    return TextField(
      obscureText: obscure,
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _input('Username'),
        const SizedBox(height: 12),
        _input('Password', obscure: true, controller: _passwordController),
        const SizedBox(height: 12),
        _input(
          'Confirm Password',
          obscure: true,
          onChanged: (val) => setState(() => _confirmPassword = val),
        ),
        const SizedBox(height: 6),
        if (_confirmPassword.isNotEmpty)
          Text(
            _match ? 'Passwords must match' : 'Passwords do not match',
            style: AppTextStyles.bodySmall.copyWith(color: _match ? Colors.green : Colors.red),
          ),
      ],
    );
  }
}
