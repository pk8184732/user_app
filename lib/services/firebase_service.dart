



import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveSeller(String userId, Map<String, dynamic> data) async {
    await _firestore.collection('sellers').doc(userId).set(data);
  }

  Future<void> addProduct(String sellerId, Map<String, dynamic> data) async {
    await _firestore.collection('sellers/$sellerId/products').add(data);
  }

  Future<List<Map<String, dynamic>>> fetchProducts(String sellerId) async {
    final snapshot = await _firestore.collection('sellers/$sellerId/products').get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}
