



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text.dart';
import '../../view_models/provider/auth_provider.dart';
import '../home_screen.dart';


class SellerProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.primaryColor,leading: IconButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
      }, icon: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,)),),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              Text(AppText.profileScreenHeader, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              authProvider.currentSeller != null
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${authProvider.currentSeller!.name}'),
                  Text('Email: ${authProvider.currentSeller!.email}'),
                  Text('Phone: ${authProvider.currentSeller!.phoneNumber}'),
                ],
              )
                  : CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
