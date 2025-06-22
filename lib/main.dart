// lib/main.dart
import 'package:flutter/material.dart';
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
        
        // Theme configuration
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        
        // Router configuration
        routerConfig: AppRouter.router,
        
        // Locale configuration
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('es', 'MX'),
        ],
        
        // App-wide builder for additional configuration
        builder: (context, child) {
          return MediaQuery(
            // Ensure text scaling doesn't break the UI
            data: MediaQuery.of(context).copyWith(
              textScaler: MediaQuery.of(context).textScaler.clamp(
                minScaleFactor: 0.8,
                maxScaleFactor: 1.2,
              ),
            ),
            child: child!,
          );
        },
      ),
    );
  }
}