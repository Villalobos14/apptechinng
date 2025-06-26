import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/config/app_config.dart';
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
      child: MaterialApp.router(
        title: 'Soft Skills App',
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
      ),
    );
  }
}
