//
// import 'package:flutter/material.dart';
//
// class FirstOnboarding extends StatefulWidget {
//   const FirstOnboarding({super.key});
//
//   @override
//   State<FirstOnboarding> createState() => _FirstOnboardingState();
// }
//
// class _FirstOnboardingState extends State<FirstOnboarding> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(40),
//                   bottomRight: Radius.circular(40)),
//               gradient: LinearGradient(
//                 transform: GradientRotation(BorderSide.strokeAlignInside),
//                 colors: [
//                   Color(0xFF07877C),
//                   Color(0xFF086A58),
//                   Color(0xFF0A554E),
//                   Color(0xFF063937),
//                 ],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//             height: 400,
//             width: 420,
//             child: Padding(
//               padding: const EdgeInsets.only(top: 100),
//               child: Image.asset(
//                 "assets/images/3.png",
//               ),
//             ),
//           ),
//           const Center(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 40,
//                 ),
//                 Text(
//                   "Find foods you love",
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF086A58),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Text("Discover the best foods from",style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400,
//                 ),),
//                 Text("over 100 restaruants.",style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400,
//                 ),)
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';

class FirstOnboarding extends StatefulWidget {
  const FirstOnboarding({super.key});

  @override
  State<FirstOnboarding> createState() => _FirstOnboardingState();
}

class _FirstOnboardingState extends State<FirstOnboarding> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          // Top Image Container with Gradient
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              gradient: LinearGradient(
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
            height: screenHeight * 0.45,
            width: screenWidth,
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.1),
              child: Image.asset(
                "assets/images/3.png",
              ),
            ),
          ),

          SizedBox(height: screenHeight * 0.05),

          // Text Content
          Center(
            child: Column(
              children: [
                Text(
                  "Find foods you love",
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF086A58),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  "Discover the best foods from",
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "over 100 restaurants.",
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
