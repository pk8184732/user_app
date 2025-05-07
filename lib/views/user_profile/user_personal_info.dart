

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:user_app/views/user_profile/user_update_profile.dart';
import '../../../utils/app_colors.dart';
import '../../../view_models/provider/auth_provider.dart';
import '../home_data/home_navigation_bar.dart';

class UserPersonalInfo extends StatefulWidget {
  const UserPersonalInfo({super.key});

  @override
  _UserPersonalInfoState createState() => _UserPersonalInfoState();
}

class _UserPersonalInfoState extends State<UserPersonalInfo> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.fetchCurrentUser();
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery);

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
                        builder: (context) => const HomeNavigationBar(),
                      ));
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Color(0xFF096056),
                )),
          ),
        ),
        title:
        const Text("Profile Info", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryColor,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileUpdateScreen()),
              );
            },
            child: const Text("EDIT",
                style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
          child:
          CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              authProvider.currentUser != null
                  ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap:
                          _pickImage, // Image change karne ke liye
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey[300],
                            backgroundImage: _profileImage != null
                                ? FileImage(_profileImage!)
                                : NetworkImage(authProvider
                                .currentUser!.imageUrl ??
                                "") as ImageProvider,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            ' ${authProvider.currentUser!.name}',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        Text(
                          'Email: ${authProvider.currentUser!.email}',
                          style:
                          const TextStyle(fontSize: 17,
                              color: Color(0xFF6E7070)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(12)),
                        color: Color(0xFFDAE8E6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(22.0),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              children: [
                                const Icon(
                                  Icons.person,
                                  color: Color(0xFF096056),
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "FULL NAME",
                                      style:
                                      TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      'Name: ${authProvider.currentUser!.name}',
                                      style: const TextStyle(
                                          fontSize: 17,
                                          color: Color(0xFF6E7070)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                const Icon(
                                  Icons.email_outlined,
                                  color: Color(0xFF096056),
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "EMAIL",
                                      style:
                                      TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      'Email: ${authProvider.currentUser!.email}',
                                      style:
                                      const TextStyle(fontSize: 17,
                                          color: Color(0xFF6E7070)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                const Icon(
                                  Icons.phone,
                                  color: Color(0xFF096056),
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "PHONE NUMBER",
                                      style:
                                      TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      authProvider.currentUser!.phoneNumber,
                                      style:
                                      const TextStyle(fontSize: 17,color: Color(0xFF6E7070)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(12)),
                        color: Color(0xFFDAE8E6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(22.0),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              children: [
                                const Icon(
                                  Icons.person,
                                  color: Color(0xFF096056),
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "FULL NAME",
                                      style:
                                      TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      'Name: ${authProvider.currentUser!.name}',
                                      style: const TextStyle(
                                          fontSize: 17,
                                          color: Color(0xFF6E7070)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                const Icon(
                                  Icons.email_outlined,
                                  color: Color(0xFF096056),
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "EMAIL",
                                      style:
                                      TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      'Email: ${authProvider.currentUser!.email}',
                                      style:
                                      const TextStyle(fontSize: 17,
                                          color: Color(0xFF6E7070)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                const Icon(
                                  Icons.phone,
                                  color: Color(0xFF096056),
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "PHONE NUMBER",
                                      style:
                                      TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      authProvider.currentUser!.phoneNumber,
                                      style:
                                      const TextStyle(fontSize: 17,color: Color(0xFF6E7070)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
                  : const Icon(Icons.person),
            ],
          ),
        ),
      ),
    );
  }
}
