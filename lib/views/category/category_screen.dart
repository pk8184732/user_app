import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../product/product_details_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        backgroundColor: Color(0xFF096056),
      ),
      body: ChangeNotifierProvider(
        create: (_) => CategoryViewModel(),
        child: Consumer<CategoryViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.categories.isEmpty && viewModel.products.isEmpty) {
              return Center(child: CircularProgressIndicator());
            }

            return Row(
              children: [
                // Left: Category Images and Filtered Products
                Container(
                  width: 130,
                  color: Colors.grey[200],
                  child: Column(
                    children: [
                      // Categories Icon and Name
                      Expanded(
                        child: ListView.builder(
                          itemCount: viewModel.categories.length,
                          itemBuilder: (context, index) {
                            final category = viewModel.categories[index];
                            final isSelected =
                                category.name == viewModel._selectedCategory;

                            return GestureDetector(
                              onTap: () =>
                                  viewModel.filterProductsByCategory(category.name),
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                color: isSelected
                                    ? Colors.green[100]
                                    : Colors.transparent,
                                child: Column(
                                  children: [
                                    category.imageUrl.isNotEmpty
                                        ? Image.network(
                                      category.imageUrl,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    )
                                        : Icon(Icons.category, size: 40),
                                    SizedBox(height: 4),
                                    Text(
                                      category.name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      // Product Images for the Selected Category
                      Expanded(
                        flex: 6,
                        child: SingleChildScrollView(
                          child: Column(
                            children: viewModel.filteredProducts
                                .map((product) => GestureDetector(
                              onTap: () {
                                viewModel.filterProductsByType(product.name);
                              },
                              child: Column(
                                children: [
                                  product.imageUrl.isNotEmpty
                                      ? Image.network(
                                    product.imageUrl,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  )
                                      : Icon(Icons.image, size: 50),
                                  SizedBox(height: 4),
                                  Text(
                                    product.name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ))
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Right: Filtered Products GridView
                Expanded(

                  child: viewModel.filteredProductsByType.isEmpty
                      ? Center(
                    child: Text(
                      'No products found!',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                      : GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: viewModel.filteredProductsByType.length,
                    itemBuilder: (context, index) {
                      final product = viewModel.filteredProductsByType[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductDetailScreen(
                                  productId: product.id),
                            ),
                          );
                        },
                        child: Container(height: 333,
                          child: Card(

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                product.imageUrl.isNotEmpty
                                    ? ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(15)),
                                  child: Image.network(
                                    product.imageUrl,
                                    width: double.infinity,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                )
                                    : Container(
                                  width: double.infinity,
                                  height: 120,
                                  color: Colors.grey[300],
                                  child: Icon(Icons.image, size: 50),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    product.name,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CategoryViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<CategoryModel> _categories = [];
  List<ProductModel> _products = [];
  List<ProductModel> _filteredProducts = [];
  List<ProductModel> _filteredProductsByType = [];

  String _selectedCategory = 'All';

  List<CategoryModel> get categories => _categories;
  List<ProductModel> get products => _products;
  List<ProductModel> get filteredProducts => _filteredProducts;
  List<ProductModel> get filteredProductsByType => _filteredProductsByType;

  CategoryViewModel() {
    _fetchCategoriesAndProducts();
  }

  Future<void> _fetchCategoriesAndProducts() async {
    try {
      // Fetch categories
      final categoriesSnapshot = await _firestore.collection('categories').get();
      _categories = categoriesSnapshot.docs
          .map((doc) => CategoryModel.fromMap(doc.id, doc.data()))
          .toList();

      // Add "All" category manually
      _categories.insert(0, CategoryModel(id: 'all', name: 'All', imageUrl: ''));

      // Fetch products
      final productsSnapshot = await _firestore.collection('products').get();
      _products = productsSnapshot.docs
          .map((doc) => ProductModel.fromMap(doc.id, doc.data()))
          .toList();

      _filteredProducts = _products;
      _filteredProductsByType = _products;

      notifyListeners();
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  void filterProductsByCategory(String category) {
    _selectedCategory = category;

    if (category == 'All') {
      _filteredProducts = _products;
      _filteredProductsByType = _products;
    } else {
      _filteredProducts = _products
          .where((product) => product.category.toLowerCase() == category.toLowerCase())
          .toList();
      _filteredProductsByType = _filteredProducts;
    }

    notifyListeners();
  }

  void filterProductsByType(String type) {
    _filteredProductsByType = _filteredProducts
        .where((product) => product.name.toLowerCase().contains(type.toLowerCase()))
        .toList();
    notifyListeners();
  }
}

class CategoryModel {
  final String id;
  final String name;
  final String imageUrl;

  CategoryModel({required this.id, required this.name, required this.imageUrl});

  factory CategoryModel.fromMap(String id, Map<String, dynamic> data) {
    return CategoryModel(
      id: id,
      name: data['name'] ?? 'Unnamed Category',
      imageUrl: data['imageUrl'] ?? '',
    );
  }
}

class ProductModel {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final String category;

  ProductModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.category,
  });

  factory ProductModel.fromMap(String id, Map<String, dynamic> data) {
    return ProductModel(
      id: id,
      name: data['name'] ?? 'Unnamed Product',
      imageUrl: data['imageUrl'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      category: data['category'] ?? '',
    );
  }
}
