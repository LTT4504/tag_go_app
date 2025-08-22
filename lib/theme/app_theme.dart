import 'package:flutter/material.dart';
import '../shared/constants/colors.dart';

class AppTheme {
  static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    filled: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    labelStyle: const TextStyle(
      color: AppColors.darkPinkColor,
      fontWeight: FontWeight.w600,
      fontSize: 18,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: AppColors.darkPinkColor, width: 1.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: AppColors.darkPinkColor, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: AppColors.errorColor, width: 1.5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: AppColors.errorColor, width: 2),
    ),
  );

  static ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.pinkColor,
      elevation: 3,
      padding: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
  );
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.pinkColor,
    scaffoldBackgroundColor: AppColors.textWhite,
    inputDecorationTheme: inputDecorationTheme,
    elevatedButtonTheme: elevatedButtonTheme,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black, // màu con trỏ nhập
      selectionColor: Colors.pinkAccent, // màu bôi đen chữ
      selectionHandleColor: Colors.pink, // màu nút kéo chọn
    ),
  );
}
