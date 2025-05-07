

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import '../../view_models/cart_view_model.dart';
import '../category/HomeCategoryScreen.dart';
import '../food_search/food_search_screen.dart';
import '../foods/add_to_cart_screen.dart';
import '../foods/food_details_screen.dart';
import '../favorite_food/favorite_food_screen.dart';

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
                                Stack(
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.favorite,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => FavoriteFoodScreen(
                                              likedProductIds: _likedFoods.toList(),
                                              toggleLike: _toggleLike,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    if (_likedFoods.isNotEmpty)
                                      Positioned(
                                        right: 4,
                                        top: 4,
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: const BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Text(
                                            _likedFoods.length.toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),

                                Consumer<CartViewModel>(
                                  builder: (context, cart, child) {
                                    return Stack(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.shopping_cart, size: 20, color: Colors.white),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => const AddToCartScreen(),
                                              ),
                                            );
                                          },
                                        ),
                                        if (cart.items.isNotEmpty)
                                          Positioned(
                                            right: 4,
                                            top: 4,
                                            child: Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: const BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Text(
                                                cart.items.length.toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                ),

                              ],
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 6),
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
                                    height: 30,width: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(11),
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
                                        hintText: "Search products...",hintStyle: TextStyle(fontSize: 14,color: Color(
                                          0xFF025E50)),
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
                                      BorderRadius.all(Radius.circular(8)),
                                      color: Colors.white,
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(5),
                                      child:
                                      Icon(Icons.search, color: Color(0xFF096056),size: 17,),
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
                            fontSize: 20, fontWeight: FontWeight.bold,color: Color(0xFF096056),)),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 120,
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
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: IconButton(
                                    icon: Icon(
                                      _likedFoods.contains(food.id)
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: _likedFoods.contains(food.id)
                                          ? Colors.red
                                          : const Color(0xFF096056),
                                    ),
                                    onPressed: () => _toggleLike(food.id),
                                  ),
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
                childAspectRatio: 0.82,
              ),
            ),
          ],
        ),
      ),
    );
  }
}




