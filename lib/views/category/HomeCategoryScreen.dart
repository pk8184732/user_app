

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../foods/food_details_screen.dart';
import '../home_data/home_navigation_bar.dart';

class HomeCategoryScreen extends StatefulWidget {
  final String categoryName;

  const HomeCategoryScreen({super.key, required this.categoryName});

  @override
  State<HomeCategoryScreen> createState() => _HomeCategoryScreenState();
}

class _HomeCategoryScreenState extends State<HomeCategoryScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<QueryDocumentSnapshot> _filteredFoods = [];

  @override
  void initState() {
    super.initState();
    _fetchFoods();
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
      _filteredFoods = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName,style: const TextStyle(color: Colors.white),),
        leading: ClipOval(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.white)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeNavigationBar()),
                );
              },
              icon: const Icon(Icons.arrow_back_ios_new,
                  color: Color(0xFF096056)),
            ),
          ),
        ),
        backgroundColor: const Color(0xFF096056),
      ),
      body: _filteredFoods.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: _filteredFoods.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            childAspectRatio: 0.66,
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
                            height: 110,
                            width: double.infinity,
                            fit: BoxFit.cover,
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
