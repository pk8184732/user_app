
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_text.dart';
import '../../../../../view_models/provider/auth_provider.dart';
import '../user_auth/sign_in/sign_in_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        await authProvider.resetPassword(_emailController.text.trim());

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Send link to your email.')),
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
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        actions: [
          CircleAvatar(
            backgroundColor: AppColors.hover1Color,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInScreen()),
                );
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Color(0xFF096056)),
            ),
          ),
          SizedBox(width: screenWidth * 0.865),
        ],
      ),
      backgroundColor: AppColors.primaryColor,
      body: ListView(
        children: [
          SizedBox(height: screenHeight * 0.06),
          Center(
            child: Text(
              AppText.forgotPasswordTitle,
              style: TextStyle(
                fontSize: screenWidth * 0.06,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
          ),
          Center(
            child: Text(
              AppText.forgotPasswordHeader,
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.12),
          Center(
            child: Container(
              height: screenHeight * 0.7,
              width: screenWidth,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: screenHeight * 0.1,
                        left: screenWidth * 0.05,
                        bottom: screenHeight * 0.01,
                      ),
                      child: Text(
                        AppText.enterEmail,
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      child: TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppColors.borderColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: AppColors.borderColor, width: 2),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          hintText: "seller@gmail.com",
                          hintStyle: const TextStyle(color: Colors.tealAccent),
                          fillColor: AppColors.textFieldBackground,
                          filled: true,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.06),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      child: ElevatedButton(
                        onPressed: _resetPassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.018),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          'Send Link',
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: screenWidth * 0.045,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
