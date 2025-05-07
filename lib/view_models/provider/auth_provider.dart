


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../models/users/user_model.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  Future<void> register(String name, String email, String password, String phoneNumber) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;

      if (user != null) {
        const defaultImage = "https://icons.veryicon.com/png/o/system/crm-android-app-icon/app-icon-person.png";

        final newUser = UserModel(
          id: user.uid,
          name: name,
          email: email,
          phoneNumber: phoneNumber,
          imageUrl: defaultImage,
        );

        await _firestore.collection('users').doc(user.uid).set(newUser.toJson());
        _currentUser = newUser;
        notifyListeners();
      }
    }
    catch (e) {
      throw Exception('Error registering user: ${e.toString()}');
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception("Error sending reset link: ${e.toString()}");
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;

      if (user != null) {
        final doc = await _firestore.collection('users').doc(user.uid).get();
        if (doc.exists && doc.data() != null) {
          _currentUser = UserModel.fromJson(doc.data()!, user.uid);
          notifyListeners();
        } else {
          throw Exception('User data not found in Firestore.');
        }
      }
    } catch (e) {
      throw Exception('Error logging in: ${e.toString()}');
    }
  }

  Future<void> fetchCurrentUser() async {
    try {
      final user = _auth.currentUser;

      if (user != null) {
        final doc = await _firestore.collection('users').doc(user.uid).get();

        if (doc.exists && doc.data() != null) {
          _currentUser = UserModel.fromJson(doc.data()!, user.uid);
          notifyListeners();
        } else {
          throw Exception('User data not found.');
        }
      } else {
        throw Exception('No user is currently logged in.');
      }
    } catch (e) {
      throw Exception('Error fetching user data: ${e.toString()}');
    }
  }

  Future<void> updateProfileImage(File? image) async {
    try {
      if (image != null) {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          final storageRef = FirebaseStorage.instance.ref().child('profile_images/${user.uid}.jpg');
          await storageRef.putFile(image);
          final imageUrl = await storageRef.getDownloadURL();

          await _firestore.collection('users').doc(user.uid).update({
            'imageUrl': imageUrl,
          });

          _currentUser = _currentUser?.copyWith(imageUrl: imageUrl);
          notifyListeners();
        }
      }
    } catch (e) {
      throw Exception('Error updating profile image: ${e.toString()}');
    }
  }

  // Update user profile with validation
  Future<void> updateUserProfile({
    String? name,
    String? email,
    String? phoneNumber,
    File? imageFile,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('No user logged in');

      // Email Validation
      if (email != null && !RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email)) {
        throw Exception('Invalid email format');
      }

      if (phoneNumber != null && (phoneNumber.length != 10 || !RegExp(r'^[0-9]{10}$').hasMatch(phoneNumber))) {
        throw Exception('Phone number must be 10 digits');
      }

      String? imageUrl = _currentUser?.imageUrl;

      if (imageFile != null) {
        final storageRef = FirebaseStorage.instance.ref().child('profile_images/${user.uid}.jpg');
        await storageRef.putFile(imageFile);
        imageUrl = await storageRef.getDownloadURL();
      }

      await _firestore.collection('users').doc(user.uid).update({
        'name': name ?? _currentUser?.name,
        'email': email ?? _currentUser?.email,
        'phoneNumber': phoneNumber ?? _currentUser?.phoneNumber,
        'imageUrl': imageUrl,
      });

      _currentUser = _currentUser?.copyWith(
        name: name ?? _currentUser?.name,
        email: email ?? _currentUser?.email,
        phoneNumber: phoneNumber ?? _currentUser?.phoneNumber,
        imageUrl: imageUrl,
      );

      notifyListeners();
    } catch (e) {
      throw Exception('Error updating profile: ${e.toString()}');
    }
  }
}
