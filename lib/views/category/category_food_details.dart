

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../view_models/category/category_view_model.dart';

class CategoryFoodDetails extends StatelessWidget {
  final CategoryModel food;
  final String category;

  const CategoryFoodDetails({super.key,
    required this.food,
    required this.category,
  });

  void deleteProduct(BuildContext context) async {
    await FirebaseFirestore.instance
        .collection('categories')
        .doc(category)
        .collection('foods')
        .doc(food.id)
        .delete();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Product deleted successfully")));

    Navigator.pop(context); // Go back after deletion
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
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Color(0xFF096056),
                  )),
            ),
          ),
          backgroundColor: const Color(0xFF096056),
          title: Text(
            food.name,
            style: const TextStyle(color: Colors.white),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            elevation: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      child: Image.network(
                        food.imageUrl,
                        height: 200,
                        width: 350,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5),
                  child: Text(food.name,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color:Color(0xFF096056), )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text("\₹ ${food.price}",
                      style: const TextStyle(fontSize: 16, color: Colors.green)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(food.description, style: const TextStyle(fontSize: 15)),
                ),
                const SizedBox(height: 20),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

