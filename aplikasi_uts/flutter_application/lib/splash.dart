import 'package:flutter/material.dart';
import 'package:flutter_application/LoginPage.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset(
          'assets/apku_logo.JPG'), // Ganti dengan path gambar ikon aplikasi Anda
      nextScreen: LoginPage(),
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor:
          Colors.white, // Ganti dengan warna latar belakang yang sesuai
      duration: 3000, // Durasi tampilan splash screen (dalam milidetik)
    );
  }
}
