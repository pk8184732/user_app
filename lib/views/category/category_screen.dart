// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// //
// // import '../foods/food_details_screen.dart';
// //
// // class CategoryScreen extends StatelessWidget {
// //   const CategoryScreen({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Categories'),
// //         backgroundColor: const Color(0xFF096056),
// //       ),
// //       body: ChangeNotifierProvider(
// //         create: (_) => CategoryViewModel(),
// //         child: Consumer<CategoryViewModel>(
// //           builder: (context, viewModel, child) {
// //             if (viewModel.categories.isEmpty && viewModel.products.isEmpty) {
// //               return const Center(child: CircularProgressIndicator());
// //             }
// //
// //             return Row(
// //               children: [
// //                 Container(
// //                   width: 130,
// //                   color: Colors.grey[200],
// //                   child: Column(
// //                     children: [
// //                       Expanded(
// //                         child: ListView.builder(
// //                           itemCount: viewModel.categories.length,
// //                           itemBuilder: (context, index) {
// //                             final category = viewModel.categories[index];
// //                             final isSelected =
// //                                 category.name == viewModel._selectedCategory;
// //
// //                             return GestureDetector(
// //                               onTap: () =>
// //                                   viewModel.filterProductsByCategory(category.name),
// //                               child: Container(
// //                                 padding: const EdgeInsets.all(8.0),
// //                                 color: isSelected
// //                                     ? Colors.green[100]
// //                                     : Colors.transparent,
// //                                 child: Column(
// //                                   children: [
// //                                     category.imageUrl.isNotEmpty
// //                                         ? Image.network(
// //                                       category.imageUrl,
// //                                       width: 60,
// //                                       height: 60,
// //                                       fit: BoxFit.cover,
// //                                     )
// //                                         : const Icon(Icons.category, size: 40),
// //                                     const SizedBox(height: 4),
// //                                     Text(
// //                                       category.name,
// //                                       textAlign: TextAlign.center,
// //                                       style: const TextStyle(fontSize: 12),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ),
// //                             );
// //                           },
// //                         ),
// //                       ),
// //                       Expanded(
// //                         flex: 6,
// //                         child: SingleChildScrollView(
// //                           child: Column(
// //                             children: viewModel.filteredProducts
// //                                 .map((product) => GestureDetector(
// //                               onTap: () {
// //                                 viewModel.filterProductsByType(product.name);
// //                               },
// //                               child: Column(
// //                                 children: [
// //                                   product.imageUrl.isNotEmpty
// //                                       ? Image.network(
// //                                     product.imageUrl,
// //                                     width: 100,
// //                                     height: 100,
// //                                     fit: BoxFit.cover,
// //                                   )
// //                                       : const Icon(Icons.image, size: 50),
// //                                   const SizedBox(height: 4),
// //                                   Text(
// //                                     product.name,
// //                                     textAlign: TextAlign.center,
// //                                     style: const TextStyle(fontSize: 12),
// //                                   ),
// //                                 ],
// //                               ),
// //                             ))
// //                                 .toList(),
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //
// //                 Expanded(
// //                   child: viewModel.filteredProductsByType.isEmpty
// //                       ? const Center(
// //                     child: Text(
// //                       'No products found!',
// //                       style: TextStyle(fontSize: 16),
// //                     ),
// //                   )
// //                       : GridView.builder(
// //                     padding: const EdgeInsets.all(8.0),
// //                     gridDelegate:
// //                     const SliverGridDelegateWithFixedCrossAxisCount(
// //                       crossAxisCount: 2,
// //                       crossAxisSpacing: 8.0,
// //                       mainAxisSpacing: 8.0,
// //                       childAspectRatio: 0.8,
// //                     ),
// //                     itemCount: viewModel.filteredProductsByType.length,
// //                     itemBuilder: (context, index) {
// //                       final product = viewModel.filteredProductsByType[index];
// //                       return GestureDetector(
// //                         onTap: () {
// //                           Navigator.push(
// //                             context,
// //                             MaterialPageRoute(
// //                               builder: (_) => FoodsDetailScreen(
// //                                   foodsId: product.id),
// //                             ),
// //                           );
// //                         },
// //                         child: SizedBox(height: 333,
// //                           child: Card(
// //
// //                             shape: RoundedRectangleBorder(
// //                               borderRadius: BorderRadius.circular(15),
// //                             ),
// //                             child: Column(
// //                               crossAxisAlignment: CrossAxisAlignment.start,
// //                               children: [
// //                                 product.imageUrl.isNotEmpty
// //                                     ? ClipRRect(
// //                                   borderRadius: const BorderRadius.vertical(
// //                                       top: Radius.circular(15)),
// //                                   child: Image.network(
// //                                     product.imageUrl,
// //                                     width: double.infinity,
// //                                     height: 80,
// //                                     fit: BoxFit.cover,
// //                                   ),
// //                                 )
// //                                     : Container(
// //                                   width: double.infinity,
// //                                   height: 120,
// //                                   color: Colors.grey[300],
// //                                   child: const Icon(Icons.image, size: 50),
// //                                 ),
// //                                 Padding(
// //                                   padding: const EdgeInsets.all(8.0),
// //                                   child: Text(
// //                                     product.name,
// //                                     style: const TextStyle(
// //                                         fontSize: 16,
// //                                         fontWeight: FontWeight.bold),
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         ),
// //                       );
// //                     },
// //                   ),
// //                 ),
// //               ],
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class CategoryViewModel extends ChangeNotifier {
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //
// //   List<CategoryModel> _categories = [];
// //   List<ProductModel> _products = [];
// //   List<ProductModel> _filteredProducts = [];
// //   List<ProductModel> _filteredProductsByType = [];
// //
// //   String _selectedCategory = 'All';
// //
// //   List<CategoryModel> get categories => _categories;
// //   List<ProductModel> get products => _products;
// //   List<ProductModel> get filteredProducts => _filteredProducts;
// //   List<ProductModel> get filteredProductsByType => _filteredProductsByType;
// //
// //   CategoryViewModel() {
// //     _fetchCategoriesAndProducts();
// //   }
// //
// //   Future<void> _fetchCategoriesAndProducts() async {
// //     try {
// //       final categoriesSnapshot = await _firestore.collection('categories').get();
// //       _categories = categoriesSnapshot.docs
// //           .map((doc) => CategoryModel.fromMap(doc.id, doc.data()))
// //           .toList();
// //
// //       _categories.insert(0, CategoryModel(id: 'all', name: 'All', imageUrl: ''));
// //
// //       final productsSnapshot = await _firestore.collection('products').get();
// //       _products = productsSnapshot.docs
// //           .map((doc) => ProductModel.fromMap(doc.id, doc.data()))
// //           .toList();
// //
// //       _filteredProducts = _products;
// //       _filteredProductsByType = _products;
// //
// //       notifyListeners();
// //     } catch (error) {
// //       print('Error fetching data: $error');
// //     }
// //   }
// //
// //   void filterProductsByCategory(String category) {
// //     _selectedCategory = category;
// //
// //     if (category == 'All') {
// //       _filteredProducts = _products;
// //       _filteredProductsByType = _products;
// //     } else {
// //       _filteredProducts = _products
// //           .where((product) => product.category.toLowerCase() == category.toLowerCase())
// //           .toList();
// //       _filteredProductsByType = _filteredProducts;
// //     }
// //
// //     notifyListeners();
// //   }
// //
// //   void filterProductsByType(String type) {
// //     _filteredProductsByType = _filteredProducts
// //         .where((product) => product.name.toLowerCase().contains(type.toLowerCase()))
// //         .toList();
// //     notifyListeners();
// //   }
// // }
// //
// // class CategoryModel {
// //   final String id;
// //   final String name;
// //   final String imageUrl;
// //
// //   CategoryModel({required this.id, required this.name, required this.imageUrl});
// //
// //   factory CategoryModel.fromMap(String id, Map<String, dynamic> data) {
// //     return CategoryModel(
// //       id: id,
// //       name: data['name'] ?? 'Unnamed Category',
// //       imageUrl: data['imageUrl'] ?? '',
// //     );
// //   }
// // }
// //
// // class ProductModel {
// //   final String id;
// //   final String name;
// //   final String imageUrl;
// //   final double price;
// //   final String category;
// //
// //   ProductModel({
// //     required this.id,
// //     required this.name,
// //     required this.imageUrl,
// //     required this.price,
// //     required this.category,
// //   });
// //
// //   factory ProductModel.fromMap(String id, Map<String, dynamic> data) {
// //     return ProductModel(
// //       id: id,
// //       name: data['name'] ?? 'Unnamed Product',
// //       imageUrl: data['imageUrl'] ?? '',
// //       price: (data['price'] ?? 0).toDouble(),
// //       category: data['category'] ?? '',
// //     );
// //   }
// // }
//
//
//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// // Replace with your actual food detail screen
// import '../foods/food_details_screen.dart';
//
// class CategoryScreen extends StatelessWidget {
//   const CategoryScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Categories'),
//         backgroundColor: const Color(0xFF096056),
//       ),
//       body: ChangeNotifierProvider(
//         create: (_) => CategoryViewModel(),
//         child: Consumer<CategoryViewModel>(
//           builder: (context, viewModel, child) {
//             if (viewModel.categories.isEmpty && viewModel.products.isEmpty) {
//               return const Center(child: CircularProgressIndicator());
//             }
//
//             return LayoutBuilder(
//               builder: (context, constraints) {
//                 return Row(
//                   children: [
//                     Container(
//                       width: constraints.maxWidth * 0.3,
//                       color: Colors.grey[200],
//                       child: Column(
//                         children: [
//                           Expanded(
//                             child: ListView.builder(
//                               itemCount: viewModel.categories.length,
//                               itemBuilder: (context, index) {
//                                 final category = viewModel.categories[index];
//                                 final isSelected =
//                                     category.name == viewModel.selectedCategory;
//
//                                 return GestureDetector(
//                                   onTap: () => viewModel
//                                       .filterProductsByCategory(category.name),
//                                   child: Container(
//                                     padding: const EdgeInsets.all(8.0),
//                                     color: isSelected
//                                         ? Colors.green[100]
//                                         : Colors.transparent,
//                                     child: Column(
//                                       children: [
//                                         category.imageUrl.isNotEmpty
//                                             ? Image.network(
//                                           category.imageUrl,
//                                           width: 60,
//                                           height: 60,
//                                           fit: BoxFit.cover,
//                                         )
//                                             : const Icon(Icons.category, size: 40),
//                                         const SizedBox(height: 4),
//                                         Text(
//                                           category.name,
//                                           textAlign: TextAlign.center,
//                                           style: const TextStyle(fontSize: 12),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                           Expanded(
//                             flex: 6,
//                             child: SingleChildScrollView(
//                               child: Column(
//                                 children: viewModel.uniqueProductNames.map((product) {
//                                   return GestureDetector(
//                                     onTap: () {
//                                       viewModel.filterProductsByType(product.name);
//                                     },
//                                     child: Column(
//                                       children: [
//                                         product.imageUrl.isNotEmpty
//                                             ? Image.network(
//                                           product.imageUrl,
//                                           width: 100,
//                                           height: 100,
//                                           fit: BoxFit.cover,
//                                         )
//                                             : const Icon(Icons.image, size: 50),
//                                         const SizedBox(height: 4),
//                                         Text(
//                                           product.name,
//                                           textAlign: TextAlign.center,
//                                           style: const TextStyle(fontSize: 12),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 }).toList(),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: viewModel.filteredProductsByType.isEmpty
//                           ? const Center(
//                         child: Text(
//                           'No products found!',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       )
//                           : GridView.builder(
//                         padding: const EdgeInsets.all(8.0),
//                         gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           crossAxisSpacing: 8.0,
//                           mainAxisSpacing: 8.0,
//                           childAspectRatio: 0.8,
//                         ),
//                         itemCount:
//                         viewModel.filteredProductsByType.length,
//                         itemBuilder: (context, index) {
//                           final product =
//                           viewModel.filteredProductsByType[index];
//                           return GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (_) => FoodsDetailScreen(
//                                       foodsId: product.id),
//                                 ),
//                               );
//                             },
//                             child: SizedBox(
//                               height: 333,
//                               child: Card(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(15),
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment:
//                                   CrossAxisAlignment.start,
//                                   children: [
//                                     product.imageUrl.isNotEmpty
//                                         ? ClipRRect(
//                                       borderRadius:
//                                       const BorderRadius.vertical(
//                                           top:
//                                           Radius.circular(
//                                               15)),
//                                       child: Image.network(
//                                         product.imageUrl,
//                                         width: double.infinity,
//                                         height: 100,
//                                         fit: BoxFit.cover,
//                                       ),
//                                     )
//                                         : Container(
//                                       width: double.infinity,
//                                       height: 100,
//                                       color: Colors.grey[300],
//                                       child: const Icon(Icons.image,
//                                           size: 50),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Text(
//                                         product.name,
//                                         style: const TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class CategoryViewModel extends ChangeNotifier {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   List<CategoryModel> _categories = [];
//   List<ProductModel> _products = [];
//   List<ProductModel> _filteredProducts = [];
//   List<ProductModel> _filteredProductsByType = [];
//
//   String _selectedCategory = 'All';
//
//   List<CategoryModel> get categories => _categories;
//   List<ProductModel> get products => _products;
//   List<ProductModel> get filteredProducts => _filteredProducts;
//   List<ProductModel> get filteredProductsByType => _filteredProductsByType;
//   String get selectedCategory => _selectedCategory;
//
//   List<ProductModel> get uniqueProductNames {
//     final Map<String, ProductModel> uniqueMap = {};
//     for (var product in _filteredProducts) {
//       if (!uniqueMap.containsKey(product.name.toLowerCase())) {
//         uniqueMap[product.name.toLowerCase()] = product;
//       }
//     }
//     return uniqueMap.values.toList();
//   }
//
//   CategoryViewModel() {
//     _fetchCategoriesAndProducts();
//   }
//
//   Future<void> _fetchCategoriesAndProducts() async {
//     try {
//       final categoriesSnapshot =
//       await _firestore.collection('categories').get();
//       _categories = categoriesSnapshot.docs
//           .map((doc) => CategoryModel.fromMap(doc.id, doc.data()))
//           .toList();
//
//       _categories.insert(0,
//           CategoryModel(id: 'all', name: 'All', imageUrl: ''));
//
//       final productsSnapshot =
//       await _firestore.collection('products').get();
//       _products = productsSnapshot.docs
//           .map((doc) => ProductModel.fromMap(doc.id, doc.data()))
//           .toList();
//
//       _filteredProducts = _products;
//       _filteredProductsByType = _products;
//
//       notifyListeners();
//     } catch (error) {
//       print('Error fetching data: $error');
//     }
//   }
//
//   void filterProductsByCategory(String category) {
//     _selectedCategory = category;
//     if (category == 'All') {
//       _filteredProducts = _products;
//       _filteredProductsByType = _products;
//     } else {
//       _filteredProducts = _products
//           .where((product) =>
//       product.category.toLowerCase() == category.toLowerCase())
//           .toList();
//       _filteredProductsByType = _filteredProducts;
//     }
//     notifyListeners();
//   }
//
//   void filterProductsByType(String productName) {
//     final selectedProduct = _products.firstWhere(
//           (product) =>
//       product.name.toLowerCase() == productName.toLowerCase(),
//       orElse: () =>
//           ProductModel(id: '', name: '', imageUrl: '', price: 0, category: ''),
//     );
//
//     if (selectedProduct.category.isNotEmpty) {
//       _filteredProductsByType = _products
//           .where((product) =>
//       product.category.toLowerCase() ==
//           selectedProduct.category.toLowerCase())
//           .toList();
//     } else {
//       _filteredProductsByType = [];
//     }
//     notifyListeners();
//   }
// }
//
// class CategoryModel {
//   final String id;
//   final String name;
//   final String imageUrl;
//
//   CategoryModel({required this.id, required this.name, required this.imageUrl});
//
//   factory CategoryModel.fromMap(String id, Map<String, dynamic> data) {
//     return CategoryModel(
//       id: id,
//       name: data['name'] ?? 'Unnamed Category',
//       imageUrl: data['imageUrl'] ?? '',
//     );
//   }
// }
//
// class ProductModel {
//   final String id;
//   final String name;
//   final String imageUrl;
//   final double price;
//   final String category;
//
//   ProductModel({
//     required this.id,
//     required this.name,
//     required this.imageUrl,
//     required this.price,
//     required this.category,
//   });
//
//   factory ProductModel.fromMap(String id, Map<String, dynamic> data) {
//     return ProductModel(
//       id: id,
//       name: data['name'] ?? 'Unnamed Product',
//       imageUrl: data['imageUrl'] ?? '',
//       price: (data['price'] ?? 0).toDouble(),
//       category: data['category'] ?? '',
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../foods/food_details_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<QueryDocumentSnapshot> _allFoods = [];
  List<QueryDocumentSnapshot> _filteredFoods = [];

  @override
  void initState() {
    super.initState();
    _fetchFoods();
  }

  Future<void> _fetchFoods() async {
    final snapshot = await _firestore.collection('foods').get();
    setState(() {
      _allFoods = snapshot.docs;
      _filteredFoods = _allFoods;
    });
  }

  // void _filterByCategory(String name) {
  //   setState(() {
  //     _filteredFoods = _allFoods.where((doc) {
  //       final data = doc.data() as Map<String, dynamic>;
  //       return data['name'] == name;
  //     }).toList();
  //   });
  // }

  void _filterByCategory(String keyword) {
    setState(() {
      _filteredFoods = _allFoods.where((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final name = (data['name'] ?? '').toString().toLowerCase();
        return name.contains(keyword.toLowerCase());
      }).toList();
    });
  }


  void _resetFilter() {
    setState(() {
      _filteredFoods = _allFoods;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get unique categories by name
    final Map<String, QueryDocumentSnapshot> uniqueCategories = {};
    for (var doc in _allFoods) {
      final data = doc.data() as Map<String, dynamic>;
      final name = data['name'];
      if (name != null && !uniqueCategories.containsKey(name)) {
        uniqueCategories[name] = doc;
      }
    }

    final categoryList = uniqueCategories.entries.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        backgroundColor: const Color(0xFF096056),
      ),
      body: RefreshIndicator(
        onRefresh: _fetchFoods,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Choose a Category",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 110,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryList.length,
                        itemBuilder: (context, index) {
                          final food = categoryList[index].value;
                          final data = food.data() as Map<String, dynamic>;
                          final name = data['name'];
                          final List<dynamic>? imageUrls = data['images'];

                          return GestureDetector(
                            onTap: () => _filterByCategory(name),
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3)],
                                  ),
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundImage: imageUrls != null && imageUrls.isNotEmpty
                                        ? NetworkImage(imageUrls[0])
                                        : const AssetImage('assets/placeholder.png') as ImageProvider,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(name ?? 'Unknown',
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _resetFilter,
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF096056)),
                      child: const Text("Show All", style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 15),
                    const Text("Foods", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final food = _filteredFoods[index];
                  final data = food.data() as Map<String, dynamic>;
                  final List<dynamic>? imageUrls = data['images'];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FoodsDetailScreen(foodsId: food.id),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius:
                            const BorderRadius.vertical(top: Radius.circular(15)),
                            child: Image.network(
                              imageUrls?.isNotEmpty == true
                                  ? imageUrls![0]
                                  : 'https://via.placeholder.com/150',
                              height: 130,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data['name'] ?? '',
                                    style: const TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.bold)),
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
                childCount: _filteredFoods.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.68,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
