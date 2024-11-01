import 'package:flutter/material.dart';
import 'package:spotify_flutter_apk/core/configs/theme/app_theme.dart';
import 'package:spotify_flutter_apk/presentation/splash/pages/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      home: SplashPage(),
    );
  }
}