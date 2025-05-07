import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:user_app/views/user_profile/user_profile_screen.dart';
import '../../../utils/app_colors.dart';
import '../../../view_models/provider/auth_provider.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({super.key});

  @override
  _ProfileUpdateScreenState createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  String? _name;
  String? _email;
  String? _phone;
  String? _errorMessage;

  Future<void> _pickImage() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        await authProvider.updateUserProfile(
          name: _name,
          email: _email,
          phoneNumber: _phone,
          imageFile: _profileImage,
        );

        Navigator.pop(context);
      } catch (e) {
        setState(() {
          _errorMessage = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final seller = authProvider.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.white),
        ),
        leading: ClipOval(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserProfileScreen(),
                      ));
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Color(0xFF096056),
                )),
          ),
        ),
        backgroundColor: const Color(0xFF096056),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : NetworkImage(seller?.imageUrl ?? "") as ImageProvider,
                    child: _profileImage == null
                        ? const Padding(
                      padding: EdgeInsets.only(left: 75, top: 60),
                      child: Icon(
                        Icons.edit_calendar_rounded,
                        color: Color(0xFF024C4C),
                      ),
                    )
                        : null,
                  ),
                ),
                const SizedBox(height: 20),

                const Padding(
                  padding: EdgeInsets.only(right: 240),
                  child: Text("FULL NAME",style: TextStyle(fontSize: 18,color:Color(0xFF024C4C), ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: seller?.name,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFF8FB3AE)),
                          borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: const Color(0xFFDAE8E6),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onSaved: (value) => _name = value,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 290),
                  child: Text("EMAIL",style: TextStyle(fontSize: 18,color: Color(0xFF024C4C),),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: seller?.email,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFF8FB3AE)),
                          borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: const Color(0xFFDAE8E6),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) return null;
                      final emailRegex = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                      if (!emailRegex.hasMatch(value)) {
                        return "Invalid email format";
                      }
                      return null;
                    },
                    onSaved: (value) => _email = value,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 280),
                  child: Text("PHONE",style: TextStyle(fontSize: 18,color: Color(0xFF024C4C),),),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: seller?.phoneNumber,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFF8FB3AE)),
                          borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: const Color(0xFFDAE8E6),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) return null;
                      if (value.length != 10 ||
                          !RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                        return "Phone number must be 10 digits";
                      }
                      return null;
                    },
                    onSaved: (value) => _phone = value,
                  ),
                ),

                const SizedBox(height: 20),

                // Error Message
                if (_errorMessage != null)
                  Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),

                const SizedBox(height: 170),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 130),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _updateProfile,
                  child: const Text("Update Profile",style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
