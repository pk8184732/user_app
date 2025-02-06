// // import 'dart:io';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// //
// // import '../../models/seller/seller_model.dart';
// //
// // class AuthProvider with ChangeNotifier {
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //   final FirebaseStorage _storage = FirebaseStorage.instance;
// //   Seller? _currentSeller;
// //
// //   Seller? get currentSeller => _currentSeller;
// //
// //   Future<void> register(String name, String email, String password, String phoneNumber, File? image) async {
// //     try {
// //       final userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
// //       final user = userCredential.user;
// //
// //       if (user != null) {
// //         String? imageUrl;
// //         if (image != null) {
// //           final ref = _storage.ref().child('profile_images/${user.uid}');
// //           await ref.putFile(image);
// //           imageUrl = await ref.getDownloadURL();
// //         }
// //
// //         final seller = Seller(
// //           id: user.uid,
// //           name: name,
// //           email: email,
// //           phoneNumber: phoneNumber,
// //           imageUrl: imageUrl,
// //         );
// //
// //         await _firestore.collection('sellers').doc(user.uid).set(seller.toJson());
// //         _currentSeller = seller;
// //         notifyListeners();
// //       }
// //     } catch (e) {
// //       throw Exception('Error registering user: ${e.toString()}');
// //     }
// //   }
// //
// //   Future<void> login(String email, String password) async {
// //     try {
// //       final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
// //       final user = userCredential.user;
// //
// //       if (user != null) {
// //         final doc = await _firestore.collection('sellers').doc(user.uid).get();
// //
// //         if (doc.exists && doc.data() != null) {
// //           _currentSeller = Seller.fromJson(doc.data()!, user.uid);
// //           notifyListeners();
// //         } else {
// //           throw Exception('User data not found in Firestore.');
// //         }
// //       }
// //     } catch (e) {
// //       throw Exception('Error logging in: ${e.toString()}');
// //     }
// //   }
// // }
//
//
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../../models/seller/seller_model.dart';
//
// class AuthProvider with ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   Seller? _currentSeller;
//
//   Seller? get currentSeller => _currentSeller;
//
//   Future<void> register(String name, String email, String password, String phoneNumber) async {
//     try {
//       final userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
//       final user = userCredential.user;
//
//       if (user != null) {
//         final seller = Seller(
//           id: user.uid,
//           name: name,
//           email: email,
//           phoneNumber: phoneNumber,
//           imageUrl: null,
//         );
//
//         await _firestore.collection('sellers').doc(user.uid).set(seller.toJson());
//         _currentSeller = seller;
//         notifyListeners();
//       }
//     } catch (e) {
//       throw Exception('Error registering user: ${e.toString()}');
//     }
//   }
//
//   Future<void> login(String email, String password) async {
//     try {
//       final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
//       final user = userCredential.user;
//
//       if (user != null) {
//         final doc = await _firestore.collection('sellers').doc(user.uid).get();
//         if (doc.exists && doc.data() != null) {
//           _currentSeller = Seller.fromJson(doc.data()!, user.uid);
//           notifyListeners();
//         } else {
//           throw Exception('User data not found in Firestore.');
//         }
//       }
//     } catch (e) {
//       throw Exception('Error logging in: ${e.toString()}');
//     }
//   }
//
//   Future<void> resetPassword(String email) async {
//     try {
//       await _auth.sendPasswordResetEmail(email: email);
//     } catch (e) {
//       throw Exception('Error sending reset password email: ${e.toString()}');
//     }
//   }
// }


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../models/users/user_model.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Seller? _currentSeller;
  Seller? get currentSeller => _currentSeller;

  // Register a new seller
  Future<void> register(String name, String email, String password, String phoneNumber) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;

      if (user != null) {
        final defaultImage = "https://icons.veryicon.com/png/o/system/crm-android-app-icon/app-icon-person.png";

        final seller = Seller(
          id: user.uid,
          name: name,
          email: email,
          phoneNumber: phoneNumber,
          imageUrl: defaultImage,
        );

        await _firestore.collection('sellers').doc(user.uid).set(seller.toJson());
        _currentSeller = seller;
        notifyListeners();
      }
    }
    catch (e) {
      throw Exception('Error registering user: ${e.toString()}');
    }
  }

  // Login existing seller
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

  // Fetch current seller data
  Future<void> fetchCurrentSeller() async {
    try {
      final user = _auth.currentUser;

      if (user != null) {
        final doc = await _firestore.collection('sellers').doc(user.uid).get();

        if (doc.exists && doc.data() != null) {
          _currentSeller = Seller.fromJson(doc.data()!, user.uid);
          notifyListeners();
        } else {
          throw Exception('Seller data not found.');
        }
      } else {
        throw Exception('No user is currently logged in.');
      }
    } catch (e) {
      throw Exception('Error fetching seller data: ${e.toString()}');
    }
  }

  // Update profile image
  Future<void> updateProfileImage(File? image) async {
    try {
      if (image != null) {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          final storageRef = FirebaseStorage.instance.ref().child('profile_images/${user.uid}.jpg');
          await storageRef.putFile(image);
          final imageUrl = await storageRef.getDownloadURL();

          // Update the image URL in Firestore
          await FirebaseFirestore.instance.collection('sellers').doc(user.uid).update({
            'imageUrl': imageUrl,
          });

          // Update the local seller data
          _currentSeller = _currentSeller?.copyWith(imageUrl: imageUrl);
          notifyListeners();
        }
      }
    } catch (e) {
      throw Exception('Error updating profile image: ${e.toString()}');
    }
  }
}
