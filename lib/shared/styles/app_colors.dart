// lib/shared/styles/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors
  static const Color primary = Color(0xFF2196F3);      // Tech Blue
  static const Color primaryDark = Color(0xFF1976D2);
  static const Color primaryLight = Color(0xFF64B5F6);
  
  static const Color secondary = Color(0xFF4CAF50);     // Success Green
  static const Color secondaryDark = Color(0xFF388E3C);
  static const Color secondaryLight = Color(0xFF81C784);
  
  // Accent color from your design
  static const Color accent = Color(0xFF3FC409);        // Your kAccentGreen
  static const Color accentDark = Color(0xFF2E9206);
  static const Color accentLight = Color(0xFF5DD20D);

  // Semantic Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  
  // Grays
  static const Color gray50 = Color(0xFFFAFAFA);
  static const Color gray100 = Color(0xFFF5F5F5);
  static const Color gray200 = Color(0xFFEEEEEE);
  static const Color gray300 = Color(0xFFE0E0E0);
  static const Color gray400 = Color(0xFFBDBDBD);
  static const Color gray500 = Color(0xFF9E9E9E);
  static const Color gray600 = Color(0xFF757575);
  static const Color gray700 = Color(0xFF616161);
  static const Color gray800 = Color(0xFF424242);
  static const Color gray900 = Color(0xFF212121);

  // Surface Colors
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF121212);
  static const Color surfaceVariant = Color(0xFFF5F5F5);
  static const Color surfaceVariantDark = Color(0xFF1E1E1E);
  static const Color background = Color(0xFFF2F2F7); // iOS system grouped background

  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textDisabled = Color(0xFFBDBDBD);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnDark = Color(0xFFFFFFFF);

  // Card Colors
  static const Color cardBackground = Color(0xFFF5F5F5);
  static const Color cardBorder = Color(0xFFE5E5E5);

  // Gamification Colors
  static const Color experienceBlue = Color(0xFF1565C0);
  static const Color achievementGold = Color(0xFFFFD700);
  static const Color streakOrange = Color(0xFFFF6F00);
  static const Color levelPurple = Color(0xFF7B1FA2);

  // Light Color Scheme
  static const ColorScheme lightColorScheme = ColorScheme.light(
    primary: primary,
    onPrimary: white,
    secondary: secondary,
    onSecondary: white,
    surface: surface,
    onSurface: textPrimary,
    background: background,
    onBackground: textPrimary,
    error: error,
    onError: white,
  );

  // Dark Color Scheme
  static const ColorScheme darkColorScheme = ColorScheme.dark(
    primary: primaryLight,
    onPrimary: black,
    secondary: secondaryLight,
    onSecondary: black,
    surface: surfaceDark,
    onSurface: white,
    background: black,
    onBackground: white,
    error: error,
    onError: white,
  );
}