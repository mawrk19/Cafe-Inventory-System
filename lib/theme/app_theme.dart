// app_theme.dart
import 'package:flutter/material.dart';
import 'colors.dart';
import 'text_styles.dart'; // Import text styles

class AppTheme {
  // Define the text theme by using AppTextStyles
  static const textTheme = TextTheme(
    displayLarge: AppTextStyles.headline,  // Use the defined text style
    labelLarge: AppTextStyles.button,  // Use the defined text style for buttons
  );

  // Define the overall theme for the app
  static ThemeData get lightTheme => ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    secondaryHeaderColor: AppColors.secondary,  // Theme color for secondary elements
    textTheme: textTheme,  // Use the text theme here
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,  // Apply a consistent color for buttons
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),  // Standardize button borders
        ),
      ),
    ),
  );
}
