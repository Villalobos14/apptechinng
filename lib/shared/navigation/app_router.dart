// lib/shared/navigation/app_router.dart
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import 'route_names.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_screen.dart';
import '../widgets/common/placeholder_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.onboarding,
    routes: [
      // ──────────────────────────────────────────────────────────
      // 🚀 ONBOARDING ROUTE (Working)
      // ──────────────────────────────────────────────────────────
      GoRoute(
        path: RouteNames.onboarding,
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      
      // ──────────────────────────────────────────────────────────
      // 🏠 MAIN ROUTES (Working)
      // ──────────────────────────────────────────────────────────
      GoRoute(
        path: RouteNames.home,
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),

      // Basic navigation placeholder pages (for bottom nav)
      GoRoute(
        path: RouteNames.tasks,
        name: 'tasks',
        builder: (context, state) => const PlaceholderPage(
          title: 'Tasks',
          subtitle: 'Your pending tasks will appear here',
          icon: Icons.task_alt_rounded,
        ),
      ),
      GoRoute(
        path: RouteNames.practice,
        name: 'practice',
        builder: (context, state) => const PlaceholderPage(
          title: 'Practice',
          subtitle: 'Choose your practice mode',
          icon: Icons.psychology_rounded,
        ),
      ),
      GoRoute(
        path: RouteNames.history,
        name: 'history',
        builder: (context, state) => const PlaceholderPage(
          title: 'History',
          subtitle: 'Your practice history and progress',
          icon: Icons.history_rounded,
        ),
      ),
      GoRoute(
        path: RouteNames.resources,
        name: 'resources',
        builder: (context, state) => const PlaceholderPage(
          title: 'Resources',
          subtitle: 'Educational videos and materials',
          icon: Icons.video_library_rounded,
        ),
      ),

      // ──────────────────────────────────────────────────────────
      // 📝 TODO: ROUTES TO IMPLEMENT LATER
      // ──────────────────────────────────────────────────────────
      
      /* 
      // ─── Auth Routes (TODO: Implement when auth feature is ready) ───
      GoRoute(
        path: RouteNames.login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RouteNames.register,
        name: 'register',
        builder: (context, state) => const RegisterPage(),
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
    
    // Error handling - redirect unknown routes to onboarding
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.explore_off_rounded, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'Route under development',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'This feature will be available soon!',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => context.go(RouteNames.home),
              icon: const Icon(Icons.home_rounded),
              label: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
  
  // ──────────────────────────────────────────────────────────
  // 🔧 DEVELOPMENT HELPERS
  // ──────────────────────────────────────────────────────────
  
  /// Check if a route is currently implemented
  static bool isRouteImplemented(String route) {
    const implementedRoutes = [
      RouteNames.onboarding,  // ✅ Now implemented
      RouteNames.home,
      RouteNames.tasks,
      RouteNames.practice,
      RouteNames.history,
      RouteNames.resources,
    ];
    return implementedRoutes.contains(route);
  }
  
  /// Get all routes that need to be implemented
  static List<String> get todoRoutes => [
    RouteNames.login,
    RouteNames.register,
    RouteNames.welcome,
    RouteNames.profile,
    RouteNames.learningJourney,
    RouteNames.diagnosticTest,
    RouteNames.behavioralInterview,
    RouteNames.structuredInterview,
    RouteNames.fullInterview,
    // Add more as needed...
  ];
}