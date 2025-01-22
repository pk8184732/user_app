
import 'package:flutter/material.dart';

class ThirdOnboarding extends StatefulWidget {
  const ThirdOnboarding({super.key});

  @override
  State<ThirdOnboarding> createState() => _ThirdOnboardingState();
}

class _ThirdOnboardingState extends State<ThirdOnboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Curved section with image
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40)),
              gradient: LinearGradient(
                transform: GradientRotation(BorderSide.strokeAlignInside),
                colors: [
                  Color(0xFF07877C),
                  Color(0xFF086A58),
                  Color(0xFF0A554E),
                  Color(0xFF063937),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            height: 400,
            width: 420,
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Image.asset(width: 400,height: 400,
                "assets/images/4.png", // Your image
                // fit: BoxFit.cover, // Ensures the image covers the container
              ),
            ),
          ),
          // White section with text at the bottom
          Container(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Live Tracking",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF086A58),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text("Real time tracking of your food",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),),
                  Text("on the app after ordered.",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
