import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import '../network/dio_config.dart';

class AppConfig {
  static const String appName = 'Soft Skills App';
  static const String appVersion = '1.0.0';
  
  // Environment variables
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.softskillsapp.com',
  );
  
  static const bool isProduction = bool.fromEnvironment(
    'PRODUCTION',
    defaultValue: false,
  );
  
  // Provider configuration
  static List<Provider> get providers => [
    // Core dependencies
    Provider<Dio>(
      create: (_) => DioConfig.createDio(),
    ),
    
    // Add feature providers here
  ];
}
