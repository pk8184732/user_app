//
//
// import 'package:flutter/material.dart';
// import 'package:user_app/views/onboarding/second_onboarding_screen.dart';
// import 'package:user_app/views/onboarding/third_onboarding_screen.dart';
//
// import '../user_auth/sign_in/sign_in_screen.dart';
// import 'first_onboarding_screen.dart';
//
// class ButtonSheet extends StatelessWidget {
//   const ButtonSheet({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: OnboardingScreen(),
//     );
//   }
// }
//
// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});
//
//   @override
//   _OnboardingScreenState createState() => _OnboardingScreenState();
// }
//
// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;
//
//   final List<Widget> _pages = [
//     const FirstOnboarding(),
//     const SecondOnboarding(),
//     const ThirdOnboarding(),
//   ];
//
//   void _nextPage() {
//     if (_currentPage < _pages.length - 1) {
//       _pageController.nextPage(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.ease,
//       );
//     } else {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const SignInScreen()),
//       );
//     }
//   }
//
//   // Function to skip to the last page
//   void _skip() {
//     _pageController.animateToPage(
//       _pages.length - 1,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.ease,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFA1C3BD),
//       body: Column(
//         children: [
//           Expanded(
//             child: PageView.builder(
//               controller: _pageController,
//               onPageChanged: (int page) {
//                 setState(() {
//                   _currentPage = page;
//                 });
//               },
//               itemCount: _pages.length,
//               itemBuilder: (context, index) => _pages[index],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 TextButton(
//                   onPressed: _skip,
//                   child: const Text(
//                     "Skip",
//                     style: TextStyle(color:  Color(0xFF036355),),
//                   ),
//                 ),
//                 Row(
//                   children: List.generate(
//                     _pages.length,
//                         (index) => Container(
//                       margin: const EdgeInsets.symmetric(horizontal: 4),
//                       width: 8,
//                       height: 8,
//                       decoration: BoxDecoration(
//                         color: _currentPage == index ? const Color(0xFF086A58) : Colors.grey,
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                   ),
//                 ),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor:  const Color(0xFF086A58),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   onPressed: _nextPage,
//                   child: const Text("Next",style: TextStyle(color: Colors.white),),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
//




import 'package:flutter/material.dart';
import 'package:user_app/views/onboarding/second_onboarding_screen.dart';
import 'package:user_app/views/onboarding/third_onboarding_screen.dart';
import '../user_auth/sign_in/sign_in_screen.dart';
import 'first_onboarding_screen.dart';

class ButtonSheet extends StatelessWidget {
  const ButtonSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Widget> _pages = [
    const FirstOnboarding(),
    const SecondOnboarding(),
    const ThirdOnboarding(),
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
      );
    }
  }

  void _skip() {
    _pageController.animateToPage(
      _pages.length - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFA1C3BD),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemCount: _pages.length,
              itemBuilder: (context, index) => _pages[index],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.06,
              vertical: screenHeight * 0.02,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Skip Button
                TextButton(
                  onPressed: _skip,
                  child: Text(
                    "Skip",
                    style: TextStyle(
                      color: const Color(0xFF036355),
                      fontSize: screenWidth * 0.04,
                    ),
                  ),
                ),

                // Page Indicators
                Row(
                  children: List.generate(
                    _pages.length,
                        (index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                      width: screenWidth * 0.02,
                      height: screenWidth * 0.02,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? const Color(0xFF086A58)
                            : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),

                // Next Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF086A58),
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: screenHeight * 0.015,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _nextPage,
                  child: Text(
                    "Next",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.04,
                    ),
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
