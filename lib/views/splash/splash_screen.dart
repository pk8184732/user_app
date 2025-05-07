
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../home_data/home_navigation_bar.dart';
import '../onboarding/button_sheet.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeNavigationBar()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ButtonSheet()),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF06574D),
      ),
      backgroundColor: const Color(0xFF06574D),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Image.asset(
                "assets/images/7.png",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
