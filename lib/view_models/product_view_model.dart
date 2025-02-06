import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Product Details
  Map<String, dynamic>? productDetails;

  // Fetch Product Data
  Future<void> fetchProduct(String productId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('products').doc(productId).get();
      if (doc.exists) {
        productDetails = doc.data() as Map<String, dynamic>;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error fetching product: $e');
    }
  }

  // Update Product Data
  Future<void> updateProduct(String productId, Map<String, dynamic> updates) async {
    try {
      await _firestore.collection('products').doc(productId).update(updates);
      notifyListeners(); // Notify listeners after update
    } catch (e) {
      debugPrint('Error updating product: $e');
    }
  }

  // Delete Product
  Future<void> deleteProduct(String productId) async {
    try {
      await _firestore.collection('products').doc(productId).delete();
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting product: $e');
    }
  }
}
