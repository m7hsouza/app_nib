import 'package:app_nib/config/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static get light {
    return ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
      ),
      useMaterial3: true,
    ).copyWith(
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
    );
  }
}
