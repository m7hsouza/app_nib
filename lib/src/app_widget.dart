import 'package:app_nib/src/features/main/main_store.dart';
import 'package:app_nib/src/features/news/stores/recent_articles_store.dart';
import 'package:app_nib/src/features/news/stores/news_slide_store.dart';
import 'package:app_nib/src/features/news/stores/news_store.dart';
import 'package:app_nib/src/features/news/stores/recent_videos_store.dart';
import 'package:app_nib/src/features/profile/profile_store.dart';
import 'package:app_nib/src/shared/auth/auth_service.dart';
import 'package:app_nib/src/features/auth/stores/sign_in_store.dart';
import 'package:app_nib/src/features/news/screens/single_news_screen.dart';
import 'package:app_nib/src/shared/services/http_service.dart';
import 'package:flutter/material.dart';

import 'package:app_nib/config/app_theme.dart';
import 'package:app_nib/src/features/main/screens/main_screen.dart';
import 'package:app_nib/src/features/auth/screens/sign_in_screen.dart';
import 'package:app_nib/src/features/auth/screens/sign_up_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  static final scaffoldRoot = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<HttpService>(create: (_) => HttpService()),
        ChangeNotifierProvider(create: (ctx) => AuthService(ctx.read<HttpService>())),
        ChangeNotifierProvider(create: (ctx) => SignInStore(ctx.read<AuthService>())),
        ChangeNotifierProvider(create: (ctx) => NewsStore(ctx.read<HttpService>())),
        ChangeNotifierProvider(create: (ctx) => NewsSlideStore(ctx.read()), lazy: true),
        ChangeNotifierProvider(create: (ctx) => RecentArticlesStore(ctx.read())),
        ChangeNotifierProvider(create: (ctx) => RecentVideosStore(ctx.read())),
        ChangeNotifierProvider(create: (ctx) => ProfileStore(ctx.read<AuthService>(), ctx.read())),
        ChangeNotifierProvider(create: (_) => MainStore())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        initialRoute: "/screens/sign-in",
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [Locale('pt', 'BR')],
        scaffoldMessengerKey: AppWidget.scaffoldRoot,
        routes: {
          "/screens/": (context) => const MainScreen(),
          "/screens/sign-in": (context) => const SignInScreen(),
          "/screens/sign-up": (context) => const SignUpScreen(),
          "/screens/single-news": (context) => const SingleNewsScreen(),
          "/show/video": (context) => Container(),
        },
      ),
    );
  }
}
