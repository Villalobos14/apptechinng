import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'route_names.dart';
import '../../features/onboarding/presentation/pages/onboarding_screen.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_screen.dart';
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
      GoRoute(
        path: RouteNames.register,
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),

      // ──────────────────────────────────────────────────────────
      // 📝 TODO: ROUTES TO IMPLEMENT LATER
      // ──────────────────────────────────────────────────────────

      /* 
      // ─── Auth Routes (TODO: Implement when auth feature is ready) ───
      GoRoute(
        path: RouteNames.register,
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: RouteNames.forgotPassword,
        name: 'forgot-password',
        builder: (context, state) => const ForgotPasswordPage(),
      ),

      // ─── Welcome Route (TODO: Implement when welcome page is ready) ───
      GoRoute(
        path: RouteNames.welcome,
        name: 'welcome',
        builder: (context, state) => const WelcomePage(),
      ),

      // ─── Profile Routes (TODO: Implement when profile feature is ready) ───
      GoRoute(
        path: RouteNames.profile,
        name: 'profile',
        builder: (context, state) => const ProfilePage(),
      ),

      // ─── Practice Sub-Routes (TODO: Implement when practice features are ready) ───
      GoRoute(
        path: RouteNames.practiceMain,
        name: 'practice-main',
        builder: (context, state) => const PracticeMainPage(),
      ),

      // ─── Soft Skills Practice Routes ───
      GoRoute(
        path: RouteNames.learningJourney,
        name: 'learning-journey',
        builder: (context, state) => const LearningJourneyPage(),
      ),
      GoRoute(
        path: RouteNames.specifyScenario,
        name: 'specify-scenario',
        builder: (context, state) => const SpecifyScenarioPage(),
      ),
      GoRoute(
        path: RouteNames.randomPractice,
        name: 'random-practice',
        builder: (context, state) => const RandomPracticePage(),
      ),

      // ─── Skills Assessment Routes ───
      GoRoute(
        path: RouteNames.diagnosticTest,
        name: 'diagnostic-test',
        builder: (context, state) => const DiagnosticTestPage(),
      ),

      // ─── Interview Ready Routes ───
      GoRoute(
        path: RouteNames.behavioralInterview,
        name: 'behavioral-interview',
        builder: (context, state) => const BehavioralInterviewPage(),
      ),
      GoRoute(
        path: RouteNames.structuredInterview,
        name: 'structured-interview',
        builder: (context, state) => const StructuredInterviewPage(),
      ),
      GoRoute(
        path: RouteNames.roleSpecific,
        name: 'role-specific',
        builder: (context, state) => const RoleSpecificPage(),
      ),
      GoRoute(
        path: RouteNames.fullInterview,
        name: 'full-interview',
        builder: (context, state) => const FullInterviewPage(),
      ),
      */
    ],
    errorBuilder: (ctx, state) => Scaffold(
      body: Center(child: Text('Route not found')),
    ),
  );
}
