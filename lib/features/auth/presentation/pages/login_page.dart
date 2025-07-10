// lib/features/auth/presentation/pages/login_page.dart

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:provider/provider.dart';
import 'package:techinng/features/auth/presentation/states/auth_state.dart';
import 'package:techinng/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:techinng/features/auth/presentation/widgets/login/login_form.dart';
import 'package:techinng/features/auth/presentation/widgets/login/login_header.dart';
import 'package:techinng/features/auth/presentation/widgets/login/social_buttons.dart';
import 'package:techinng/shared/navigation/route_names.dart';
import 'package:techinng/shared/styles/app_colors.dart';
import 'package:techinng/shared/styles/app_text_styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LiquidController _liquidController = LiquidController();
  bool _showSuccessMessage = false;
  
  @override
  void initState() {
    super.initState();
    // Escuchar cambios en el AuthViewModel
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authViewModel = context.read<AuthViewModel>();
      authViewModel.addListener(_onAuthStateChanged);
      print('LoginPage: Listener added');
    });
  }

  @override
  void dispose() {
    try {
      final authViewModel = context.read<AuthViewModel>();
      authViewModel.removeListener(_onAuthStateChanged);
      print('LoginPage: Listener removed');
    } catch (e) {
      print('LoginPage dispose error: $e');
    }
    super.dispose();
  }

  void _onAuthStateChanged() async {
    final authState = context.read<AuthViewModel>().state;
    print('LoginPage - State changed: $authState');
    
    try {
      if (authState.isAuthenticated) {
        print('Login successful! Showing success message...');
        
        // Login exitoso - mostrar mensaje de éxito
        setState(() {
          _showSuccessMessage = true;
        });

        // Esperar 1.5 segundos para el feedback visual
        await Future.delayed(const Duration(milliseconds: 1500));
        
        if (mounted) {
          setState(() {
            _showSuccessMessage = false;
          });
          
          print('Starting liquid animation...');
          // Activar animación líquida
          _onLoginPressed();
        }
      } else if (authState.hasError) {
        print('Login error: ${authState.errorMessage}');
        
        // Mostrar error
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(authState.errorMessage ?? 'Credenciales incorrectas'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              duration: const Duration(seconds: 5),
            ),
          );
        }
      }
    } catch (e) {
      print('Error in _onAuthStateChanged: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error inesperado: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void _onLoginPressed() {
    try {
      print('Animating to page 1...');
      // Disparar la animación líquida a la página en blanco
      _liquidController.animateToPage(
        page: 1,
        duration: 300,
      );
    } catch (e) {
      print('Error in _onLoginPressed: $e');
      // Si la animación falla, navegar directamente
      if (mounted) {
        context.go(RouteNames.home);
      }
    }
  }

  void _onPageChanged(int page) {
    print('Page changed to: $page');
    if (page == 1) {
      // Tras la animación, navegamos al Home
      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted) {
          print('Navigating to home...');
          context.go(RouteNames.home);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const horizontal = 24.0, vertical = 16.0;

    // Página 0: contenido del login
    final loginContent = SafeArea(
      child: Stack(
        children: [
          // Contenido principal
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: horizontal,
              vertical: vertical,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const LoginHeader(),
                const SizedBox(height: 16),
                LoginForm(onLogin: () {}), // El callback ya no se necesita
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
          
          // Overlay de mensaje de éxito - Versión temporal sin widget personalizado
          if (_showSuccessMessage)
            Container(
              color: Colors.black54,
              child: Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Icono de éxito
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check_circle,
                          size: 32,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Título
                      const Text(
                        "¡Bienvenido!",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      
                      // Mensaje
                      const Text(
                        "Autenticación exitosa",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          
          // Debug info - Remover en producción
          Positioned(
            top: 50,
            right: 16,
            child: Consumer<AuthViewModel>(
              builder: (context, authViewModel, child) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'State: ${authViewModel.state.runtimeType}\n'
                    'Loading: ${authViewModel.state.isLoading}\n'
                    'Auth: ${authViewModel.state.isAuthenticated}\n'
                    'Error: ${authViewModel.state.hasError}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
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