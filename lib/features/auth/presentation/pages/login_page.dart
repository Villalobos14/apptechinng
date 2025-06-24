// lib/features/auth/presentation/pages/login_page.dart

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:go_router/go_router.dart';

import 'package:techinng/features/auth/presentation/widgets/login/login_header.dart';
import 'package:techinng/features/auth/presentation/widgets/login/login_form.dart';
import 'package:techinng/features/auth/presentation/widgets/login/social_buttons.dart';
import 'package:techinng/shared/navigation/route_names.dart';
import 'package:techinng/shared/styles/app_text_styles.dart';
import 'package:techinng/shared/styles/app_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LiquidController _liquidController = LiquidController();

  void _onLoginPressed() {
    // Disparar la animación líquida a la página en blanco
    _liquidController.animateToPage(
      page: 1,
      duration: 300, // más rápido para mayor fluidez
    );
  }

  void _onPageChanged(int page) {
    if (page == 1) {
      // Tras la animación, navegamos al Home
      Future.delayed(const Duration(milliseconds: 200), () {
        context.go(RouteNames.home);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const horizontal = 24.0, vertical = 16.0;

    // Página 0: contenido del login
    final loginContent = SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const LoginHeader(),
            const SizedBox(height: 16),
            LoginForm(onLogin: _onLoginPressed),
            const Spacer(),
            const SocialButtons(),
            const SizedBox(height: 12),
            Center(
              child: RichText(
                text: TextSpan(
                  style: AppTextStyles.bodySmall.copyWith(color: Colors.black87),
                  children: [
                    const TextSpan(text: "Don't have an account? "),
                    TextSpan(
                      text: 'Register',
                      style: AppTextStyles.labelLarge.copyWith(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => context.go(RouteNames.register),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );

    // Página 1: contenedor en blanco para el efecto
    final blankPage = Container(color: Colors.white);

    return Scaffold(
      body: LiquidSwipe(
        pages: [loginContent, blankPage],
        liquidController: _liquidController,

        // ─── Desactivar todo gesto de usuario ─────────────────
        disableUserGesture: true,
        ignoreUserGestureWhileAnimating: true,

        // ─── Configuración de animación ───────────────────────
        enableLoop: false,
        enableSideReveal: false,
        fullTransitionValue: 300,
        waveType: WaveType.circularReveal,

        // ─── Ocultamos la flechita flotante ───────────────────
        slideIconWidget: null,

        onPageChangeCallback: _onPageChanged,
      ),
    );
  }
}
