import 'package:flutter/material.dart';

import 'package:app_nib/config/app_colors.dart';
import 'package:flutter/services.dart';

abstract class AppTheme {
  static get light {
    return ThemeData(
      colorSchemeSeed: AppColors.primary,
      useMaterial3: true,
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark
        )
      ),
    );
  }
}
