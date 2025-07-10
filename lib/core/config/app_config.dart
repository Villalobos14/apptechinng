// lib/core/config/app_config.dart

import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../network/dio_config.dart';

// Auth imports
import '../../features/auth/data/data_sources/auth_remote_data_source.dart';
import '../../features/auth/data/data_sources/auth_local_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/use_cases/login_use_case.dart';
import '../../features/auth/domain/use_cases/register_use_case.dart';
import '../../features/auth/domain/use_cases/google_sign_in_use_case.dart';
import '../../features/auth/domain/use_cases/logout_use_case.dart';
import '../../features/auth/domain/use_cases/get_current_user_use_case.dart';
import '../../features/auth/presentation/view_models/auth_view_model.dart';

class AppConfig {
  static const String appName = 'Soft Skills App';
  static const String appVersion = '1.0.0';

  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://teching.tech',
  );

  static const bool isProduction = bool.fromEnvironment(
    'PRODUCTION',
    defaultValue: false,
  );

  /// Providers organizados por capas para evitar dependencias circulares
  static List<SingleChildWidget> get providers => [
    // ═══════════════════════════════════════════════════════════
    // 🔧 CORE LAYER - Infraestructura básica
    // ═══════════════════════════════════════════════════════════
    ...coreProviders,
    
    // ═══════════════════════════════════════════════════════════
    // 🔐 AUTH FEATURE - Sistema de autenticación
    // ═══════════════════════════════════════════════════════════
    ...authProviders,
    
    // ═══════════════════════════════════════════════════════════
    // 🎯 FUTURE FEATURES - Preparado para expansión
    // ═══════════════════════════════════════════════════════════
    // TODO: Uncomment as you implement these features
    // ...practiceProviders,
    // ...homeProviders,
    // ...profileProviders,
  ];

  /// Core infrastructure providers
  static List<SingleChildWidget> get coreProviders => [
    // Network layer
    Provider<Dio>(
      create: (_) => DioConfig.createDio(),
      lazy: false, // Eager loading for critical infrastructure
    ),

    // Secure storage
    Provider<FlutterSecureStorage>(
      create: (_) => const FlutterSecureStorage(
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        ),
        iOptions: IOSOptions(
          accessibility: KeychainAccessibility.first_unlock_this_device,
        ),
      ),
      lazy: false,
    ),

    // Google Sign In
    Provider<GoogleSignIn>(
      create: (_) => GoogleSignIn(
        scopes: ['email', 'profile'],
        // TODO: Add your Google Sign In configuration
        // clientId: 'your-google-client-id',
      ),
      lazy: false,
    ),
  ];

  /// Auth feature providers
  static List<SingleChildWidget> get authProviders => [
    // Data Sources - ✅ USAR IMPLEMENTACIONES CONCRETAS
    ProxyProvider<Dio, AuthRemoteDataSource>(
      update: (context, dio, _) => AuthRemoteDataSourceImpl( // ← CAMBIO: Usar la implementación
        dio: dio,
      ),
    ),
  
    ProxyProvider<FlutterSecureStorage, AuthLocalDataSource>(
      update: (context, storage, _) => AuthLocalDataSourceImpl( // ← CAMBIO: Usar la implementación
        secureStorage: storage,
      ),
    ),

    // Repository
    ProxyProvider2<AuthRemoteDataSource, AuthLocalDataSource, AuthRepository>(
      update: (context, remote, local, _) => AuthRepositoryImpl(
        remoteDataSource: remote,
        localDataSource: local
        // localDataSource: local, // ← Opcional por ahora
      ),
    ),

    // Use Cases
    ProxyProvider<AuthRepository, LoginUseCase>(
      update: (context, repo, _) => LoginUseCase(repo),
    ),
    
    ProxyProvider<AuthRepository, RegisterUseCase>(
      update: (context, repo, _) => RegisterUseCase(repo),
    ),
    
    ProxyProvider<AuthRepository, GoogleSignInUseCase>(
      update: (context, repo, _) => GoogleSignInUseCase(repo),
    ),
    
    ProxyProvider<AuthRepository, LogoutUseCase>(
      update: (context, repo, _) => LogoutUseCase(repo),
    ),
    
    ProxyProvider<AuthRepository, GetCurrentUserUseCase>(
      update: (context, repo, _) => GetCurrentUserUseCase(repo),
    ),

    // View Model - ✅ USAR ChangeNotifierProxyProvider
    ChangeNotifierProxyProvider5<LoginUseCase, RegisterUseCase, GoogleSignInUseCase, 
                                 LogoutUseCase, GetCurrentUserUseCase, AuthViewModel>(
      create: (context) => AuthViewModel(
        loginUseCase: context.read<LoginUseCase>(),
        registerUseCase: context.read<RegisterUseCase>(),
        googleSignInUseCase: context.read<GoogleSignInUseCase>(),
        logoutUseCase: context.read<LogoutUseCase>(),
        getCurrentUserUseCase: context.read<GetCurrentUserUseCase>(),
      ),
      update: (context, login, register, google, logout, getCurrentUser, previous) {
        // Reutilizar la instancia anterior si existe para mantener el estado
        if (previous != null) return previous;
        
        return AuthViewModel(
          loginUseCase: login,
          registerUseCase: register,
          googleSignInUseCase: google,
          logoutUseCase: logout,
          getCurrentUserUseCase: getCurrentUser,
        );
      },
    ),
  ];

  // ═══════════════════════════════════════════════════════════
  // 🚀 FUTURE FEATURES - Templates ready for implementation
  // ═══════════════════════════════════════════════════════════
  
  /// Practice feature providers (TODO: Implement when ready)
  static List<SingleChildWidget> get practiceProviders => [
    // Example structure:
    // ProxyProvider<Dio, PracticeRemoteDataSource>(...),
    // ProxyProvider<PracticeRepository, GetPracticeSessionsUseCase>(...),
    // ChangeNotifierProxyProvider<GetPracticeSessionsUseCase, PracticeViewModel>(...),
  ];

  /// Home feature providers (TODO: Implement when ready)
  static List<SingleChildWidget> get homeProviders => [
    // Example structure:
    // ProxyProvider<AuthRepository, GetDashboardDataUseCase>(...),
    // ChangeNotifierProxyProvider<GetDashboardDataUseCase, HomeViewModel>(...),
  ];

  /// Profile feature providers (TODO: Implement when ready)
  static List<SingleChildWidget> get profileProviders => [
    // Example structure:
    // ProxyProvider<AuthRepository, UpdateProfileUseCase>(...),
    // ChangeNotifierProxyProvider<UpdateProfileUseCase, ProfileViewModel>(...),
  ];
}