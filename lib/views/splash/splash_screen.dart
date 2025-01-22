


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../home_screen.dart';
import '../onboarding/button_sheet.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Delay for 3 seconds and check user authentication status
    Future.delayed(Duration(seconds: 3), () {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // If user is logged in, navigate to HomeScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      } else {
        // If no user is logged in, navigate to ButtonSheet
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => ButtonSheet()),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF06574D), // Splash screen app bar color
      ),
      backgroundColor: Color(0xFF06574D), // Splash screen background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Image.asset(
                "assets/images/7.png", // Add your logo/image here
              ),
            ),
          ],
        ),
      ),
    );
  }
}
