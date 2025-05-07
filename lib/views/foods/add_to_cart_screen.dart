
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/cart_view_model.dart';
import '../home_data/home_navigation_bar.dart';
import 'delivery_details/delivery_details_screen.dart';

class AddToCartScreen extends StatelessWidget {
  const AddToCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartViewModel>(context);
    final items = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeNavigationBar()),
            );
          },
        ),
        title: const Text("Foods Cart", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF096056),
      ),
      body: items.isEmpty
          ? const Center(child: Text("Foods cart is empty"))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (ctx, i) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8),
                    leading: CircleAvatar(
                      backgroundImage: items[i].image.isNotEmpty
                          ? NetworkImage(items[i].image)
                          : null,
                    ),
                    title: Text(
                      items[i].name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF096056)),
                    ),
                    subtitle: Text("₹${items[i].price} x ${items[i].quantity}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            if (items[i].quantity > 1) {
                              cart.decreaseQuantity(items[i].id);
                            }
                          },
                        ),
                        Text('${items[i].quantity}',
                            style: const TextStyle(fontSize: 18, color: Color(0xFF096056))),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            cart.increaseQuantity(items[i].id);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () {
                            cart.removeItem(items[i].id);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: const Color(0xFFB2DAD6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total: ₹${cart.totalAmount.toStringAsFixed(2)}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  onPressed: () async {
                    if (cart.items.isEmpty) return;

                    await Future.delayed(const Duration(seconds: 1)); // simulate delay
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Order Placed"),
                        content: const Text("Your order has been placed successfully!"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              cart.clearCart();
                              Navigator.of(context).pop();
                            },
                            child: const Text("OK"),
                          )
                        ],
                      ),
                    );
                  },
                  child: const Text("Checkout"),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF096056),
                    padding: const EdgeInsets.symmetric(vertical: 12)),
                onPressed: () {
                  if (cart.items.isEmpty) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DeliveryDetailsScreen(
                        totalAmount: cart.totalAmount,
                      ),
                    ),
                  );
                },
                child: const Text("Buy Now",
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
