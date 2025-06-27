import 'package:flutter/material.dart';
import 'package:techinng/features/auth/presentation/widgets/register/register_button.dart';
import 'package:techinng/features/auth/presentation/widgets/register/register_form.dart';
import 'package:techinng/features/auth/presentation/widgets/register/register_logo.dart';
import 'package:techinng/features/auth/presentation/widgets/register/register_login_link.dart';
import 'package:techinng/features/auth/presentation/widgets/register/register_title.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Color(0xFFF8F8F8), // <- fondo más suave tipo Figma
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 30,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 30,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const [
                      RegisterLogo(),
                      SizedBox(height: 20),
                      RegisterTitle(),
                      SizedBox(height: 32),
                      RegisterForm(),
                      SizedBox(height: 24),
                      RegisterButton(),
                      SizedBox(height: 16),
                      RegisterLoginLink(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
