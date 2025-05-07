

import 'package:flutter/material.dart';
import '../category/category_screen.dart';
import '../settings/user_settings_screen.dart';
import '../user_profile/user_profile_screen.dart';
import 'home_screen.dart';

class HomeNavigationBar extends StatefulWidget {
  const HomeNavigationBar({super.key});

  @override
  _HomeNavigationBarState createState() => _HomeNavigationBarState();
}

class _HomeNavigationBarState extends State<HomeNavigationBar> {
  int _currentIndex = 0;
  final List<Widget> _screens =
  [const HomeScreen(),  const CategoryScreen(), UserSettingsScreen(), const UserProfileScreen(),];

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
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color(0xFFC5DCD9),
        backgroundColor: const Color(0xFF096056),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: _currentIndex == 0 ? Colors.white : const Color(0xFFC5DCD9),),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.category, color: _currentIndex == 2 ? Colors.white : const Color(0xFFC5DCD9),),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: _currentIndex == 3 ? Colors.white : const Color(0xFFC5DCD9),),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: _currentIndex == 4 ? Colors.white : const Color(0xFFC5DCD9),),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
