// //
// //
// //
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:seller_app/views/product/product_update_screen.dart';
// //
// // import '../../utils/imports.dart';
// //
// // class ProductDetailScreen extends StatelessWidget {
// //   final String productId;
// //
// //   ProductDetailScreen({required this.productId});
// //
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('Product Details')),
// //       body: FutureBuilder<DocumentSnapshot>(
// //         future: _firestore.collection('products').doc(productId).get(),
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return Center(child: CircularProgressIndicator());
// //           }
// //
// //           if (snapshot.hasError) {
// //             return Center(child: Text('Error: ${snapshot.error}'));
// //           }
// //
// //           final data = snapshot.data?.data() as Map<String, dynamic>?;
// //
// //           if (data == null) {
// //             return Center(child: Text('Product not found'));
// //           }
// //
// //
// //           return Padding(
// //             padding: const EdgeInsets.all(16.0),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 data['imageUrl'] != null
// //                     ?  Image.network(
// //                   data['imageUrl'] ?? '',
// //                   height: 150,  // Reduced height for the image
// //                   width: double.infinity,
// //                   fit: BoxFit.cover,
// //                 )
// //                     : Container(height: 100, color: Colors.grey[300]),
// //                 SizedBox(height: 16),
// //                 Text('Name: ${data['name']}', style: TextStyle(fontSize: 20)),
// //                 SizedBox(height: 8),
// //                 Text('Price: \₹${data['price']}', style: TextStyle(fontSize: 18)),
// //                 SizedBox(height: 8),
// //                 Text('Description: ${data['description']}', style: TextStyle(fontSize: 16)),
// //                 SizedBox(height: 20),
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                   children: [
// //                     ElevatedButton(
// //                       onPressed: () {
// //                         Navigator.push(
// //                           context,
// //                           MaterialPageRoute(
// //                             builder: (context) => ProductUpdateScreen(productId: productId),
// //                           ),
// //                         );
// //                       },
// //                       child: Text('Edit'),
// //                     ),
// //                     ElevatedButton(
// //                       onPressed: () async {
// //                         // Show the confirmation toast with options
// //                         showDialog(
// //                           context: context,
// //                           builder: (BuildContext context) {
// //                             return AlertDialog(
// //                               title: Text('Delete Product'),
// //                               content: Text('Are you sure you want to delete this product?'),
// //                               actions: [
// //                                 TextButton(
// //                                   onPressed: () {
// //                                     Navigator.pop(context);
// //                                   },
// //                                   child: Text('Cancel'),
// //                                 ),
// //                                 TextButton(
// //                                   onPressed: () async {
// //                                     // Proceed with deleting the product
// //                                     await _firestore.collection('products').doc(productId).delete();
// //                                     Fluttertoast.showToast(msg: 'Product deleted');
// //                                     Navigator.pop(context);  // Close the dialog
// //                                     Navigator.pop(context);  // Go back to previous screen
// //                                   },
// //                                   child: Text('Delete'),
// //                                 ),
// //                               ],
// //                             );
// //                           },
// //                         );
// //                       },
// //                       child: Text('Delete'),
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
// //
// //
//
//
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../view_models/product_view_model.dart';
// import 'add_to_cart_screen.dart';
// import 'buy_now_screen.dart';
// import 'product_update_screen.dart';
//
// class ProductDetailScreen extends StatelessWidget {
//   final String productId;
//
//   const ProductDetailScreen({super.key, required this.productId});
//
//   @override
//   Widget build(BuildContext context) {
//     final productViewModel = Provider.of<ProductViewModel>(context);
//
//     // Fetch product data
//     productViewModel.fetchProduct(productId);
//
//     final product = productViewModel.productDetails;
//
//     return Scaffold(
//       appBar: AppBar(title: Text('Product Details')),
//       body: product == null
//           ? Center(child: CircularProgressIndicator())
//           : Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             product['imageUrl'] != null
//                 ? Image.network(
//               product['imageUrl'],
//               height: 200,width: 400,
//               fit: BoxFit.cover,
//             )
//                 : Container(height: 200, decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(22))),),
//
//             SizedBox(height: 16),
//
//             // Product Details
//             Text('Name: ${product['name']}', style: TextStyle(fontSize: 20)),
//             Text('Price: ₹${product['price']}', style: TextStyle(fontSize: 18)),
//             Text('Description: ${product['description']}', style: TextStyle(fontSize: 16)),
//             Text('Discount: ${product['discount']}%'),
//             Text('stock: ${product['stock']}'),
//
//             SizedBox(height: 20),
//
//            Row(
//              children: [
//                ElevatedButton(onPressed: () {
//                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddToCartScreen(),));
//                }, child: Text("Add to Cart")),
//                SizedBox(width: 30,),
//                ElevatedButton(onPressed: () {
//                  Navigator.push(context, MaterialPageRoute(builder: (context) => BuyNowScreen(),));
//
//                }, child: Text("Buy Now",)),
//              ],
//            )
//           ],
//         ),
//       ),
//     );
//   }
// }


//
//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:seller_app/views/product/product_update_screen.dart';
//
// import '../../utils/imports.dart';
//
// class ProductDetailScreen extends StatelessWidget {
//   final String productId;
//
//   ProductDetailScreen({required this.productId});
//
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Product Details')),
//       body: FutureBuilder<DocumentSnapshot>(
//         future: _firestore.collection('products').doc(productId).get(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//
//           final data = snapshot.data?.data() as Map<String, dynamic>?;
//
//           if (data == null) {
//             return Center(child: Text('Product not found'));
//           }
//
//
//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 data['imageUrl'] != null
//                     ?  Image.network(
//                   data['imageUrl'] ?? '',
//                   height: 150,  // Reduced height for the image
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 )
//                     : Container(height: 100, color: Colors.grey[300]),
//                 SizedBox(height: 16),
//                 Text('Name: ${data['name']}', style: TextStyle(fontSize: 20)),
//                 SizedBox(height: 8),
//                 Text('Price: \₹${data['price']}', style: TextStyle(fontSize: 18)),
//                 SizedBox(height: 8),
//                 Text('Description: ${data['description']}', style: TextStyle(fontSize: 16)),
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ProductUpdateScreen(productId: productId),
//                           ),
//                         );
//                       },
//                       child: Text('Edit'),
//                     ),
//                     ElevatedButton(
//                       onPressed: () async {
//                         // Show the confirmation toast with options
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return AlertDialog(
//                               title: Text('Delete Product'),
//                               content: Text('Are you sure you want to delete this product?'),
//                               actions: [
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                   },
//                                   child: Text('Cancel'),
//                                 ),
//                                 TextButton(
//                                   onPressed: () async {
//                                     // Proceed with deleting the product
//                                     await _firestore.collection('products').doc(productId).delete();
//                                     Fluttertoast.showToast(msg: 'Product deleted');
//                                     Navigator.pop(context);  // Close the dialog
//                                     Navigator.pop(context);  // Go back to previous screen
//                                   },
//                                   child: Text('Delete'),
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//                       },
//                       child: Text('Delete'),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
//
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import '../../view_models/product_view_model.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;

  ProductDetailScreen({required this.productId});

  @override
  Widget build(BuildContext context) {
    final productViewModel = Provider.of<ProductViewModel>(context);

    // Fetch product details
    productViewModel.fetchProduct(productId);
    final product = productViewModel.productDetails;

    return Scaffold(
      appBar: AppBar(title: Text('Product Details')),
      body: product == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Images with Carousel
            if (product['images'] != null && product['images'].length > 1)
              CarouselSlider(
                options: CarouselOptions(height: 250, autoPlay: true,),
                items: product['images'].map<Widget>((imgUrl) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      imgUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  );
                }).toList(),
              )
            else if (product['images'] != null && product['images'].isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product['images'][1],
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
            else
              Container(
                height: 250,
                color: Colors.grey[300],
                alignment: Alignment.center,
                child: Icon(Icons.image, size: 50, color: Colors.grey[700]),
              ),

            SizedBox(height: 16),

            // Product Details
            Text(product['name'], style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text('Price: ₹${product['price']}', style: TextStyle(fontSize: 18, color: Colors.green)),
            Text('Discount: ${product['discount']}%', style: TextStyle(fontSize: 16, color: Colors.red)),
            SizedBox(height: 8),
            Text(product['description'], style: TextStyle(fontSize: 16, color: Colors.grey[700])),

            SizedBox(height: 20),


          ],
        ),
      ),
    );
  }
}
