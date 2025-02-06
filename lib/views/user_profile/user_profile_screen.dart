// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:seller_app/views/home_screen.dart';
//
// import '../../../utils/app_colors.dart';
// import '../../../utils/app_text.dart';
// import '../../../view_models/provider/auth_provider.dart';
//
// class SellerProfileScreen extends StatefulWidget {
//   @override
//   _SellerProfileScreenState createState() => _SellerProfileScreenState();
// }
//
// class _SellerProfileScreenState extends State<SellerProfileScreen> {
//   File? _profileImage;  // Profile image holder
//
//   final ImagePicker _picker = ImagePicker();  // Image picker instance
//
//   // Function to pick an image from gallery
//   Future<void> _pickImage() async {
//     final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       setState(() {
//         _profileImage = File(pickedFile.path);  // Update profile image
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(title: Center(child: Text("Profile Data",style: TextStyle(color: Colors.white),)),
//         backgroundColor: AppColors.primaryColor,
//         automaticallyImplyLeading: false,
//
//       ),
//
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Center(
//           child: Column(
//             children: [
//
//               SizedBox(height: 20),
//               authProvider.currentSeller != null
//                   ? Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   // Profile image display
//                   GestureDetector(
//                     onTap: _pickImage,  // Open image picker on tap
//                     child: CircleAvatar(
//                       radius: 50,
//                       backgroundColor: Colors.grey[300],
//                       backgroundImage: _profileImage != null
//                           ? FileImage(_profileImage!)  // Show picked image
//                           : null,
//                       child: _profileImage == null
//                           ? Text(
//                         authProvider.currentSeller!.name![0], // First letter of name
//                         style: TextStyle(fontSize: 40, color: Colors.white),
//                       )
//                           : null,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Text('Name: ${authProvider.currentSeller!.name}'),
//                   Text('Email: ${authProvider.currentSeller!.email}'),
//                   Text('Phone: ${authProvider.currentSeller!.phoneNumber}'),
//                 ],
//               )
//                  :Icon(Icons.person),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../view_models/provider/auth_provider.dart';

class SellerProfileScreen extends StatefulWidget {
  @override
  _SellerProfileScreenState createState() => _SellerProfileScreenState();
}

class _SellerProfileScreenState extends State<SellerProfileScreen> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.fetchCurrentSeller(); // Fetch current seller data
      setState(() {
        _isLoading = false;
      });
    });
  }

  // Pick image from gallery
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });

      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.updateProfileImage(_profileImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Profile Data", style: TextStyle(color: Colors.white)),
        ),
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) // Show loader until data is fetched
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              authProvider.currentSeller != null
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _pickImage, // Allow image change on tap
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!) // Show selected image
                          : NetworkImage(authProvider.currentSeller!.imageUrl ?? "") as ImageProvider,
                      child: _profileImage == null
                          ?
                      null
                          :  Text(
                        authProvider.currentSeller!.name![0],
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Name: ${authProvider.currentSeller!.name}'),
                  Text('Email: ${authProvider.currentSeller!.email}'),
                  Text('Phone: ${authProvider.currentSeller!.phoneNumber}'),
                ],
              )
                  : Icon(Icons.person),
            ],
          ),
        ),
      ),
    );
  }
}
