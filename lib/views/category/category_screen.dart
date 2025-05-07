

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../foods/food_details_screen.dart';
//
// class CategoryScreen extends StatefulWidget {
//   const CategoryScreen({super.key});
//
//   @override
//   State<CategoryScreen> createState() => _CategoryScreenState();
// }
//
// class _CategoryScreenState extends State<CategoryScreen> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   List<QueryDocumentSnapshot> _allFoods = [];
//   List<QueryDocumentSnapshot> _filteredFoods = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchFoods();
//   }
//
//   Future<void> _fetchFoods() async {
//     final snapshot = await _firestore.collection('foods').get();
//     setState(() {
//       _allFoods = snapshot.docs;
//       _filteredFoods = _allFoods;
//     });
//   }
//
//   // void _filterByCategory(String name) {
//   //   setState(() {
//   //     _filteredFoods = _allFoods.where((doc) {
//   //       final data = doc.data() as Map<String, dynamic>;
//   //       return data['name'] == name;
//   //     }).toList();
//   //   });
//   // }
//
//   void _filterByCategory(String keyword) {
//     setState(() {
//       _filteredFoods = _allFoods.where((doc) {
//         final data = doc.data() as Map<String, dynamic>;
//         final name = (data['name'] ?? '').toString().toLowerCase();
//         return name.contains(keyword.toLowerCase());
//       }).toList();
//     });
//   }
//
//
//   void _resetFilter() {
//     setState(() {
//       _filteredFoods = _allFoods;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Get unique categories by name
//     final Map<String, QueryDocumentSnapshot> uniqueCategories = {};
//     for (var doc in _allFoods) {
//       final data = doc.data() as Map<String, dynamic>;
//       final name = data['name'];
//       if (name != null && !uniqueCategories.containsKey(name)) {
//         uniqueCategories[name] = doc;
//       }
//     }
//
//     final categoryList = uniqueCategories.entries.toList();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Categories'),
//         backgroundColor: const Color(0xFF096056),
//       ),
//       body: RefreshIndicator(
//         onRefresh: _fetchFoods,
//         child: CustomScrollView(
//           slivers: [
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text("Choose a Category",
//                         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                     const SizedBox(height: 10),
//                     SizedBox(
//                       height: 110,
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: categoryList.length,
//                         itemBuilder: (context, index) {
//                           final food = categoryList[index].value;
//                           final data = food.data() as Map<String, dynamic>;
//                           final name = data['name'];
//                           final List<dynamic>? imageUrls = data['images'];
//
//                           return GestureDetector(
//                             onTap: () => _filterByCategory(name),
//                             child: Column(
//                               children: [
//                                 Container(
//                                   margin: const EdgeInsets.symmetric(horizontal: 8),
//                                   decoration: const BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3)],
//                                   ),
//                                   child: CircleAvatar(
//                                     radius: 40,
//                                     backgroundImage: imageUrls != null && imageUrls.isNotEmpty
//                                         ? NetworkImage(imageUrls[0])
//                                         : const AssetImage('assets/placeholder.png') as ImageProvider,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 5),
//                                 Text(name ?? 'Unknown',
//                                     style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     ElevatedButton(
//                       onPressed: _resetFilter,
//                       style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF096056)),
//                       child: const Text("Show All", style: TextStyle(color: Colors.white)),
//                     ),
//                     const SizedBox(height: 15),
//                     const Text("Foods", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   ],
//                 ),
//               ),
//             ),
//             SliverGrid(
//               delegate: SliverChildBuilderDelegate(
//                     (context, index) {
//                   final food = _filteredFoods[index];
//                   final data = food.data() as Map<String, dynamic>;
//                   final List<dynamic>? imageUrls = data['images'];
//
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => FoodsDetailScreen(foodsId: food.id),
//                         ),
//                       );
//                     },
//                     child: Card(
//                       elevation: 3,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           ClipRRect(
//                             borderRadius:
//                             const BorderRadius.vertical(top: Radius.circular(15)),
//                             child: Image.network(
//                               imageUrls?.isNotEmpty == true
//                                   ? imageUrls![0]
//                                   : 'https://via.placeholder.com/150',
//                               height: 130,
//                               width: double.infinity,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(data['name'] ?? '',
//                                     style: const TextStyle(
//                                         fontSize: 14, fontWeight: FontWeight.bold)),
//                                 Text('₹${data['price'] ?? 0}',
//                                     style: const TextStyle(
//                                         fontSize: 14, color: Colors.green)),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//                 childCount: _filteredFoods.length,
//               ),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 10,
//                 crossAxisSpacing: 10,
//                 childAspectRatio: 0.68,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../../view_models/category/category_view_model.dart';
import '../home_data/home_navigation_bar.dart';
import 'category_food_details.dart';

class CategoryWiseFoodScreen extends StatelessWidget {
  final List<String> _categories = ["breakfast", "lunch", "dinner", "snacks"];

  CategoryWiseFoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryViewModel = Provider.of<CategoryViewModel>(context);

    return Scaffold(
      appBar: AppBar(
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
        title: const Text(
          "Show Categories Food",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF096056),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: _categories.map((category) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ChoiceChip(
                      backgroundColor: const Color(0xFF89BCB6),
                      label: Text(
                        category.toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      selected: categoryViewModel.selectedCategory == category,
                      onSelected: (selected) {
                        if (selected) {
                          categoryViewModel.changeCategory(category);
                        }
                      },
                      elevation: 4,
                      shadowColor: const Color(0xFF096056),
                      selectedColor: const Color(0xFF096056),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Consumer<CategoryViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.products.isEmpty) {
                  return Center(
                      child: Text(
                          "No items found in ${viewModel.selectedCategory}"));
                }
                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                    MediaQuery.of(context).size.width > 600 ? 3 : 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: viewModel.products.length,
                  itemBuilder: (context, index) {
                    final product = viewModel.products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CategoryFoodDetails(
                              food: product,
                              category: viewModel.selectedCategory,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(product.imageUrl,
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover),
                            ),
                            const SizedBox(height: 8),
                            Text(product.name,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text("\₹${product.price}",
                                style: const TextStyle(color: Colors.green)),
                          ],
                        ),
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


