

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteFoodScreen extends StatefulWidget {
  final List<String> likedProductIds;
  final Function(String) toggleLike;

  const FavoriteFoodScreen({
    super.key,
    required this.likedProductIds,
    required this.toggleLike,
  });

  @override
  _FavoriteFoodScreenState createState() => _FavoriteFoodScreenState();
}

class _FavoriteFoodScreenState extends State<FavoriteFoodScreen> {
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
                  Navigator.pop(context);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => const HomeNavigationBar(),
                  //     ));
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
          : GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        itemCount: likedProducts.length,
        itemBuilder: (context, index) {
          var product = likedProducts[index];
          var imageUrls = product['images'];

          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: imageUrls != null && imageUrls.isNotEmpty
                        ? Image.network(
                      imageUrls[0],
                      fit: BoxFit.cover,
                    )
                        : Image.asset(
                      'assets/placeholder.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['name'] ?? 'Unnamed',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text('₹${product['price'] ?? 'N/A'}'),
                      Padding(
                        padding: const EdgeInsets.only(left: 110,bottom: 10,),
                        child: CircleAvatar(
                          backgroundColor: Color(0xFFE4E4E4) ,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: const Icon(Icons.favorite, color: Colors.red),
                              onPressed: () => _confirmRemoveProduct(product['id']),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),

    );
  }
}
