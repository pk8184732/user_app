

import 'package:flutter/material.dart';
import '../../models/product/food_model.dart';
import '../../services/firebase_service.dart';

class FoodProvider with ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  List<FoodModel> _foods = [];

  List<FoodModel> get foods => _foods;

  Future<void> addProduct({
    required String name,
    required double price,
    required String description,
    required double discount,
    required int stock,
    required int quantity,
    required String imageUrl,
  }) async {

  }

  Future<void> fetchFoods() async {
    final data = await _firebaseService.fetchFoods('sellerId');

    _foods = data.map((json) => FoodModel.fromJson(json, json['id'] ?? '')).toList();
    notifyListeners();
  }
}
