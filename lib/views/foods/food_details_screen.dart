
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import '../../view_models/cart_view_model.dart';
import '../../view_models/food_view_model.dart';
import '../home_data/home_navigation_bar.dart';

class FoodsDetailScreen extends StatelessWidget {
  final String foodsId;

  const FoodsDetailScreen({super.key, required this.foodsId});

  @override
  Widget build(BuildContext context) {
    final productViewModel = Provider.of<FoodViewModel>(context);

    // Fetch foods details
    productViewModel.fetchFood(foodsId);
    final food = productViewModel.foodDetails;

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
        title: const Text('Food Details',style: TextStyle(color: Colors.white),),backgroundColor: const Color(0xFF096056),),
      body: food == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (food['images'] != null && food['images'].length > 1)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CarouselSlider(
                          options: CarouselOptions(height: 250, autoPlay: true,),
                          items: food['images'].map<Widget>((imgUrl) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  imgUrl,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      )
                    else if (food['images'] != null && food['images'].isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          food['images'][0],
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

                    const SizedBox(height: 16),

                    Text(food['name'], style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    Text('Price: ₹${food['price']}', style: const TextStyle(fontSize: 18, color: Colors.green)),
                    Text('Discount: ${food['discount']}%', style: const TextStyle(fontSize: 16, color: Colors.red)),
                    const SizedBox(height: 8),
                    Text(food['description'], style: TextStyle(fontSize: 16, color: Colors.grey[700])),

                    const SizedBox(height: 20),


                  ],
                ),
              ),
            ),

            const SizedBox(height: 80),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Provider.of<CartViewModel>(context, listen: false).addItem(
                      foodsId,
                      food['name'],
                      double.parse(food['price'].toString()),
                      food['images'] != null && food['images'].isNotEmpty
                          ? food['images'][0]
                          : '',
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Center(
                          child: Text('${food['name']} Added to cart',style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF096056),
                    padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 10),
                  ),
                  child: const Text("Add to Cart",style: TextStyle(color: Colors.white,fontSize: 20),),
                ),
              ],
            ),
          ],
        ),

      ),
    );
  }
}





