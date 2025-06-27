import 'package:flutter/material.dart';
import 'package:techinng/shared/styles/app_text_styles.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  String _confirmPassword = '';

  bool get _match =>
      _passwordController.text == _confirmPassword &&
      _confirmPassword.isNotEmpty;

  Widget _styledInput(
    String hint, {
    bool obscure = false,
    TextEditingController? controller,
    void Function(String)? onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        obscureText: obscure,
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black54),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(color: Color(0xFFE0E0E0), width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black, width: 1.5),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _styledInput('Username', controller: _usernameController),
        _styledInput('Password',
            obscure: true, controller: _passwordController),
        _styledInput(
          'Confirm Password',
          obscure: true,
          controller: _confirmController,
          onChanged: (val) => setState(() => _confirmPassword = val),
        ),
        if (_confirmPassword.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              _match ? 'Passwords match' : 'Passwords do not match',
              style: AppTextStyles.bodySmall.copyWith(
                color: _match ? Colors.green : Colors.red,
              ),
            ),
          ),
      ],
    );
  }
}
