// lib/features/auth/presentation/widgets/register/register_form.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:techinng/features/auth/presentation/states/auth_state.dart';
import 'package:techinng/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:techinng/shared/styles/app_colors.dart';
import 'package:techinng/shared/styles/app_text_styles.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

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
        borderRadius: BorderRadius.circular(24),
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
            borderRadius: BorderRadius.circular(24),
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

  void _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    final authViewModel = context.read<AuthViewModel>();
    
    // Usar parámetros nombrados como espera tu AuthViewModel
    await authViewModel.register(
      username: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    // El state listening se maneja en register_screen.dart
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
        );
      },
    );
  }
}