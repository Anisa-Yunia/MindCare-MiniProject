import 'package:flutter/material.dart';
import 'package:mind_care/view/onboardingscreen/splasshscreen_view.dart'; // Sesuaikan dengan lokasi file splasshscreen_view.dart

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      // Navigasi ke layar berikutnya setelah menahan splash screen selama 2 detik
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              onBoarding())); // Perbaiki nama widget menjadi OnBoarding
    });

    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logomindcare.png',
          width: 240,
          height: 240,
        ),
      ),
    );
  }
}
