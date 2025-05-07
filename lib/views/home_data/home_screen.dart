//
//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import '../foods/add_to_cart_screen.dart';
// import '../foods/food_details_screen.dart';
// import '../user_favorite/user_favorite_screen.dart';
// import 'home_navigation_bar.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   List<QueryDocumentSnapshot> _allFoods = [];
//   List<QueryDocumentSnapshot> _filteredFoods = [];
//   final Set<String> _likedFoods = {};
//
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchFoods();
//     _getCurrentLocation();
//   }
//   void _toggleLike(String foodsId) {
//     setState(() {
//       if (_likedFoods.contains(foodsId)) {
//         _likedFoods.remove(foodsId);
//       } else {
//         _likedFoods.add(foodsId);
//       }
//     });
//   }
//
//   Future<void> _getCurrentLocation() async {
//     try {
//       setState(() {
//       });
//     } catch (e) {
//       setState(() {
//       });
//     }
//   }
//   List<Map<String, String>> categories = [
//     {'name': 'Pizza', 'image': 'assets/categories/pizza.png'},
//     {'name': 'Burger', 'image': 'assets/categories/burger.png'},
//     {'name': 'Sushi', 'image': 'assets/categories/sushi.png'},
//     {'name': 'Drinks', 'image': 'assets/categories/drinks.png'},
//     {'name': 'Desserts', 'image': 'assets/categories/dessert.png'},
//   ];
//   Future<void> _fetchFoods() async {
//     final QuerySnapshot snapshot =
//     await _firestore.collection('foods').get();     // ye seller ka collection name hai jisse data fetch ho raha hai
//     setState(() {
//       _allFoods = snapshot.docs;
//       _filteredFoods = _allFoods;
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: RefreshIndicator(
//         onRefresh: _fetchFoods,
//         child: CustomScrollView(
//           slivers: [
//             SliverAppBar(
//               automaticallyImplyLeading: false,
//                expandedHeight: 140.0,
//                collapsedHeight: 80.0,
//               floating: false,
//               pinned: true,
//               backgroundColor: const Color(0xFF096056),
//               flexibleSpace: LayoutBuilder(
//                 builder: (context, constraints) {
//                   bool isCollapsed = constraints.maxHeight <= 80;
//                   return FlexibleSpaceBar(
//                     centerTitle: true,
//                     titlePadding: EdgeInsets.zero,
//                     title: Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         if (!isCollapsed)
//                           Padding(
//                             padding: const EdgeInsets.only(top: 0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 IconButton(
//                                   icon: Icon(Icons.favorite,
//                                       color: _likedFoods.isNotEmpty
//                                           ? Colors.white
//                                           : Colors.white),
//                                   onPressed: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => UserFavoriteScreen(
//                                           likedProductIds: _likedFoods.toList(),
//                                           toggleLike: _toggleLike,
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                                 IconButton(
//                                   icon: const Icon(Icons.shopping_cart, color: Colors.white),
//                                   onPressed: () {
//                                     Navigator.push(context, MaterialPageRoute(builder: (context) => const AddToCartScreen(),));
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                           child: GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (_) => FoodSearchScreen(foods: _allFoods),
//                                 ),
//                               );
//                             },
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: Container(
//                                     height: 40,
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(16),
//                                     ),
//                                     child: TextField( onTap: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (_) => FoodSearchScreen(foods: _allFoods),
//                                         ),
//                                       );
//                                     },
//                                       readOnly: true,
//                                       decoration: const InputDecoration(
//                                         hintText: "Search products...",
//                                         contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//                                         border: InputBorder.none,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 8),
//                                 Container(decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(14)),color: Colors.white,),
//                                     child: const Padding(
//                                       padding: EdgeInsets.all(8.0),
//                                       child: Icon(Icons.search, color: Colors.grey),
//                                     )),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: CarouselSlider(
//                   options: CarouselOptions(
//                     height: 200.0,
//                     autoPlay: true,
//                     enlargeCenterPage: true,
//                     viewportFraction: 0.8,
//                   ),
//                   items: [
//                     'assets/images/slide_image1.jpg',
//                     'assets/images/slide_image2.jpg',
//                     'assets/images/3.jpg',
//                     'assets/images/2.jpg',
//                   ].map((imagePath) {
//                     return ClipRRect(
//                       borderRadius: BorderRadius.circular(15),
//                       child: Image.asset(
//                         imagePath,
//                         fit: BoxFit.fill,
//                         width: double.maxFinite,
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//             SliverToBoxAdapter(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text(
//                       "Categories",
//                       style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//
//                   SizedBox(
//                     height: 150,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: _filteredFoods.length,
//                       itemBuilder: (context, index) {
//                         final food = _filteredFoods[index];
//                         final data = food.data() as Map<String, dynamic>;
//                         final List<dynamic>? imageUrls = data['images'];
//
//                         return GestureDetector(
//                           onTap: () {
//
//                           },
//                           child: Column(
//                             children: [
//                               Container(
//                                 margin: const EdgeInsets.symmetric(horizontal: 8),
//                                 decoration: const BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3)],
//                                 ),
//                                 child: CircleAvatar(
//                                   radius: 50,
//                                   backgroundImage: imageUrls != null && imageUrls.isNotEmpty
//                                       ? NetworkImage(imageUrls[0])
//                                       : const AssetImage('assets/placeholder.png') as ImageProvider,
//                                 ),
//                               ),
//                               const SizedBox(height: 5),
//                               Text(
//                                 data['name'] ?? 'Unknown',
//                                 style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//
//
//                   const Padding(
//                     padding: EdgeInsets.all(12.0),
//                     child: Text(
//                       "All Foods",
//                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//
//             SliverGrid(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 8,
//                 mainAxisSpacing: 8,
//                 childAspectRatio: 0.75,
//               ),
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
//                       elevation: 4,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       child: Stack(
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               ClipRRect(
//                                 borderRadius: const BorderRadius.only(
//                                   topLeft: Radius.circular(15),
//                                   topRight: Radius.circular(15),
//                                 ),
//                                 child: Image.network(
//                                   imageUrls?.isNotEmpty == true ? imageUrls![0] : 'https://via.placeholder.com/150',
//                                   width: double.infinity,
//                                   height: 150,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       data['name'] ?? 'Unnamed Product',
//                                       style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                     const SizedBox(height: 4),
//                                     Text(
//                                       '₹${data['price'] ?? 0}',
//                                       style: const TextStyle(fontSize: 14, color: Colors.green),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//
//                           Positioned(
//                             top: 8,
//                             right: 8,
//                             child: GestureDetector(
//                               onTap: () => _toggleLike(food.id),
//                               child: CircleAvatar(
//                                 backgroundColor: Colors.white,
//                                 child: Icon(
//                                   _likedFoods.contains(food.id)
//                                       ? Icons.favorite
//                                       : Icons.favorite_border,
//                                   color: _likedFoods.contains(food.id) ? Colors.red : Colors.grey,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//                 childCount: _filteredFoods.length,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//
//   }
// }
//
//
//
//
// class FoodSearchScreen extends StatefulWidget {
//   final List<QueryDocumentSnapshot> foods;
//
//   const FoodSearchScreen({super.key, required this.foods});
//
//   @override
//   _FoodSearchScreenState createState() => _FoodSearchScreenState();
// }
//
// class _FoodSearchScreenState extends State<FoodSearchScreen> {
//   String _searchQuery = '';
//   late List<QueryDocumentSnapshot> _filteredFoods;
//
//   @override
//   void initState() {
//     super.initState();
//     _filteredFoods = widget.foods;
//   }
//
//   void _filterFoods(String query) {
//     setState(() {
//       _searchQuery = query;
//       _filteredFoods = widget.foods
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
//         leading: ClipOval(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: IconButton(
//                 style: const ButtonStyle(
//                     backgroundColor: WidgetStatePropertyAll(Colors.white)),
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const HomeNavigationBar(),
//                       ));
//                 },
//                 icon: const Icon(
//                   Icons.arrow_back_ios_new,
//                   color: Color(0xFF096056),
//                 )),
//           ),
//         ),
//         backgroundColor: const Color(0xFF096056),
//         title: const Text('Food Search',style: TextStyle(color: Colors.white),),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               onChanged: _filterFoods,
//               decoration: InputDecoration(
//                 hintText: 'Search for foods...',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 prefixIcon: const Icon(Icons.search),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _filteredFoods.length,
//               itemBuilder: (context, index) {
//                 final product = _filteredFoods[index];
//                 final data = product.data() as Map<String, dynamic>;
//
//                 return ListTile(
//                   title: Text(
//                     data['name'] ?? 'Unnamed Food',
//                     style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => FoodsDetailScreen(foodsId: product.id),
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





import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../category/HomeCategoryScreen.dart';
import '../foods/add_to_cart_screen.dart';
import '../foods/food_details_screen.dart';
import '../user_favorite/user_favorite_screen.dart';
import 'home_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<QueryDocumentSnapshot> _allFoods = [];
  List<QueryDocumentSnapshot> _filteredFoods = [];
  final Set<String> _likedFoods = {};

  @override
  void initState() {
    super.initState();
    _fetchFoods();
    _getCurrentLocation();
  }

  void _toggleLike(String foodId) {
    setState(() {
      if (_likedFoods.contains(foodId)) {
        _likedFoods.remove(foodId);
      } else {
        _likedFoods.add(foodId);
      }
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      setState(() {});
    } catch (e) {
      setState(() {});
    }
  }

  Future<void> _fetchFoods() async {
    final QuerySnapshot snapshot = await _firestore.collection('foods').get();
    setState(() {
      _allFoods = snapshot.docs;
      _filteredFoods = _allFoods;
    });
  }



  @override
  Widget build(BuildContext context) {
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
      body: RefreshIndicator(
        onRefresh: _fetchFoods,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 140.0,
              collapsedHeight: 80.0,
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
                        if (!isCollapsed)
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.favorite,
                                      color: _likedFoods.isNotEmpty
                                          ? Colors.white
                                          : Colors.white),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            UserFavoriteScreen(
                                              likedProductIds:
                                              _likedFoods.toList(),
                                              toggleLike: _toggleLike,
                                            ),
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.shopping_cart,
                                      color: Colors.white),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                          const AddToCartScreen(),
                                        ));
                                  },
                                ),
                              ],
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      FoodSearchScreen(foods: _allFoods),
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
                                    child: TextField(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => FoodSearchScreen(
                                                foods: _allFoods),
                                          ),
                                        );
                                      },
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                        hintText: "Search products...",
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 12),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(14)),
                                      color: Colors.white,
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child:
                                      Icon(Icons.search, color: Colors.grey),
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
                    'assets/images/slide_image1.jpg',
                    'assets/images/slide_image2.jpg',
                    'assets/images/3.jpg',
                    'assets/images/2.jpg',
                  ].map((imagePath) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.fill,
                        width: double.maxFinite,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Choose a Category",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 110,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryList.length,
                        itemBuilder: (context, index) {
                          final food = categoryList[index].value;
                          final data =
                          food.data() as Map<String, dynamic>;
                          final name = data['name'];
                          final List<dynamic>? imageUrls = data['images'];

                          return GestureDetector(
                            onTap: () {
                              print("Tapped category: $name");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => HomeCategoryScreen(categoryName: name ?? ''),
                                ),
                              );
                            },

                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey, blurRadius: 3)
                                    ],
                                  ),
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundImage:
                                    imageUrls != null &&
                                        imageUrls.isNotEmpty
                                        ? NetworkImage(imageUrls[0])
                                        : const AssetImage(
                                        'assets/placeholder.png')
                                    as ImageProvider,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(name ?? 'Unknown',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text("All Foods",
                        style: TextStyle(color: Color(0xFF096056),fontWeight: FontWeight.bold,fontSize: 17)),

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
                                  height: 130,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: IconButton(
                                  icon: Icon(
                                    _likedFoods.contains(food.id)
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: _likedFoods.contains(food.id)
                                        ? Colors.red
                                        : Colors.white,
                                  ),
                                  onPressed: () => _toggleLike(food.id),
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




class FoodSearchScreen extends StatefulWidget {
  final List<QueryDocumentSnapshot> foods;

  const FoodSearchScreen({super.key, required this.foods});

  @override
  _FoodSearchScreenState createState() => _FoodSearchScreenState();
}

class _FoodSearchScreenState extends State<FoodSearchScreen> {
  String _searchQuery = '';
  late List<QueryDocumentSnapshot> _filteredFoods;

  @override
  void initState() {
    super.initState();
    _filteredFoods = widget.foods;
  }

  void _filterFoods(String query) {
    setState(() {
      _searchQuery = query;
      _filteredFoods = widget.foods
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
        title: const Text('Food Search',style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _filterFoods,
              decoration: InputDecoration(
                hintText: 'Search for foods...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredFoods.length,
              itemBuilder: (context, index) {
                final product = _filteredFoods[index];
                final data = product.data() as Map<String, dynamic>;

                return ListTile(
                  title: Text(
                    data['name'] ?? 'Unnamed Food',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FoodsDetailScreen(foodsId: product.id),
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



