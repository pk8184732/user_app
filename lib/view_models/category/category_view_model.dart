

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class CategoryViewModel extends ChangeNotifier {
  String _selectedCategory = "lunch";
  List<CategoryModel> _products = [];

  String get selectedCategory => _selectedCategory;
  List<CategoryModel> get products => _products;

  void changeCategory(String category) {
    _selectedCategory = category;
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('food_categories')
          .doc(_selectedCategory)
          .collection('foods')
          .get();

      _products = querySnapshot.docs
          .map((doc) => CategoryModel.fromJson(doc.data(), doc.id))
          .toList();
      notifyListeners();
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await FirebaseFirestore.instance
          .collection('food_categories')
          .doc(_selectedCategory)
          .collection('foods')
          .doc(productId)
          .delete();

      _products.removeWhere((product) => product.id == productId);
      notifyListeners();
    } catch (e) {
      print("Error deleting Foods: $e");
    }
  }

  Future<void> updateProduct(CategoryModel updatedProduct, File? newImageFile) async {
    try {
      String imageUrl = updatedProduct.imageUrl;

      if (newImageFile != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child("product_images")
            .child("${updatedProduct.id}.jpg");

        await storageRef.putFile(newImageFile);
        imageUrl = await storageRef.getDownloadURL();
      }

      await FirebaseFirestore.instance
          .collection('food_categories')
          .doc(_selectedCategory)
          .collection('foods')
          .doc(updatedProduct.id)
          .update({
        "name": updatedProduct.name,
        "price": updatedProduct.price,
        "description": updatedProduct.description,
        "imageUrl": imageUrl,
      });

      int index = _products.indexWhere((p) => p.id == updatedProduct.id);
      if (index != -1) {
        _products[index] = updatedProduct.copyWith(imageUrl: imageUrl);
        notifyListeners();
      }
    } catch (e) {
      print("Error updating Foods: $e");
    }
  }
}

class CategoryModel {
  final String id;
  final String name;
  final double price;
  final String description;
  final String imageUrl;
  final String category;

  CategoryModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.category,
  });

  CategoryModel copyWith({
    String? id,
    String? name,
    double? price,
    String? description,
    String? imageUrl,
    String? category,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
    );
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json, String id) {
    return CategoryModel(
      id: id,
      name: json['name'] ?? '',
      price: (json['price'] as num).toDouble(),
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      category: json['category'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "price": price,
      "description": description,
      "imageUrl": imageUrl,
      "category": category,
    };
  }
}
