import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:vocal_app/pages/app_pallete.dart';
import 'package:vocal_app/pages/login_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.transparentColor, // Set the background color
      body: Center(
        child: FlutterSplashScreen.gif(
          backgroundColor: Pallete.transparentColor,
          gifPath: 'assets/splash.gif', // Path to your GIF
          gifWidth: MediaQuery.of(context).size.width, // Full width
          gifHeight: MediaQuery.of(context).size.height, // Full height
          duration: const Duration(seconds: 10, milliseconds: 500),
          nextScreen: const LoginPage(), // Navigate to LoginPage after the splash
        ),
      ),
    );
  }
}