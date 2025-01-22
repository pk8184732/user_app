
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/seller/user_model.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Seller? _currentSeller;

  Seller? get currentSeller => _currentSeller;

  Future<void> register(String name, String email, String password, String phoneNumber) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;

      if (user != null) {
        final seller = Seller(
          id: user.uid,
          name: name,
          email: email,
          phoneNumber: phoneNumber,
          imageUrl: null,
        );

        await _firestore.collection('sellers').doc(user.uid).set(seller.toJson());
        _currentSeller = seller;
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Error registering user: ${e.toString()}');
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;

      if (user != null) {
        final doc = await _firestore.collection('sellers').doc(user.uid).get();
        if (doc.exists && doc.data() != null) {
          _currentSeller = Seller.fromJson(doc.data()!, user.uid);
          notifyListeners();
        } else {
          throw Exception('User data not found in Firestore.');
        }
      }
    } catch (e) {
      throw Exception('Error logging in: ${e.toString()}');
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception('Error sending reset password email: ${e.toString()}');
    }
  }
}
