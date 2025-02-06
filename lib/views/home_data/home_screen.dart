// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:user_app/views/food_search/food_search_screen.dart';
// import 'package:user_app/views/user_favorite/user_favorite_screen.dart';
// import 'package:user_app/views/product/product_details_screen.dart';
//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:user_app/views/food_search/food_search_screen.dart';
// import 'package:user_app/views/user_favorite/user_favorite_screen.dart';
// import 'package:user_app/views/product/product_details_screen.dart';
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   String _searchQuery = '';
//   List<QueryDocumentSnapshot> _allProducts = [];
//   List<QueryDocumentSnapshot> _filteredProducts = [];
//   Set<String> _likedProducts = {};
//   bool _showIcons = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchProducts();
//   }
//
//   Future<void> _fetchProducts() async {
//     final QuerySnapshot snapshot = await _firestore.collection('products').get();
//     setState(() {
//       _allProducts = snapshot.docs;
//       _filteredProducts = _allProducts;
//     });
//   }
//
//   void _toggleLike(String productId) {
//     setState(() {
//       if (_likedProducts.contains(productId)) {
//         _likedProducts.remove(productId);
//       } else {
//         _likedProducts.add(productId);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: NotificationListener<ScrollNotification>(
//         onNotification: (ScrollNotification scrollInfo) {
//           if (scrollInfo.metrics.pixels > 50) {
//             if (_showIcons) {
//               setState(() {
//                 _showIcons = false;
//               });
//             }
//           } else {
//             if (!_showIcons) {
//               setState(() {
//                 _showIcons = true;
//               });
//             }
//           }
//           return true;
//         },
//         child: CustomScrollView(
//           slivers: [
//             SliverAppBar(
//               automaticallyImplyLeading: false,
//               expandedHeight: 140.0, // Jab tak scroll na ho, tab tak full height
//               collapsedHeight: 60.0, // Jab scroll ho jaye to sirf search bar show ho
//               floating: false,
//               pinned: true,
//               backgroundColor: const Color(0xFF096056),
//               flexibleSpace: LayoutBuilder(
//                 builder: (context, constraints) {
//                   bool isCollapsed = constraints.maxHeight <= 80;
//                   return FlexibleSpaceBar(
//                     centerTitle: true,
//                     titlePadding: EdgeInsets.zero,
//                     title: Padding(
//                       padding: const EdgeInsets.only(bottom: 10.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           AnimatedOpacity(
//                             opacity: _showIcons && !isCollapsed ? 1.0 : 0.0,
//                             duration: const Duration(milliseconds: 300),
//                             child: Padding(
//                               padding: const EdgeInsets.only(top: 50),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   IconButton(
//                                     icon: const Icon(Icons.favorite_border, color: Colors.white, size: 20),
//                                     onPressed: () {
//                                       Navigator.push(context, MaterialPageRoute(builder: (context) => LikedProductsScreen(likedProductIds: _likedProducts, toggleLike: (String ) {  },),));
//                                     },
//                                   ),
//                                   IconButton(
//                                     icon: const Icon(Icons.shopping_cart, color: Colors.white, size: 20),
//                                     onPressed: () {},
//                                   ),
//                                   IconButton(
//                                     icon: const Icon(Icons.notifications, color: Colors.white, size: 20),
//                                     onPressed: () {},
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                             child: GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (_) => FoodSearchScreen(products: _allProducts),
//                                   ),
//                                 );
//                               },
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: Container(
//                                       height: 40, // Search bar ka height kam kiya
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(16),
//                                       ),
//                                       child: TextField(
//                                         readOnly: true,
//                                         style: const TextStyle(fontSize: 14),
//                                         decoration: InputDecoration(
//                                           hintText: "Search products...",
//                                           contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//                                           border: InputBorder.none,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(width: 8),
//                                   Container(
//                                     padding: const EdgeInsets.all(8.0),
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(8),
//                                       boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 2)],
//                                     ),
//                                     child: const Icon(Icons.search, color: Colors.grey),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             SliverGrid(
//               delegate: SliverChildBuilderDelegate(
//                     (context, index) {
//                   final product = _filteredProducts[index];
//                   final data = product.data() as Map<String, dynamic>;
//
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => ProductDetailScreen(productId: product.id),
//                         ),
//                       );
//                     },
//
//                   child: Card(
//                   elevation: 4,
//                     margin: const EdgeInsets.all(8.0),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                     child: Stack(
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             ClipRRect(
//                               borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//                               child: (data['imageUrl'] != null && data['imageUrl'] is List && data['imageUrl'].isNotEmpty)
//                                   ? CarouselSlider(
//                                 options: CarouselOptions(
//                                   height: 140,
//                                   autoPlay: true,
//                                   enlargeCenterPage: true,
//                                   viewportFraction: 1.0,
//                                 ),
//                                 items: List.generate(data['imageUrl'].length, (index) {
//                                   return Image.network(
//                                     data['imageUrl'][index],
//                                     width: double.infinity,
//                                     height: 140,
//                                     fit: BoxFit.cover,
//                                     loadingBuilder: (context, child, loadingProgress) {
//                                       if (loadingProgress == null) return child;
//                                       return Container(
//                                         width: double.infinity,
//                                         height: 140,
//                                         color: Colors.grey[300],
//                                         child: const Center(child: CircularProgressIndicator()),
//                                       );
//                                     },
//                                     errorBuilder: (context, error, stackTrace) {
//                                       return Container(
//                                         width: double.infinity,
//                                         height: 140,
//                                         color: Colors.grey[300],
//                                         child: const Icon(Icons.broken_image, size: 40),
//                                       );
//                                     },
//                                   );
//                                 }),
//                               )
//                                   : (data['imageUrl'] != null && data['imageUrl'].toString().isNotEmpty)
//                                   ? Image.network(
//                                 data['imageUrl'],
//                                 width: double.infinity,
//                                 height: 140,
//                                 fit: BoxFit.cover,
//                               )
//                                   : Container(
//                                 width: double.infinity,
//                                 height: 140,
//                                 color: Colors.grey[300],
//                                 child: const Icon(Icons.image, size: 50),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     data['name'] ?? 'Unnamed Product',
//                                     style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                   const SizedBox(height: 4),
//                                   Text(
//                                     '\₹${data['price'] ?? 0}',
//                                     style: const TextStyle(fontSize: 14, color: Colors.green),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         Positioned(
//                           top: 5,
//                           right: 5,
//                           child: IconButton(
//                             icon: Icon(
//                               size: 30,
//                               _likedProducts.contains(product.id) ? Icons.favorite : Icons.favorite_border,
//                               color: _likedProducts.contains(product.id) ? Colors.red : Colors.black,
//                             ),
//                             onPressed: () => _toggleLike(product.id),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                       );
//                 },
//                 childCount: _filteredProducts.length,
//               ),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 8.0,
//                 mainAxisSpacing: 8.0,
//                 childAspectRatio: 0.8,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
// class FoodSearchScreen extends StatefulWidget {
//   final List<QueryDocumentSnapshot> products;
//
//   FoodSearchScreen({required this.products});
//
//   @override
//   _FoodSearchScreenState createState() => _FoodSearchScreenState();
// }
//
// class _FoodSearchScreenState extends State<FoodSearchScreen> {
//   String _searchQuery = '';
//   late List<QueryDocumentSnapshot> _filteredProducts;
//
//   @override
//   void initState() {
//     super.initState();
//     _filteredProducts = widget.products;
//   }
//
//   void _filterProducts(String query) {
//     setState(() {
//       _searchQuery = query;
//       _filteredProducts = widget.products
//           .where((product) {
//         final productName = (product.data() as Map<String, dynamic>)['name'] ?? '';
//         return productName.toLowerCase().contains(query.toLowerCase());
//       })
//           .toList();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF096056),
//         title: const Text('Food Search'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               onChanged: _filterProducts,
//               decoration: InputDecoration(
//                 hintText: 'Search for products...',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 prefixIcon: const Icon(Icons.search),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _filteredProducts.length,
//               itemBuilder: (context, index) {
//                 final product = _filteredProducts[index];
//                 final data = product.data() as Map<String, dynamic>;
//
//                 return ListTile(
//                   title: Text(
//                     data['name'] ?? 'Unnamed Product',
//                     style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   onTap: () {
//                     // Navigate to the product details screen when a name is tapped
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => ProductDetailScreen(productId: product.id),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:seller_app/views/product/add_product_screen.dart';
// // import 'package:seller_app/views/product/product_details_screen.dart';
// // import 'package:seller_app/views/seller_data/seller_profile/seller_profile_screen.dart';
// // import 'package:seller_app/views/settings/settings_screen.dart';
// //
// // import '../food_search/food_search_screen.dart';
// //
// //
// // // Home Tab
// // class HomeScreen extends StatefulWidget {
// //   @override
// //   _HomeScreenState createState() => _HomeScreenState();
// // }
// //
// // class _HomeScreenState extends State<HomeScreen> {
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //   String _searchQuery = '';
// //   List<QueryDocumentSnapshot> _allProducts = [];
// //   List<QueryDocumentSnapshot> _filteredProducts = [];
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _fetchProducts();
// //   }
// //
// //   // Fetch products from Firestore
// //   Future<void> _fetchProducts() async {
// //     final QuerySnapshot snapshot = await _firestore.collection('products').get();
// //     setState(() {
// //       _allProducts = snapshot.docs;
// //       _filteredProducts = _allProducts;
// //     });
// //   }
// //
// //   // Filter products based on search query
// //   void _filterProducts(String query) {
// //     setState(() {
// //       _searchQuery = query;
// //       _filteredProducts = _allProducts.where((product) {
// //         final name = (product.data() as Map<String, dynamic>)['name'] ?? '';
// //         return name.toLowerCase().contains(query.toLowerCase());
// //       }).toList();
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: CustomScrollView(
// //         slivers: [
// //           SliverAppBar(
// //             automaticallyImplyLeading: false,
// //             expandedHeight: 100.0, // Yeh aapka app bar ka height hai
// //             floating: false, // App bar floating nahi hoga
// //             pinned: true, // App bar scroll hone ke baad bhi top pe sticky rahega
// //             backgroundColor: Color(0xFF096056),
// //             flexibleSpace: FlexibleSpaceBar(
// //               title: Padding(
// //                 padding: const EdgeInsets.only(top: 50.0,), // Title ke liye space
// //                 child: Center(child: Text('Seller Data', style: TextStyle(color: Colors.white))),
// //               ),
// //             ),
// //           ),
// //
// //           // TextField ko SliverToBoxAdapter mein wrap karenge
// //           SliverToBoxAdapter(
// //             child: Padding(
// //               padding: const EdgeInsets.all(8.0),
// //               child: TextField(
// //                 decoration: InputDecoration(
// //                   border: OutlineInputBorder(),
// //                   suffixIcon: IconButton(
// //                     icon: Icon(Icons.search),
// //                     onPressed: () async {
// //                       // Yahaan aapka search action perform hoga
// //                       showSearch(
// //                         context: context,
// //                         delegate: ProductSearchDelegate(_allProducts),
// //                       );
// //                     },
// //                   ),
// //                 ),
// //               onTap: () =>  showSearch(
// //                 context: context,
// //                 delegate: ProductSearchDelegate(_allProducts),
// //               ),  // onChanged ko hata diya gaya hai, taaki typing se koi action na ho
// //               ),
// //
// //             ),
// //           ),
// //
// //           // Product Grid View
// //           SliverGrid(
// //             delegate: SliverChildBuilderDelegate(
// //                   (context, index) {
// //                 final product = _filteredProducts[index];
// //                 final data = product.data() as Map<String, dynamic>;
// //
// //                 return GestureDetector(
// //                   onTap: () {
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                         builder: (_) => ProductDetailScreen(productId: product.id),
// //                       ),
// //                     );
// //                   },
// //                   child: Padding(
// //                     padding: const EdgeInsets.all(8.0),
// //                     child: Container(
// //                       decoration: BoxDecoration(
// //                         borderRadius: BorderRadius.all(Radius.circular(15)),
// //                       ),
// //                       child: Card(
// //                         elevation: 4,
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Container(
// //                               decoration: BoxDecoration(
// //                                 borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
// //                               ),
// //                               child: data['imageUrl'] != null && data['imageUrl'].isNotEmpty
// //                                   ? Image.network(
// //                                 data['imageUrl'],
// //                                 width: double.infinity,
// //                                 height: 120,
// //                                 fit: BoxFit.cover,
// //                               )
// //                                   : Container(
// //                                 width: double.infinity,
// //                                 height: 0,
// //                                 color: Colors.grey[300],
// //                                 child: Icon(Icons.image, size: 50),
// //                               ),
// //                             ),
// //                             Padding(
// //                               padding: const EdgeInsets.all(8.0),
// //                               child: Column(
// //                                 crossAxisAlignment: CrossAxisAlignment.start,
// //                                 children: [
// //                                   Text(
// //                                     data['name'] ?? 'Unnamed Product',
// //                                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// //                                   ),
// //                                   SizedBox(height: 4),
// //                                   Text(
// //                                     '\₹${data['price'] ?? 0}',
// //                                     style: TextStyle(fontSize: 14, color: Colors.green),
// //                                   ),
// //                                 ],
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 );
// //               },
// //               childCount: _filteredProducts.length,
// //             ),
// //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //               crossAxisCount: 2,
// //               crossAxisSpacing: 8.0,
// //               mainAxisSpacing: 8.0,
// //               childAspectRatio: 0.8,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// //
// //
//
//
//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:seller_app/views/product/product_details_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:seller_app/views/product/product_details_screen.dart';
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   String _selectedLocation = "Fetching location...";
//   List<QueryDocumentSnapshot> _allProducts = [];
//   List<QueryDocumentSnapshot> _filteredProducts = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchProducts();
//     _getCurrentLocation();
//   }
//
//   // 📍 **Fetch Current Location**
//   Future<void> _getCurrentLocation() async {
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//       List<Placemark> placemarks =
//       await placemarkFromCoordinates(position.latitude, position.longitude);
//       setState(() {
//         _selectedLocation =
//         "${placemarks[0].locality}, ${placemarks[0].administrativeArea}";
//       });
//     } catch (e) {
//       setState(() {
//         _selectedLocation = "Location Unavailable";
//       });
//     }
//   }
//
//   // 🔄 **Fetch Products from Firestore**
//   Future<void> _fetchProducts() async {
//     final QuerySnapshot snapshot =
//     await _firestore.collection('products').get();
//     setState(() {
//       _allProducts = snapshot.docs;
//       _filteredProducts = _allProducts;
//     });
//   }
//
//   // 🌍 **Open Location Selection**
//   Future<void> _openLocationSelection() async {
//     final selectedLocation = await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => LocationSelectionScreen()),
//     );
//
//     if (selectedLocation != null) {
//       setState(() {
//         _selectedLocation = selectedLocation;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: RefreshIndicator(
//         onRefresh: _fetchProducts,
//         child: CustomScrollView(
//           slivers: [
//             // 📌 **AppBar with Location Dropdown**
//             SliverAppBar(
//               automaticallyImplyLeading: false,
//               expandedHeight: 100.0,
//               floating: false,
//               pinned: true,
//               backgroundColor: Color(0xFF096056),
//               flexibleSpace: FlexibleSpaceBar(
//                 title: GestureDetector(
//                   onTap:
//                   _openLocationSelection, // 👆 Click se location selection screen open hogi
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         _selectedLocation,
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                       ),
//                       SizedBox(width: 5),
//                       Icon(Icons.arrow_drop_down, color: Colors.white),
//                     ],
//                   ),
//                 ),
//                 centerTitle: true,
//               ),
//             ),
//
//             // 📌 **Product Carousel Slider**
//             SliverToBoxAdapter(
//               child: _filteredProducts.isNotEmpty
//                   ? CarouselSlider(
//                 options: CarouselOptions(
//                   height: 220.0,
//                   autoPlay: true,
//                   enlargeCenterPage: true,
//                   aspectRatio: 16 / 9,
//                   autoPlayInterval: Duration(seconds: 3),
//                   viewportFraction: 0.8,
//                 ),
//                 items: _filteredProducts.map((product) {
//                   final data = product.data() as Map<String, dynamic>;
//                   final List<dynamic>? imageUrls = data['images']; // Get images list
//
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => ProductDetailScreen(productId: product.id),
//                         ),
//                       );
//                     },
//                     child: Container(
//                       margin: EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       child: imageUrls != null && imageUrls.isNotEmpty
//                           ? CarouselSlider(
//                         options: CarouselOptions(
//                           height: 220.0,
//                           autoPlay: true,
//                           enlargeCenterPage: true,
//                           aspectRatio: 16 / 9,
//                           viewportFraction: 1.0,
//                         ),
//                         items: imageUrls.map<Widget>((imgUrl) {
//                           return ClipRRect(
//                             borderRadius: BorderRadius.circular(15),
//                             child: Image.network(
//                               imgUrl,
//                               fit: BoxFit.cover,
//                               width: double.infinity,
//                             ),
//                           );
//                         }).toList(),
//                       )
//                           : ClipRRect(
//                         borderRadius: BorderRadius.circular(15),
//                         child: Image.asset(
//                           'assets/placeholder.png',
//                           fit: BoxFit.cover,
//                           width: double.infinity,
//                         ),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               )
//                   : Center(child: CircularProgressIndicator()), // Loading state
//             ),
//             // Padding(
//             //   padding: const EdgeInsets.all(18.0),
//             //   child: Text("Treanding Food",style: TextStyle(fontSize: 20),),
//             // ),
//             SliverGrid(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 4, // ✅ 2 Columns in Grid
//                 crossAxisSpacing: 8, // ✅ Horizontal spacing
//                 mainAxisSpacing: 20, // ✅ Vertical spacing
//                 childAspectRatio: 0.75, // ✅ Adjust aspect ratio for better layout
//               ),
//               delegate: SliverChildBuilderDelegate(
//                     (context, index) {
//                   final product = _filteredProducts[index];
//                   final data = product.data() as Map<String, dynamic>;
//                   final List<dynamic>? imageUrls = data['images']; // ✅ Multiple images support
//
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => ProductDetailScreen(productId: product.id),
//                         ),
//                       );
//                     },
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         if (imageUrls != null && imageUrls.isNotEmpty)
//                           ClipRRect(
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(55),
//                               topRight: Radius.circular(55),
//                               bottomRight: Radius.circular(55),
//                               bottomLeft: Radius.circular(55),
//                             ),
//                             child: Image.network(
//                               imageUrls[0],
//                               width: double.infinity,
//                               height: 100, // ✅ Adjust image height
//                               fit: BoxFit.cover,
//                               loadingBuilder: (context, child, loadingProgress) {
//                                 if (loadingProgress == null) return child;
//                                 return Container(
//                                   height: 100,
//                                   color: Colors.grey[300],
//                                   child: Center(child:Icon(Icons.food_bank)),
//                                 );
//                               },
//                             ),
//                           )
//                         else
//                           Container(
//                             height: 50,
//                             color: Colors.grey[300],
//                             child: Center(
//                               child: Icon(Icons.fastfood, size: 50, color: Colors.grey),
//                             ),
//                           ),
//
//                         // ✅ **Product Details**
//
//                       ],
//                     ),
//                   );
//                 },
//                 childCount: _filteredProducts.length,
//               ),
//             ),
//             SliverGrid(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2, // ✅ 2 Columns in Grid
//                 crossAxisSpacing: 8, // ✅ Horizontal spacing
//                 mainAxisSpacing: 8, // ✅ Vertical spacing
//                 childAspectRatio: 0.75, // ✅ Adjust aspect ratio for better layout
//               ),
//               delegate: SliverChildBuilderDelegate(
//                     (context, index) {
//                   final product = _filteredProducts[index];
//                   final data = product.data() as Map<String, dynamic>;
//                   final List<dynamic>? imageUrls = data['images']; // ✅ Multiple images support
//
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => ProductDetailScreen(productId: product.id),
//                         ),
//                       );
//                     },
//                     child: Card(
//                       elevation: 4,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // ✅ **Show Product Image (First Image from List)**
//                           if (imageUrls != null && imageUrls.isNotEmpty)
//                             ClipRRect(
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(15),
//                                 topRight: Radius.circular(15),
//                               ),
//                               child: Image.network(
//                                 imageUrls[0],
//                                 width: double.infinity,
//                                 height: 150, // ✅ Adjust image height
//                                 fit: BoxFit.cover,
//                                 loadingBuilder: (context, child, loadingProgress) {
//                                   if (loadingProgress == null) return child;
//                                   return Container(
//                                     height: 150,
//                                     color: Colors.grey[300],
//                                     child: Center(child:Icon(Icons.food_bank)),
//                                   );
//                                 },
//                               ),
//                             )
//                           else
//                             Container(
//                               height: 150,
//                               color: Colors.grey[300],
//                               child: Center(
//                                 child: Icon(Icons.fastfood, size: 50, color: Colors.grey),
//                               ),
//                             ),
//
//                           // ✅ **Product Details**
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   data['name'] ?? 'Unnamed Product',
//                                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//                                   maxLines: 1, // ✅ Limit text to 1 line
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 SizedBox(height: 4),
//                                 Text(
//                                   '₹${data['price'] ?? 0}',
//                                   style: TextStyle(fontSize: 14, color: Colors.green),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//                 childCount: _filteredProducts.length,
//               ),
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class LocationSelectionScreen extends StatelessWidget {
//   final List<String> _nearbyLocations = [
//     "Maker, Bihar",
//     "Jagdishpur, Bihar",
//     "Bishunpura, Bihar",
//     "Sonho, Bihar",
//     "Bheldi, Bihar"
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Select Location",style: TextStyle(color: Colors.white),),
//         backgroundColor: Color(0xFF096056),
//       ),
//       body: ListView.builder(
//         itemCount: _nearbyLocations.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(_nearbyLocations[index]),
//             trailing: Icon(Icons.location_on, color: Colors.green),
//             onTap: () {
//               Navigator.pop(context, _nearbyLocations[index]); // Selected location ko return kar rahe hain
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
//




import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../food_search/food_search_screen.dart';
import '../product/product_details_screen.dart';
import '../user_favorite/user_favorite_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _selectedLocation = "Fetching location...";
  List<QueryDocumentSnapshot> _allProducts = [];
  List<QueryDocumentSnapshot> _filteredProducts = [];
   bool _showIcons = true;
  Set<String> _likedProducts = {}; // ✅ Liked Products store karega


  @override
  void initState() {
    super.initState();
    _fetchProducts();
    _getCurrentLocation();
  }
  void _toggleLike(String productId) {
    setState(() {
      if (_likedProducts.contains(productId)) {
        _likedProducts.remove(productId);
      } else {
        _likedProducts.add(productId);
      }
    });
  }

  // 📍 **Fetch Current Location**
  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
      setState(() {
        _selectedLocation =
        "${placemarks[0].locality}, ${placemarks[0].administrativeArea}";
      });
    } catch (e) {
      setState(() {
        _selectedLocation = "Location Unavailable";
      });
    }
  }
  List<Map<String, String>> categories = [
    {'name': 'Pizza', 'image': 'assets/categories/pizza.png'},
    {'name': 'Burger', 'image': 'assets/categories/burger.png'},
    {'name': 'Sushi', 'image': 'assets/categories/sushi.png'},
    {'name': 'Drinks', 'image': 'assets/categories/drinks.png'},
    {'name': 'Desserts', 'image': 'assets/categories/dessert.png'},
  ];
  // 🔄 **Fetch Products from Firestore**
  Future<void> _fetchProducts() async {
    final QuerySnapshot snapshot =
    await _firestore.collection('products').get();
    setState(() {
      _allProducts = snapshot.docs;
      _filteredProducts = _allProducts;
    });
  }

  // 🌍 **Open Location Selection**
  Future<void> _openLocationSelection() async {
    final selectedLocation = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LocationSelectionScreen()),
    );

    if (selectedLocation != null) {
      setState(() {
        _selectedLocation = selectedLocation;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _fetchProducts,
        child: CustomScrollView(
          slivers: [
            // 📌 **AppBar**
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 140.0,
              collapsedHeight: 60.0,
              floating: false,
              pinned: true,
              backgroundColor: const Color(0xFF096056),
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  bool isCollapsed = constraints.maxHeight <= 80;
                  return FlexibleSpaceBar(
                    centerTitle: true,
                    titlePadding: EdgeInsets.zero,
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (!isCollapsed) // ✅ Icons ko hide/show karna
                          Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.favorite,
                                      color: _likedProducts.isNotEmpty
                                          ? Colors.white
                                          : Colors.white),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LikedProductsScreen(
                                          likedProductIds: _likedProducts.toList(),
                                          toggleLike: _toggleLike,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.shopping_cart, color: Colors.white),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        // ✅ Search Bar
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => FoodSearchScreen(products: _allProducts),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: TextField( onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => FoodSearchScreen(products: _allProducts),
                                        ),
                                      );
                                    },
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        hintText: "Search products...",
                                        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Container(decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(14)),color: Colors.white,),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(Icons.search, color: Colors.grey),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,
                  ),
                  items: [
                    'assets/images/3.jpg',
                    'assets/images/2.jpg',
                  ].map((imagePath) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Categories",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),

                  // 📌 **Horizontal Scroll Category List**
                  Container(
                    height: 150, // ✅ Set height for proper layout
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal, // ✅ Horizontal scrolling enabled
                      itemCount: _filteredProducts.length, // ✅ Ensure valid index
                      itemBuilder: (context, index) {
                        final product = _filteredProducts[index];
                        final data = product.data() as Map<String, dynamic>;
                        final List<dynamic>? imageUrls = data['images'];

                        return GestureDetector(
                          onTap: () {
                            // ✅ Handle tap event here
                          },
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle, // ✅ Circular shape
                                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3)],
                                ),
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: imageUrls != null && imageUrls.isNotEmpty
                                      ? NetworkImage(imageUrls[0]) // ✅ Firebase image URL
                                      : AssetImage('assets/placeholder.png') as ImageProvider, // ✅ Placeholder image
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                data['name'] ?? 'Unknown', // ✅ Product name show kare
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),


                  // 📌 **All Food Text**
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "All Food",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),


            // 📌 **Grid with Like Button**
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.75,
              ),
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final product = _filteredProducts[index];
                  final data = product.data() as Map<String, dynamic>;
                  final List<dynamic>? imageUrls = data['images'];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailScreen(productId: product.id),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ✅ Image
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                                child: Image.network(
                                  imageUrls?.isNotEmpty == true ? imageUrls![0] : 'https://via.placeholder.com/150',
                                  width: double.infinity,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              // ✅ Product Details
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['name'] ?? 'Unnamed Product',
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '₹${data['price'] ?? 0}',
                                      style: TextStyle(fontSize: 14, color: Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          // ✅ Like Icon (Top Right)
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () => _toggleLike(product.id),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  _likedProducts.contains(product.id)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: _likedProducts.contains(product.id) ? Colors.red : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: _filteredProducts.length,
              ),
            ),
          ],
        ),
      ),
    );

  }
}

class LocationSelectionScreen extends StatelessWidget {
  final List<String> _nearbyLocations = [
    "Maker, Bihar",
    "Jagdishpur, Bihar",
    "Bishunpura, Bihar",
    "Sonho, Bihar",
    "Bheldi, Bihar"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Location",style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF096056),
      ),
      body: ListView.builder(
        itemCount: _nearbyLocations.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_nearbyLocations[index]),
            trailing: Icon(Icons.location_on, color: Colors.green),
            onTap: () {
              Navigator.pop(context, _nearbyLocations[index]); // Selected location ko return kar rahe hain
            },
          );
        },
      ),
    );
  }
}



class FoodSearchScreen extends StatefulWidget {
  final List<QueryDocumentSnapshot> products;

  FoodSearchScreen({required this.products});

  @override
  _FoodSearchScreenState createState() => _FoodSearchScreenState();
}

class _FoodSearchScreenState extends State<FoodSearchScreen> {
  String _searchQuery = '';
  late List<QueryDocumentSnapshot> _filteredProducts;

  @override
  void initState() {
    super.initState();
    _filteredProducts = widget.products;
  }

  void _filterProducts(String query) {
    setState(() {
      _searchQuery = query;
      _filteredProducts = widget.products
          .where((product) {
        final productName = (product.data() as Map<String, dynamic>)['name'] ?? '';
        return productName.toLowerCase().contains(query.toLowerCase());
      })
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF096056),
        title: const Text('Food Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _filterProducts,
              decoration: InputDecoration(
                hintText: 'Search for products...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredProducts.length,
              itemBuilder: (context, index) {
                final product = _filteredProducts[index];
                final data = product.data() as Map<String, dynamic>;

                return ListTile(
                  title: Text(
                    data['name'] ?? 'Unnamed Product',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    // Navigate to the product details screen when a name is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailScreen(productId: product.id),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}