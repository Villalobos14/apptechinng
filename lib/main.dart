// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/config/app_config.dart';
import 'features/auth/presentation/view_models/auth_view_model.dart';
import 'shared/navigation/app_router.dart';
import 'shared/styles/app_theme.dart';

void main() {
  runApp(const SoftSkillsApp());
}

class SoftSkillsApp extends StatelessWidget {
  const SoftSkillsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppConfig.providers,
      child: const AppInitializer(),
    );
  }
}

/// Widget que maneja la inicialización de la app de forma controlada
class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  @override
  void initState() {
    super.initState();
    // Inicializar AuthViewModel después de que el widget tree esté listo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeApp();
    });
  }

  Future<void> _initializeApp() async {
    try {
      // Obtener AuthViewModel y inicializarlo manualmente
      final authViewModel = context.read<AuthViewModel>();
      await authViewModel.initialize();
      debugPrint('✅ App initialization completed');
    } catch (e) {
      debugPrint('❌ App initialization failed: $e');
      // La app puede continuar funcionando sin auth inicial
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,

      // Temas claros y oscuros
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,

      // Ruta inicial desde AppRouter
      routerConfig: AppRouter.router,

      // Idiomas compatibles
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('es', 'MX'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // Asegura escalado de texto correcto
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: MediaQuery.of(context).textScaler.clamp(
            minScaleFactor: 0.8,
            maxScaleFactor: 1.2,
          ),
        ),
        child: child!,
      ),
    );
  }
}