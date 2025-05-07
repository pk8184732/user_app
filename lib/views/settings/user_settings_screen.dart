import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../home_data/home_navigation_bar.dart';
import '../user_auth/sign_in/sign_in_screen.dart';

class UserSettingsScreen extends StatefulWidget {
  const UserSettingsScreen({super.key});

  @override
  State<UserSettingsScreen> createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {
  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SignInScreen()),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(backgroundColor: Colors.white,
          title: const Text('Confirm Logout',style: TextStyle(color: Color(
              0xFF06554A)),),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel',style: TextStyle(color: Colors.black),),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _logout();
              },
              child: const Text('Logout',style: TextStyle(color: Colors.red),),
            ),
          ],
        );
      },
    );
  }

  Widget buildSettingItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon,color: Color(0xFF096056),),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16,color: Color(0xFF096056),),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
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
        title: const Text('Settings',style: TextStyle(color: Colors.white),),backgroundColor: Color(0xFF06574D),),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          buildSettingItem(Icons.person, 'Profile Information', () {}),

          buildSettingItem(Icons.lock, 'Change Password', () {}),

          buildSettingItem(Icons.location_on, 'Manage Addresses', () {}),

          buildSettingItem(Icons.language, 'Language', () {}),

          buildSettingItem(Icons.notifications, 'Notification Preferences', () {}),

          buildSettingItem(Icons.privacy_tip, 'Privacy Policy', () {}),

          buildSettingItem(Icons.article, 'Terms & Conditions', () {}),
          const Divider(),
          buildSettingItem(Icons.logout, 'Logout', _showLogoutDialog),
        ],
      ),
    );
  }
}
