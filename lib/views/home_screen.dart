

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_app/views/settings/settings_screen.dart';
import 'package:user_app/views/user_profile/user_profile_screen.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // Index for bottom navigation
  final List<Widget> _screens = [HomeTab(), SellerProfileScreen(), SettingsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home',backgroundColor: Color(0xFF096056)),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile',backgroundColor: Color(
              0xFF096056)),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add',backgroundColor: Color(
              0xFF096056)),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings',backgroundColor: Color(0xFF096056)),
        ],
      ),
    );
  }
}

// Home Tab
class HomeTab extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<QueryDocumentSnapshot>> fetchProducts() async {
    final QuerySnapshot snapshot = await _firestore.collection('products').get();
    return snapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: FutureBuilder<List<QueryDocumentSnapshot>>(
        future: fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final products = snapshot.data ?? [];

          if (products.isEmpty) {
            return Center(child: Text('No products found'));
          }

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.8,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              final data = product.data() as Map<String, dynamic>;

              return GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => ProductDetailScreen(productId: product.id),
                  //   ),
                  // );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15),bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15))),
                    child: Card(
                      elevation: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))),

                            child: data['imageUrl'] != null && data['imageUrl'].isNotEmpty
                                ? Image.network(
                              data['imageUrl'],
                              width: double.infinity,
                              height: 120,
                              fit: BoxFit.cover,
                            )
                                : Container(
                              width: double.infinity,
                              height: 120,
                              color: Colors.grey[300],
                              child: Icon(Icons.image, size: 50),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data['name'] ?? 'Unnamed Product',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '\₹${data['price'] ?? 0}',
                                  style: TextStyle(fontSize: 14, color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}


