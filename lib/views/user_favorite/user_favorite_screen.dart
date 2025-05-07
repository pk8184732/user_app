

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../home_data/home_navigation_bar.dart';

class UserFavoriteScreen extends StatefulWidget {
  final List<String> likedProductIds;
  final Function(String) toggleLike;

  const UserFavoriteScreen({
    super.key,
    required this.likedProductIds,
    required this.toggleLike,
  });

  @override
  _UserFavoriteScreenState createState() => _UserFavoriteScreenState();
}

class _UserFavoriteScreenState extends State<UserFavoriteScreen> {
  List<Map<String, dynamic>> likedProducts = [];

  @override
  void initState() {
    super.initState();
    _fetchLikedProductsDetails();
  }

  void _fetchLikedProductsDetails() async {
    List<Map<String, dynamic>> products = [];

    for (String productId in widget.likedProductIds) {
      var snapshot = await FirebaseFirestore.instance.collection('foods').doc(productId).get();
      if (snapshot.exists) {
        var data = snapshot.data();
        if (data != null) {
          products.add({
            'id': productId,
            'name': data['name'],
            'price': data['price'],
            'images': data['images'],
          });
        }
      }
    }

    setState(() {
      likedProducts = products;
    });
  }

  void _confirmRemoveProduct(String productId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Remove from Favorites"),
          content: const Text("Do you want to remove this Food from favorites?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Remove", style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
                widget.toggleLike(productId);
                setState(() {
                  likedProducts.removeWhere((item) => item['id'] == productId);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Food removed from favorites")),
                );
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text("Favorite Foods",style: TextStyle(color: Colors.white),),
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
                        builder: (context) => const HomeNavigationBar(),
                      ));
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Color(0xFF096056),
                )),
          ),
        ),
        backgroundColor: const Color(0xFF096056),
      ),
      body: likedProducts.isEmpty
          ? const Center(child: Text("No Favorite Foods yet!"))
          : ListView.builder(
        itemCount: likedProducts.length,
        itemBuilder: (context, index) {
          var product = likedProducts[index];
          var imageUrls = product['images'];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: imageUrls != null && imageUrls.isNotEmpty
                    ? NetworkImage(imageUrls[0])
                    : const AssetImage('assets/placeholder.png') as ImageProvider,
              ),
              title: Text(product['name'] ?? 'Unnamed'),
              subtitle: Text('₹${product['price'] ?? 'N/A'}'),
              trailing: IconButton(
                icon: const Icon(Icons.favorite, color: Colors.red),
                onPressed: () => _confirmRemoveProduct(product['id']),
              ),
            ),
          );
        },
      ),
    );
  }
}
