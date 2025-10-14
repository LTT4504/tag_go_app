import 'package:flutter/material.dart';

class AppColors {
  // Nền vàng pastel
  static const Color pastelYellow = Color.fromARGB(255, 254, 246, 201);
  static const Color textWhite = Colors.white;

  // Bạn có thể định nghĩa thêm nhiều màu khác tại đây
  static const Color textPrimary = Colors.black87;
  static const Color textSecondary = Colors.grey;
  static const Color pinkColor = Color.fromARGB(255, 240, 105, 147);
  static const Color pinkAppbarColor = Color.fromARGB(255, 241, 155, 182);
  static const Color blueColor = Color.fromARGB(255, 53, 83, 206);
  static const Color darkPinkColor = Color.fromARGB(255, 226, 94, 138);
  static const Color errorColor = Colors.redAccent;

  // Scaffold Background Colors
  static const Color lightScaffoldBackgroundColor = Color(0xFFF9F9F9);
  static const Color darkScaffoldBackgroundColor = Color(0xFF2F2E2E);

  // Secondary Colors
  static const Color secondaryAppColor = Color(0xFF22DDA6);
  static const Color secondaryDarkAppColor = Colors.white;

  // Neutral Colors
  static const Color tipColor = Color(0xFFB6B6B6);
  static const Color lightGray = Color(0xFFF6F6F6);
  static const Color darkGray = Color(0xFF9F9F9F);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  // Highlight Colors
  static const Color highlightPrimary = Color(0xFF006FFD);
  static const Color highlightSecondary = Color(0xFF2897FF);
  static const Color highlightTertiary = Color(0xFF6FBAFF);
  static const Color highlightQuaternary = Color(0xFFB4DBFF);
  static const Color highlightQuintary = Color(0xFFEAF2FF);

  // Neutral Light Colors
  static const Color neutralLightPrimary = Color(0xFFC5C6CC);
  static const Color neutralLightSecondary = Color(0xFFD4D6DD);
  static const Color neutralLightTertiary = Color(0xFFE8E9F1);
  static const Color neutralLightQuaternary = Color(0xFFF8F9FE);
  static const Color neutralLightQuintary = Color(0xFFFFFFFF);

  // Neutral Dark Colors
  static const Color neutralDarkPrimary = Color(0xFF1F2024);
  static const Color neutralDarkSecondary = Color(0xFF2F3036);
  static const Color neutralDarkTertiary = Color(0xFF494A50);
  static const Color neutralDarkQuaternary = Color(0xFF71727A);
  static const Color neutralDarkQuintary = Color(0xFF8F9098);

  // Support Colors
  static const Color supportSuccessPrimary = Color(0xFF298267);
  static const Color supportSuccessSecondary = Color(0xFF3AC0A0);
  static const Color supportSuccessTertiary = Color(0xFFE7F4E8);

  static const Color supportWarningPrimary = Color(0xFFE86339);
  static const Color supportWarningSecondary = Color(0xFFFFB37C);
  static const Color supportWarningTertiary = Color(0xFFFFF4E4);

  static const Color supportErrorPrimary = Color(0xFFED3241);
  static const Color supportErrorSecondary = Color(0xFFFF616D);
  static const Color supportErrorTertiary = Color(0xFFFFE2E5);
}

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: AppColors.highlightTertiary,
  onPrimary: AppColors.neutralDarkPrimary,
  surface: AppColors.neutralDarkSecondary,
  primaryContainer: AppColors.highlightSecondary,
  onPrimaryContainer: AppColors.white,
  secondary: AppColors.highlightQuaternary,
  onSecondary: AppColors.neutralDarkPrimary,
  secondaryContainer: AppColors.highlightPrimary,
  onSecondaryContainer: AppColors.white,
  onSurface: AppColors.neutralLightQuintary,
  error: AppColors.supportErrorSecondary,
  onError: AppColors.neutralDarkPrimary,
  errorContainer: AppColors.supportErrorPrimary,
  onErrorContainer: AppColors.white,
  outlineVariant: AppColors.neutralDarkQuintary,
);

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: AppColors.highlightPrimary,
  onPrimary: AppColors.white,
  primaryContainer: AppColors.highlightQuaternary,
  onPrimaryContainer: AppColors.neutralDarkPrimary,
  secondary: AppColors.highlightSecondary,
  onSecondary: AppColors.white,
  secondaryContainer: AppColors.highlightTertiary,
  onSecondaryContainer: AppColors.neutralDarkPrimary,
  surface: AppColors.neutralLightQuintary,
  onSurface: AppColors.neutralDarkPrimary,
  error: AppColors.supportErrorPrimary,
  onError: AppColors.white,
  errorContainer: AppColors.supportErrorTertiary,
  onErrorContainer: AppColors.neutralDarkPrimary,
  outlineVariant: AppColors.neutralLightPrimary,
);

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex), 'hex color must be #rrggbb or #rrggbbaa');

  return Color(int.parse(hex.substring(1), radix: 16) + (hex.length == 7 ? 0xff000000 : 0x00000000));
}
