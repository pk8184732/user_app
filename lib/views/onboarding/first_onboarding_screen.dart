
import 'package:flutter/material.dart';

class FirstOnboarding extends StatefulWidget {
  const FirstOnboarding({super.key});

  @override
  State<FirstOnboarding> createState() => _FirstOnboardingState();
}

class _FirstOnboardingState extends State<FirstOnboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
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
                "assets/images/3.png",
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
                    "Find foods you love",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF086A58),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text("Discover the best foods from",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),),
                  Text("over 100 restaruants.",style: TextStyle(
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
