// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../../utils/app_colors.dart';
// import '../../../../utils/app_text.dart';
// import '../../../../view_models/provider/auth_provider.dart';
// import '../../../custom_widgets/custom_text_form_field.dart';
// import '../sign_in/sign_in_screen.dart';
//
//
// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});
//
//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen>{
//   final _formKey = GlobalKey<FormState>();
//
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//
//   // String _name = '', _email = '', _password = '', _phoneNumber = '';
//
//   void _submit() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       try {
//         final authProvider = Provider.of<AuthProvider>(context, listen: false);
//         await authProvider.register(nameController.text, emailController.text, passwordController.text, phoneController.text);
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Registration successful!')),
//         );
//
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const SignInScreen()),
//         );
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(e.toString())),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(backgroundColor: AppColors.primaryColor,
//         automaticallyImplyLeading: false, ),
//       backgroundColor: AppColors.primaryColor,
//       body: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               const Center(
//                 child: Text(
//                   AppText.signUpHeader,
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//             const  Center(
//                 child: Text(
//                   AppText.signUpSubHeader,
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.white,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               SizedBox(height: 20),
//               Expanded(
//                 child: Container(
//                   height: screenHeight * 0.7,
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(90),
//                       bottomRight: Radius.circular(90),
//                     ),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 10,right: 10,top: 40),
//                     child: ListView(
//                       children: [
//                        const Padding(
//                           padding: EdgeInsets.only(top: 8,left: 8),
//                           child: Text("Enter your Name",style: TextStyle(fontSize: 18,), ),
//                         ),
//                         CustomTextFormField(
//                           hintText: "Your Name",
//                           icon: Icons.person,
//
//                           // onSaved: (value) => _name = value!,
//                           validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8,left: 8),
//                           child: Text("Enter your Email",style: TextStyle(fontSize: 18,), ),
//                         ),
//                         CustomTextFormField(
//                           hintText: "Your Email",
//                           icon: Icons.email,
//                           onSaved: (value) => _email = value!,
//                           validator: (value) => !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value!)
//                               ? 'Enter a valid email'
//                               : null,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8,left: 8),
//                           child: Text("Enter your PassWord",style: TextStyle(fontSize: 18,), ),
//                         ),
//                         CustomTextFormField(
//                           hintText: "Your Password",
//                           icon: Icons.lock,
//                           isPassword: true,
//                           onSaved: (value) => _password = value!,
//                           validator: (value) => value!.length < 8
//                               ? 'Password must be at least 8 characters'
//                               : null,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8,left: 8),
//                           child: Text("Enter your Phone",style: TextStyle(fontSize: 18,), ),
//                         ),
//                         CustomTextFormField(
//                           hintText: "Enter your phone number",
//                           icon: Icons.phone,
//                           keyboardType: TextInputType.number,
//                           isPhone: true, // Restricts to 10 characters
//                           onSaved: (value) => print("Phone: $value"),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return "Please enter your phone number";
//                             }
//                             if (value.length < 10) {
//                               return "Phone number must be exactly 10 digits";
//                             }
//                             return null;
//                           },
//                         ),
//
//
//                         SizedBox(height: 40),
//                         ElevatedButton(
//                           onPressed: _submit,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.primaryColor,
//                             padding: EdgeInsets.symmetric(vertical: 14),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                           child: Text(AppText.signUpButton,style: TextStyle(color: AppColors.textColor,fontSize: 18),),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(AppText.alreadyHaveAccount),
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => SignInScreen(),
//                                   ),
//                                 );
//                               },
//                               child: Text(
//                                 "Sign in",
//                                 style: TextStyle(
//                                   color: AppColors.primaryColor,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
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
//


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text.dart';
import '../../../../view_models/provider/auth_provider.dart';
import '../../custom_widgets/custom_textfield.dart';
import '../sign_in/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      try {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        await authProvider.register(
          nameController.text,
          emailController.text,
          passwordController.text,
          phoneController.text,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration successful!')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const SignInScreen()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Center(
                child: Text(
                  AppText.signUpHeader,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),
              const Center(
                child: Text(
                  AppText.signUpSubHeader,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  height: screenHeight * 0.7,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(90),
                      bottomRight: Radius.circular(90),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 40),
                    child: ListView(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 8, left: 8),
                          child: Text(
                            "Enter your Name",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        CustomTextFormField(
                          hintText: "Your Name",
                          icon: Icons.person,
                          controller: nameController, // Added controller
                          validator: (value) =>
                          value!.isEmpty ? 'Please enter your name' : null,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, left: 8),
                          child: Text(
                            "Enter your Email",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        CustomTextFormField(
                          hintText: "Your Email",
                          icon: Icons.email,
                          controller: emailController, // Added controller
                          validator: (value) => !RegExp(r'^[^@]+@[^@]+\.[^@]+')
                              .hasMatch(value!)
                              ? 'Enter a valid email'
                              : null,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, left: 8),
                          child: Text(
                            "Enter your Password",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        CustomTextFormField(
                          hintText: "Your Password",
                          icon: Icons.lock,
                          isPassword: true,
                          controller: passwordController, // Added controller
                          validator: (value) => value!.length < 8
                              ? 'Password must be at least 8 characters'
                              : null,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, left: 8),
                          child: Text(
                            "Enter your Phone",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        CustomTextFormField(
                          hintText: "Enter your phone number",
                          icon: Icons.phone,
                          keyboardType: TextInputType.number,
                          isPhone: true,
                          controller: phoneController, // Added controller
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your phone number";
                            }
                            if (value.length != 10) {
                              return "Phone number must be exactly 10 digits";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            padding: EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            AppText.signUpButton,
                            style: TextStyle(
                                color: AppColors.textColor, fontSize: 18),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(AppText.alreadyHaveAccount),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignInScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "Sign in",
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
