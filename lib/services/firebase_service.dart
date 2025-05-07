



import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveSeller(String userId, Map<String, dynamic> data) async {
    await _firestore.collection('users').doc(userId).set(data);
  }

  Future<List<Map<String, dynamic>>> fetchFoods(String sellerId) async {
    final snapshot = await _firestore.collection('users/$sellerId/foods').get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}
