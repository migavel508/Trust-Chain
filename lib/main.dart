import 'package:flutter/material.dart';
import 'package:trust/pages/onboarding_screen.dart';
import 'package:trust/pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TrustChain Onboarding',
      theme: ThemeData(
        primarySwatch: Colors.green, // Match TrustChain theme
      ),
      home: SplashScreen(), // Launch OnboardingScreen first
    );
  }
}
