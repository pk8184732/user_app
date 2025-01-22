
import 'package:flutter/material.dart';

class SecondOnboarding extends StatefulWidget {
  const SecondOnboarding({super.key});

  @override
  State<SecondOnboarding> createState() => _SecondOnboardingState();
}

class _SecondOnboardingState extends State<SecondOnboarding> {
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
              child: Image.asset(
                "assets/images/5.png", // Your image
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
                    "Fast Delivery",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF086A58),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text("Fast delivery to your home, office",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),),
                  Text("and wherever you are.",style: TextStyle(
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
