import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../view_models/provider/auth_provider.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_textfield.dart';
import '../../forgot_Password/forgot_Password_screen.dart';
import '../../home_screen.dart';
import '../sign_up/sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> with FormValidationMixin {
  final _formKey = GlobalKey<FormState>();
  String _email = '', _password = '';

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        await authProvider.login(_email, _password);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful!'),
            backgroundColor: AppColors.ToastColor,
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                "Invalid email or not registered. Please try again or sign up"),
            backgroundColor: AppColors.errorColor,
          ),
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
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: Text(
                  AppText.signInHeader,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Center(
                child: Text(
                  AppText.signInSubHeader,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 55),
              Container(
                height: screenHeight * 0.7,
                decoration: const BoxDecoration(
                  color: AppColors.textFieldBackground,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                    bottomRight: Radius.circular(100),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 16,left: 16,top: 45),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Enter your Email",style: TextStyle(fontSize: 20,), ),
                      ),
                      CustomTextFormField(
                        hintText: "Your Email",
                        icon: Icons.email,
                        onSaved: (value) => _email = value!,
                        validator: validateEmail,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Enter your PassWord",style: TextStyle(fontSize: 20,), ),
                      ),
                      CustomTextFormField(
                        hintText: "Your Password",
                        icon: Icons.lock,
                        isPassword: true,
                        onSaved: (value) => _password = value!,
                        validator: validatePassword,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen(),
                            ),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left: 220,bottom: 30),
                          child: Text(
                            "Forgot Password",
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        label: AppText.signInButton,
                        onPressed: _submit,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account? "),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "Sign up",
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
            ],
          ),
        ),
      ),
    );
  }
}

mixin FormValidationMixin {
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length != 8) { // Restrict password length to exactly 8 characters
      return 'Password must be exactly 8 characters';
    }
    return null;
  }
}




