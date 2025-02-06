//
// import 'package:flutter/material.dart';
//
// class AddToCartScreen extends StatefulWidget {
//   const AddToCartScreen({super.key});
//
//   @override
//   State<AddToCartScreen> createState() => _AddToCartScreenState();
// }
//
// class _AddToCartScreenState extends State<AddToCartScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Liked Products")),
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
//               return ListTile(
//                 leading: data['imageUrl'] != null
//                     ? Image.network(data['imageUrl'], width: 50, height: 50, fit: BoxFit.cover)
//                     : Icon(Icons.image),
//                 title: Text(data['name'] ?? 'Unnamed Product'),
//                 subtitle: Text('\₹${data['price'] ?? 0}'),
//                 trailing: IconButton(
//                   icon: Icon(
//                     widget.likedProductIds.contains(productId) ? Icons.favorite : Icons.favorite_border,
//                     color: widget.likedProductIds.contains(productId) ? Colors.red : Colors.grey,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       widget.toggleLike(productId); // Toggle like/unlike
//                     });
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );  }
// }
//


import 'package:flutter/material.dart';

class AddToCartScreen extends StatefulWidget {
  const AddToCartScreen({super.key});

  @override
  State<AddToCartScreen> createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add To Cart"),),
    );
  }
}
