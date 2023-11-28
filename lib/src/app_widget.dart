import 'package:app_nib/src/features/news/screens/single_news_screen.dart';
import 'package:app_nib/src/shared/services/http_service.dart';
import 'package:flutter/material.dart';

import 'package:app_nib/config/app_theme.dart';
import 'package:app_nib/src/features/main/screens/main_screen.dart';
import 'package:app_nib/src/features/auth/screens/sign_in_screen.dart';
import 'package:app_nib/src/features/auth/screens/sign_up_screen.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<HttpService>(create: (_) => HttpService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        initialRoute: "/screens/sign-in",
        routes: {
          "/screens/": (context) => const MainScreen(),
          "/screens/sign-in": (context) => const SignInScreen(),
          "/screens/sign-up": (context) => const SignUpScreen(),
          "/screens/single-news": (context) => const SingleNewsScreen(),
        },
      ),
    );
  }
}
