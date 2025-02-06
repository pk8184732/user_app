
import 'package:flutter/material.dart';

import '../category/category_screen.dart';
import '../settings/settings_screen.dart';
import '../user_profile/user_profile_screen.dart';
import 'home_screen.dart';

class HomeNavigationBar extends StatefulWidget {
  @override
  _HomeNavigationBarState createState() => _HomeNavigationBarState();
}

class _HomeNavigationBarState extends State<HomeNavigationBar> {
  int _currentIndex = 0; // Index for bottom navigation
  final List<Widget> _screens = [HomeScreen(), SellerProfileScreen(), CategoryScreen(), SettingsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home', backgroundColor: Color(0xFF096056)),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile', backgroundColor: Color(0xFF096056)),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Category', backgroundColor: Color(0xFF096056)),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings', backgroundColor: Color(0xFF096056)),
        ],
      ),
    );
  }
}
