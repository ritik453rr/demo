import 'package:demo/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static lightTheme() {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.white,
      appBarTheme: AppBarTheme(
        surfaceTintColor: AppColors.white,
        backgroundColor: AppColors.white,
      ),
    );
  }
}
