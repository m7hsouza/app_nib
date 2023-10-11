import 'package:app_nib/config/app_theme.dart';
import 'package:app_nib/src/features/auth/screens/sign_in_screen.dart';
import 'package:app_nib/src/features/auth/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: "/sign-in",
      routes: {
        "/sign-in": (_) => const SignInScreen(),
        "/sign-up": (_) => const SignUpScreen(),
        "/news": (_) => Material(child: Center(child: Text("Noticias")))
      },
    );
  }
}
