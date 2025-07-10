// lib/features/auth/presentation/pages/register_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:techinng/features/auth/presentation/states/auth_state.dart';
import 'package:techinng/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:techinng/features/auth/presentation/widgets/register/register_form.dart';
import 'package:techinng/features/auth/presentation/widgets/register/register_login_link.dart';
import 'package:techinng/features/auth/presentation/widgets/register/register_logo.dart';
import 'package:techinng/features/auth/presentation/widgets/register/register_title.dart';
import 'package:techinng/shared/navigation/route_names.dart';
// Asegúrate de importar el widget de éxito
// import 'package:techinng/shared/widgets/success_message_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _showSuccessMessage = false;

  @override
  void initState() {
    super.initState();
    // Escuchar cambios en el AuthViewModel
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authViewModel = context.read<AuthViewModel>();
      authViewModel.addListener(_onAuthStateChanged);
      print('RegisterScreen: Listener added');
    });
  }

  @override
  void dispose() {
    try {
      final authViewModel = context.read<AuthViewModel>();
      authViewModel.removeListener(_onAuthStateChanged);
      print('RegisterScreen: Listener removed');
    } catch (e) {
      print('RegisterScreen dispose error: $e');
    }
    super.dispose();
  }

  void _onAuthStateChanged() async {
    final authState = context.read<AuthViewModel>().state;
    print('RegisterScreen - State changed: $authState');
    
    try {
      if (authState.isRegistrationSuccess) {
        print('Registration successful! Showing success message...');
        
        setState(() {
          _showSuccessMessage = true;
        });

        // Esperar 2 segundos y luego navegar al login
        await Future.delayed(const Duration(seconds: 2));
        
        if (mounted) {
          print('Navigating to login...');
          // Limpiar el estado de autenticación
          context.read<AuthViewModel>().clearAuthState();
          
          // Navegar al login
          context.go(RouteNames.login);
        }
      } else if (authState.hasError) {
        print('Registration error: ${authState.errorMessage}');
        
        // Mostrar error
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(authState.errorMessage ?? 'Error al crear la cuenta'),
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

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8F8),
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            // Contenido principal
            SafeArea(
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
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          RegisterLogo(),
                          SizedBox(height: 20),
                          RegisterTitle(),
                          SizedBox(height: 32),
                          RegisterForm(), // Ya contiene el botón integrado
                          SizedBox(height: 16),
                          RegisterLoginLink(),
                        ],
                      ),
                    ),
                  );
                },
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
                          "¡Registro Exitoso!",
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
                          "Tu cuenta ha sido creada correctamente.\nRedirigiendo al login...",
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
                      'RegSuccess: ${authViewModel.state.isRegistrationSuccess}\n'
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
      ),
    );
  }
}