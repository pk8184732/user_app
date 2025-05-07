

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../foods/food_details_screen.dart';

class HomeCategoryScreen extends StatefulWidget {
  final String categoryName;

  const HomeCategoryScreen({super.key, required this.categoryName});

  @override
  State<HomeCategoryScreen> createState() => _HomeCategoryScreenState();
}

class _HomeCategoryScreenState extends State<HomeCategoryScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<QueryDocumentSnapshot> _allFoods = [];
  List<QueryDocumentSnapshot> _filteredFoods = [];
  final Set<String> _likedFoods = {};

  @override
  void initState() {
    super.initState();
    _fetchFoods();
  }

  void _toggleLike(String foodId) {
    setState(() {
      if (_likedFoods.contains(foodId)) {
        _likedFoods.remove(foodId);
      } else {
        _likedFoods.add(foodId);
      }
    });
  }

  Future<void> _fetchFoods() async {
    final QuerySnapshot snapshot = await _firestore.collection('foods').get();
    final all = snapshot.docs;
    final filtered = all.where((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final name = (data['name'] ?? '').toString().toLowerCase();
      return name.contains(widget.categoryName.toLowerCase());
    }).toList();

    setState(() {
      _allFoods = all;
      _filteredFoods = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        backgroundColor: const Color(0xFF096056),
      ),
      body: _filteredFoods.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: _filteredFoods.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.68,
          ),
          itemBuilder: (context, index) {
            final food = _filteredFoods[index];
            final data = food.data() as Map<String, dynamic>;
            final List<dynamic>? imageUrls = data['images'];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        FoodsDetailScreen(foodsId: food.id),
                  ),
                );
              },
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(15)),
                          child: Image.network(
                            imageUrls?.isNotEmpty == true
                                ? imageUrls![0]
                                : 'https://via.placeholder.com/150',
                            height: 130,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            icon: Icon(
                              _likedFoods.contains(food.id)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: _likedFoods.contains(food.id)
                                  ? Colors.red
                                  : Colors.white,
                            ),
                            onPressed: () => _toggleLike(food.id),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data['name'] ?? '',
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                          Text('₹${data['price'] ?? 0}',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.green)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
