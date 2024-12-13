// text_styles.dart
import 'package:flutter/material.dart';
import 'colors.dart';

class AppTextStyles {
  static const TextStyle headline = TextStyle(
    color: AppColors.textLight,
    fontSize: 28,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w800,
    letterSpacing: 0.5,
  );

  static const TextStyle button = TextStyle(
    color: AppColors.textDark,
    fontSize: 20,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
  );

  static const TextStyle caption = TextStyle(
    color: AppColors.textDark,
    fontSize: 20,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w200,
    letterSpacing: 0.24,
  );
}
