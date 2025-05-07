// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../../utils/app_colors.dart';
// import '../../../../utils/app_text.dart';
// import '../../../../view_models/provider/auth_provider.dart';
// import '../../custom_widgets/custom_button.dart';
// import '../../custom_widgets/custom_textfield.dart';
// import '../../forgot_Password/forgot_Password_screen.dart';
// import '../../home_data/home_navigation_bar.dart';
// import '../sign_up/sign_up_screen.dart';
//
// class SignInScreen extends StatefulWidget {
//   const SignInScreen({super.key});
//
//   @override
//   _SignInScreenState createState() => _SignInScreenState();
// }
//
// class _SignInScreenState extends State<SignInScreen> with FormValidationMixin {
//   final _formKey = GlobalKey<FormState>();
//
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   void _submit() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       try {
//         final authProvider = Provider.of<AuthProvider>(context, listen: false);
//         await authProvider.login(emailController.text, passwordController.text);
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//
//             content: Text('Login successful!'),
//             backgroundColor: AppColors.ToastColor,
//           ),
//         );
//
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const HomeNavigationBar()),
//         );
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text(
//                 "Invalid email or not registered. Please try again or sign up"),
//             backgroundColor: AppColors.errorColor,
//           ),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.primaryColor,
//         automaticallyImplyLeading: false,
//       ),
//       backgroundColor: AppColors.primaryColor,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               const  Center(
//                 child: Text(
//                   AppText.signInHeader,
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 18),
//               const Center(
//                 child: Text(
//                   AppText.signInSubHeader,
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.white,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               const SizedBox(height: 33),
//               Container(
//                 height: screenHeight * 0.8,
//                 decoration: const BoxDecoration(
//                   color: AppColors.textFieldBackground,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(25),
//                     topRight: Radius.circular(25),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(right: 16,left: 16,top: 45),
//                   child: ListView(
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Text("Enter your Email",style: TextStyle(fontSize: 20,), ),
//                       ),
//                       CustomTextFormField(
//                         controller: emailController,
//                         hintText: "Your Email",
//                         icon: Icons.email,
//                         validator: validateEmail,
//                       ),
//
//                       const Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Text("Enter your PassWord",style: TextStyle(fontSize: 20,), ),
//                       ),
//                       CustomTextFormField(
//                         hintText: "Your Password",
//                         icon: Icons.lock,
//                         isPassword: true,
//                         controller: passwordController,
//                         validator: validatePassword,
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const ForgotPasswordScreen(),
//                             ),
//                           );
//                         },
//                         child: Builder(
//                           builder: (context) {
//                             double screenWidth = MediaQuery.of(context).size.width;
//
//                             return Padding(
//                               padding: EdgeInsets.only(left: screenWidth * 0.5), // 40% left padding
//                               child: Text(
//                                 "Forgot Password",
//                                 style: TextStyle(
//                                   color: AppColors.primaryColor,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: screenWidth * 0.04, // font size based on screen width
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//
//                       const SizedBox(height: 80),
//                       CustomButton(
//                         label: AppText.signInButton,
//                         onPressed: _submit,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Text("Don't have an account? "),
//                           TextButton(
//                             onPressed: () {
//                               Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => const SignUpScreen(),
//                                 ),
//                               );
//                             },
//                             child: const Text(
//                               "Sign up",
//                               style: TextStyle(
//                                 color: AppColors.primaryColor,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// mixin FormValidationMixin {
//   String? validateEmail(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter an email';
//     }
//     if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//       return 'Enter a valid email';
//     }
//     return null;
//   }
//
//   String? validatePassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter a password';
//     }
//     if (value.length != 8) {
//       return 'Password must be exactly 8 characters';
//     }
//     return null;
//   }
// }
//
//
//
//

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text.dart';
import '../../../../view_models/provider/auth_provider.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_textfield.dart';
import '../../forgot_Password/forgot_Password_screen.dart';
import '../../home_data/home_navigation_bar.dart';
import '../sign_up/sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> with FormValidationMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        await authProvider.login(emailController.text, passwordController.text);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful!'),
            backgroundColor: AppColors.ToastColor,
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeNavigationBar()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Invalid email or not registered. Please try again or sign up"),
            backgroundColor: AppColors.errorColor,
          ),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: screenHeight * 0.02),
              Center(
                child: Text(
                  AppText.signInHeader,
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.015),
              Center(
                child: Text(
                  AppText.signInSubHeader,
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Container(
                height: screenHeight * 0.75,
                decoration: const BoxDecoration(
                  color: AppColors.textFieldBackground,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.04,
                  ),
                  child: ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.02),
                        child: Text(
                          "Enter your Email",
                          style: TextStyle(fontSize: screenWidth * 0.05, color: const Color(0xFF096056)),
                        ),
                      ),
                      CustomTextFormField(
                        controller: emailController,
                        hintText: "Your Email",
                        icon: Icons.email,
                        validator: validateEmail,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.02),
                        child: Text(
                          "Enter your Password",
                          style: TextStyle(fontSize: screenWidth * 0.05, color: const Color(0xFF096056)),
                        ),
                      ),
                      CustomTextFormField(
                        controller: passwordController,
                        hintText: "Your Password",
                        icon: Icons.lock,
                        isPassword: true,
                        validator: validatePassword,
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                            );
                          },
                          child: Text(
                            "Forgot Password",
                            style: TextStyle(
                              fontSize: screenWidth * 0.038,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.06),
                      isLoading
                          ? const Center(child: CircularProgressIndicator(color: Color(0xFF096056),))
                          : CustomButton(
                        label: AppText.signInButton,
                        onPressed: _submit,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(fontSize: screenWidth * 0.038),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: screenHeight * 0.02,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

mixin FormValidationMixin {
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please enter an email';
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter a password';
    if (value.length != 8) return 'Password must be exactly 8 characters';
    return null;
  }
}
