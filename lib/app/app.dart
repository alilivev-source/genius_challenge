import 'package:flutter/material.dart';
import '../features/splash/splash_screen.dart';
import 'app_theme.dart';

class GeniusChallengeApp extends StatelessWidget {
  const GeniusChallengeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تحدي العباقرة',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}