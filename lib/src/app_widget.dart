import 'package:flutter/material.dart';

import 'package:app_nib/config/app_theme.dart';
import 'package:app_nib/src/features/main/screens/main_screen.dart';
import 'package:app_nib/src/features/auth/screens/sign_in_screen.dart';
import 'package:app_nib/src/features/auth/screens/sign_up_screen.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: "/screens/sign-in",
      routes: {
        "/screens/sign-in": (_) => const SignInScreen(),
        "/screens/sign-up": (_) => const SignUpScreen(),
        "/screens/": (_) => const MainScreen(),
      },
    );
  }
}
