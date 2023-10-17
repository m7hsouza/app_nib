import 'package:app_nib/config/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static get light {
    return ThemeData(
      colorSchemeSeed: AppColors.primary,
      useMaterial3: true,
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
    );
  }
}
