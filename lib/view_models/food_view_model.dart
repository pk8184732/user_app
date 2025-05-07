import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Map<String, dynamic>? foodDetails;

  Future<void> fetchFood(String foodsId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('foods').doc(foodsId).get();
      if (doc.exists) {
        foodDetails = doc.data() as Map<String, dynamic>;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error fetching food: $e');
    }
  }

  Future<void> updateFood(String foodsId, Map<String, dynamic> updates) async {
    try {
      await _firestore.collection('foods').doc(foodsId).update(updates);
      notifyListeners();
    } catch (e) {
      debugPrint('Error updating food: $e');
    }
  }

  Future<void> deleteFood(String foodsId) async {
    try {
      await _firestore.collection('foods').doc(foodsId).delete();
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting food: $e');
    }
  }
}
