//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:user_app/views/home_data/home_screen.dart';
//
// class LikedProductsScreen extends StatefulWidget {
//   final Set<String> likedProductIds;
//   final Function(String) toggleLike; // Function to toggle like/unlike
//
//   const LikedProductsScreen({required this.likedProductIds, required this.toggleLike});
//
//   @override
//   _LikedProductsScreenState createState() => _LikedProductsScreenState();
// }
//
// class _LikedProductsScreenState extends State<LikedProductsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(leading: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: CircleAvatar(child: IconButton(color: Colors.white,
//           onPressed:() {
//           Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
//         } , icon: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.black,),)),
//       ),
//         title: Text("Liked Foods",style: TextStyle(color: Colors.white),),backgroundColor: Color(0xFF096056),),
//       body: widget.likedProductIds.isEmpty
//           ? Center(child: Text("Don't Like Any Product")) // If no likes, show message
//           : FutureBuilder<QuerySnapshot>(
//         future: FirebaseFirestore.instance
//             .collection('products')
//             .where(FieldPath.documentId, whereIn: widget.likedProductIds.toList())
//             .get(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
//           final likedProducts = snapshot.data!.docs;
//
//           return ListView.builder(
//             itemCount: likedProducts.length,
//             itemBuilder: (context, index) {
//               final product = likedProducts[index];
//               final data = product.data() as Map<String, dynamic>;
//               final productId = product.id;
//
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Card(
//                   child: ListTile(
//                     leading: data['imageUrl'] != null
//                         ? Image.network(data['imageUrl'], width: 50, height: 50, fit: BoxFit.cover)
//                         : Icon(Icons.image),
//                     title: Text(data['name'] ?? 'Unnamed Product'),
//                     subtitle: Text('\₹${data['price'] ?? 0}'),
//                     trailing: IconButton(
//                       icon: Icon(
//                         widget.likedProductIds.contains(productId) ? Icons.favorite : Icons.favorite_border,
//                         color: widget.likedProductIds.contains(productId) ? Colors.red : Colors.grey,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           widget.toggleLike(productId); // Toggle like/unlike
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class LikedProductsScreen extends StatefulWidget {
  final List<String> likedProductIds;
  final Function(String) toggleLike;


  LikedProductsScreen({required this.likedProductIds, required this.toggleLike});

  @override
  _LikedProductsScreenState createState() => _LikedProductsScreenState();
}

class _LikedProductsScreenState extends State<LikedProductsScreen> {
  List<String> likedProducts = [];

  @override
  void initState() {
    super.initState();
    likedProducts = List.from(widget.likedProductIds); // ✅ Copy of likedProductIds
  }

  void _removeProduct(String productId) {
    setState(() {
      likedProducts.remove(productId); // ✅ Remove from list instantly
    });
    widget.toggleLike(productId); // ✅ Call function to update global state
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liked Products"),
        backgroundColor: Color(0xFF096056),
      ),
      body: likedProducts.isEmpty
          ? Center(
        child: Text(
          "No liked products yet!",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      )
          : ListView.builder(
        itemCount: likedProducts.length,
        itemBuilder: (context, index) {
          String productId = likedProducts[index];

          return FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('products')
                .doc(productId)
                .get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              var productData = snapshot.data!.data() as Map<String, dynamic>;
              String productName = productData['name'] ?? 'Unnamed Product';
              var productPrice = productData['price']; // Price can be dynamic
              List<dynamic>? imageUrls = productData['images'];

              // Convert price to a string, in case it is a number
              String priceString = '';
              if (productPrice is double || productPrice is int) {
                priceString = productPrice.toString();
              } else {
                priceString = productPrice ?? 'Price unavailable';
              }

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: imageUrls != null && imageUrls.isNotEmpty
                        ? NetworkImage(imageUrls[0]) // ✅ Product Image
                        : AssetImage('assets/placeholder.png') as ImageProvider,
                  ),
                  title: Text(productName),
                  subtitle: Text(priceString), // Display the price
                  trailing: IconButton(
                    icon: Icon(Icons.favorite, color: Colors.red),
                    onPressed: () {
                      _removeProduct(productId); // ✅ Instantly remove on unlike
                    },
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
