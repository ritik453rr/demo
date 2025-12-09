import 'package:demo/core/theme/app_colors.dart';
import 'package:flutter/services.dart';

class AppConstants {

  /// Set safe area color in view
  static void setSafeArea({required bool isDark}) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: isDark ? AppColors.black : AppColors.white,
        systemNavigationBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      ),
    );
  }
}