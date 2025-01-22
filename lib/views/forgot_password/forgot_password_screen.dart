
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:seller_app/views/seller_data/forgot_Password/password_verification_screen.dart';
// import 'package:seller_app/views/seller_data/seller_auth/sign_in/sign_in_screen.dart';
// import '../../../../../utils/app_colors.dart';
// import '../../../../../utils/app_text.dart';
// import '../../../../../view_models/provider/auth_provider.dart';
//
// class ForgotPasswordScreen extends StatefulWidget {
//   @override
//   _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
// }
//
// class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
//   final _emailController = TextEditingController();
//
//   void _resetPassword() async {
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => PasswordVerificationScreen(),
//         ));
//     try {
//       final authProvider = Provider.of<AuthProvider>(context, listen: false);
//       await authProvider.resetPassword(_emailController.text);
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Password reset email sent')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(e.toString())),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: AppColors.primaryColor,
//         actions: [
//           CircleAvatar(
//             backgroundColor: AppColors.hoverColor,
//             child: IconButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => SignInScreen(),
//                       ));
//                 },
//                 icon: Icon(
//                   Icons.arrow_back_ios_new_outlined,
//                   color: Colors.white,
//                 )),
//           ),
//           SizedBox(
//             width: 345,
//           )
//         ],
//       ),
//       backgroundColor: AppColors.primaryColor,
//       body: ListView(
//         children: [
//           SizedBox(
//             height: 50,
//           ),
//           const Center(
//             child: Text(
//               AppText.forgotPasswordTitle,
//               style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textColor),
//             ),
//           ),
//           const Center(
//             child: Text(
//               AppText.forgotPasswordHeader,
//               style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textColor),
//             ),
//           ),
//           SizedBox(height: 128),
//           Center(
//             child: Container(
//               height: screenHeight * 0.7,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(40),
//                       topLeft: Radius.circular(40)),
//                   color: Colors.white),
//               child: ListView(
//                 children: [
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(top: 100, right: 234, bottom: 5),
//                     child: Center(
//                       child: Text(
//                         AppText.enterEmail,
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.w400),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 16, right: 16),
//                     child: TextField(
//                       controller: _emailController,
//                       decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: BorderSide(color: AppColors.borderColor)),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: AppColors.borderColor,width: 2),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         hintText: "user@gmail.com",
//                         fillColor: AppColors.textFieldBackground,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 50),
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: ElevatedButton(
//                       onPressed: _resetPassword,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.primaryColor,
//                         padding: EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: Text(
//                         'Send Code',
//                         style:
//                             TextStyle(color: AppColors.textColor, fontSize: 16),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  // Mock function to simulate sending OTP
  void sendOtp(String email) {
    if (email.isNotEmpty) {
      // Assuming OTP is successfully sent
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("OTP Sent to $email")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter a valid email")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Forgot Password")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Enter Email"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => sendOtp(_emailController.text),
              child: Text("Send OTP"),
            ),
          ],
        ),
      ),
    );
  }
}
