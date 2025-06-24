import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'route_names.dart';
import '../../features/onboarding/presentation/pages/onboarding_screen.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../widgets/common/main_shell.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.onboarding,
    routes: [
      GoRoute(
        path: RouteNames.onboarding,
        builder: (_, __) => const OnboardingScreen(),
      ),
      GoRoute(
        path: RouteNames.login,
        builder: (_, __) => const LoginPage(),
      ),
      // Ya no usamos ShellRoute ni rutas individuales:
      GoRoute(
        path: RouteNames.home,
        builder: (_, __) => const MainShell(),
      ),
    ],
    errorBuilder: (ctx, state) => Scaffold(
      body: Center(child: Text('Route not found')),
    ),
  );
}
