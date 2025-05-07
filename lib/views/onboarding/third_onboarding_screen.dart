//
// import 'package:flutter/material.dart';
//
// class ThirdOnboarding extends StatefulWidget {
//   const ThirdOnboarding({super.key});
//
//   @override
//   State<ThirdOnboarding> createState() => _ThirdOnboardingState();
// }
//
// class _ThirdOnboardingState extends State<ThirdOnboarding> {
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
//               child: Image.asset(width: 400,height: 400,
//                 "assets/images/4.png",
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
//                   "Live Tracking",
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF086A58),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Text("Real time tracking of your food",style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400,
//                 ),),
//                 Text("on the app after ordered.",style: TextStyle(
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

class ThirdOnboarding extends StatefulWidget {
  const ThirdOnboarding({super.key});

  @override
  State<ThirdOnboarding> createState() => _ThirdOnboardingState();
}

class _ThirdOnboardingState extends State<ThirdOnboarding> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          // Top image section with gradient
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
                "assets/images/4.png",
                height: screenHeight * 0.3,
                width: screenWidth * 0.8,
              ),
            ),
          ),

          SizedBox(height: screenHeight * 0.05),

          // Text content
          Center(
            child: Column(
              children: [
                Text(
                  "Live Tracking",
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF086A58),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  "Real time tracking of your food",
                  style: TextStyle(
                    fontSize: screenWidth * 0.042,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "on the app after ordered.",
                  style: TextStyle(
                    fontSize: screenWidth * 0.042,
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
