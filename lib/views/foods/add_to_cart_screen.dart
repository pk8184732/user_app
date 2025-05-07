//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../view_models/cart_view_model.dart';
// import '../home_data/home_navigation_bar.dart';
// import 'delivery_details/delivery_details_screen.dart';
//
// class AddToCartScreen extends StatelessWidget {
//   const AddToCartScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final cart = Provider.of<CartViewModel>(context);
//     final items = cart.items.values.toList();
//
//     return Scaffold(
//       appBar: AppBar(
//         leading: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: CircleAvatar(backgroundColor:
//           Color(0xFFF8FBFB),
//             child: IconButton(
//               icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF096056),),
//               onPressed: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => const HomeNavigationBar()),
//                 );
//               },
//             ),
//           ),
//         ),
//         title: const Text("Foods Cart", style: TextStyle(color: Colors.white)),
//         backgroundColor: const Color(0xFF096056),
//       ),
//       body: items.isEmpty
//           ? const Center(child: Text("Foods cart is empty"))
//           : Column(
//         children: [
//           // Expanded(
//           //   child: ListView.builder(
//           //     itemCount: items.length,
//           //     itemBuilder: (ctx, i) => Padding(
//           //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//           //       child: Card(
//           //         elevation: 3,shadowColor: Color(0xFF096056),
//           //         surfaceTintColor: Color(0xFF096056),
//           //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           //         child: ListTile(
//           //           contentPadding: const EdgeInsets.all(8),
//           //           leading: CircleAvatar(
//           //             backgroundImage: items[i].image.isNotEmpty
//           //                 ? NetworkImage(items[i].image)
//           //                 : null,
//           //           ),
//           //           title: Text(
//           //             items[i].name,
//           //             style: const TextStyle(
//           //                 fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF096056)),
//           //           ),
//           //           subtitle: Text("₹${items[i].price} x ${items[i].quantity}"),
//           //           trailing: Row(
//           //             mainAxisSize: MainAxisSize.min,
//           //             children: [
//           //               IconButton(
//           //                 icon: const Icon(Icons.remove),
//           //                 onPressed: () {
//           //                   if (items[i].quantity > 1) {
//           //                     cart.decreaseQuantity(items[i].id);
//           //                   }
//           //                 },
//           //               ),
//           //               Text('${items[i].quantity}',
//           //                   style: const TextStyle(fontSize: 18, color: Color(0xFF096056))),
//           //               IconButton(
//           //                 icon: const Icon(Icons.add),
//           //                 onPressed: () {
//           //                   cart.increaseQuantity(items[i].id);
//           //                 },
//           //               ),
//           //               IconButton(
//           //                 icon: const Icon(Icons.delete, color: Colors.redAccent),
//           //                 onPressed: () {
//           //                   cart.removeItem(items[i].id);
//           //                 },
//           //               ),
//           //             ],
//           //           ),
//           //         ),
//           //       ),
//           //     ),
//           //   ),
//           // ),
//           Expanded(
//             child: GridView.builder(
//               padding: const EdgeInsets.all(12),
//               itemCount: items.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 12,
//                 mainAxisSpacing: 12,
//                 childAspectRatio: 0.75,
//               ),
//               itemBuilder: (context, i) {
//                 final item = items[i];
//
//                 return Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 6,
//                         offset: const Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       // Image
//                       ClipRRect(
//                         borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
//                         child: item.image.isNotEmpty
//                             ? Image.network(
//                           item.image,
//                           height: 120,
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                         )
//                             : Container(
//                           height: 120,
//                           color: Colors.grey[200],
//                           child: const Icon(Icons.image_not_supported, size: 40),
//                         ),
//                       ),
//
//                       // Name
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//                         child: Text(
//                           item.name,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 16,
//                             color: Color(0xFF096056),
//                           ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//
//                       // Price & Quantity
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8),
//                         child: Text(
//                           "₹${item.price} x ${item.quantity}",
//                           style: const TextStyle(fontSize: 14, color: Colors.black54),
//                         ),
//                       ),
//
//                       const Spacer(),
//
//                       // Quantity & Delete Buttons
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             // Quantity control
//                             Padding(
//                               padding: const EdgeInsets.only(bottom: 10),
//                               child: Row(
//                                 children: [
//                                   GestureDetector(
//                                     onTap: () {
//                                       if (item.quantity > 1) {
//                                         cart.decreaseQuantity(item.id);
//                                       }
//                                     },
//                                     child: const CircleAvatar(
//                                       radius: 14,
//                                       backgroundColor: Color(0xFF096056),
//                                       child: Icon(Icons.remove, color: Colors.white, size: 18),
//                                     ),
//                                   ),
//                                   const SizedBox(width: 8),
//                                   Text(
//                                     '${item.quantity}',
//                                     style: const TextStyle(fontSize: 16),
//                                   ),
//                                   const SizedBox(width: 8),
//                                   GestureDetector(
//                                     onTap: () {
//                                       cart.increaseQuantity(item.id);
//                                     },
//                                     child: const CircleAvatar(
//                                       radius: 14,
//                                       backgroundColor: Color(0xFF096056),
//                                       child: Icon(Icons.add, color: Colors.white, size: 18),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//
//                             // Delete
//                             Padding(
//                               padding: const EdgeInsets.only(bottom: 10),
//                               child: GestureDetector(
//                                 onTap: () {
//                                   cart.removeItem(item.id);
//                                 },
//                                 child: const Icon(Icons.delete, color: Colors.redAccent),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//
//
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             color: const Color(0xFFB2DAD6),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("Total: ₹${cart.totalAmount.toStringAsFixed(2)}",
//                     style: const TextStyle(
//                         fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     foregroundColor: Colors.black,
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                   ),
//                   onPressed: () async {
//                     if (cart.items.isEmpty) return;
//
//                     await Future.delayed(const Duration(seconds: 1)); // simulate delay
//                     showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: const Text("Order Placed"),
//                         content: const Text("Your order has been placed successfully!"),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               cart.clearCart();
//                               Navigator.of(context).pop();
//                             },
//                             child: const Text("OK"),
//                           )
//                         ],
//                       ),
//                     );
//                   },
//                   child: const Text("Checkout"),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF096056),
//                     padding: const EdgeInsets.symmetric(vertical: 12)),
//                 onPressed: () {
//                   if (cart.items.isEmpty) return;
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => DeliveryDetailsScreen(
//                         totalAmount: cart.totalAmount,
//                       ),
//                     ),
//                   );
//                 },
//                 child: const Text("Buy Now",
//                     style: TextStyle(color: Colors.white, fontSize: 18)),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/cart_view_model.dart';
import 'delivery_details/delivery_details_screen.dart';

class AddToCartScreen extends StatelessWidget {
  const AddToCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartViewModel>(context);
    final items = cart.items.values.toList();

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(screenWidth * 0.02),
          child: CircleAvatar(
            backgroundColor: const Color(0xFFF8FBFB),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: const Color(0xFF096056), size: screenWidth * 0.045),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Text(
          "Foods Cart",
          style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.05),
        ),
        backgroundColor: const Color(0xFF096056),
      ),
      body: items.isEmpty
          ? Center(
        child: Text("Foods cart is empty", style: TextStyle(fontSize: screenWidth * 0.045)),
      )
          : Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(screenWidth * 0.03),
              itemCount: items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: screenWidth > 600 ? 3 : 2,
                crossAxisSpacing: screenWidth * 0.03,
                mainAxisSpacing: screenWidth * 0.03,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, i) {
                final item = items[i];

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        child: item.image.isNotEmpty
                            ? Image.network(
                          item.image,
                          height: screenHeight * 0.15,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                            : Container(
                          height: screenHeight * 0.15,
                          color: Colors.grey[200],
                          child: Icon(Icons.image_not_supported, size: screenWidth * 0.08),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025, vertical: screenHeight * 0.008),
                        child: Text(
                          item.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: screenWidth * 0.042,
                            color: const Color(0xFF096056),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
                        child: Text(
                          "₹${item.price} x ${item.quantity}",
                          style: TextStyle(fontSize: screenWidth * 0.035, color: Colors.black54),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025, vertical: screenHeight * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (item.quantity > 1) cart.decreaseQuantity(item.id);
                                  },
                                  child: CircleAvatar(
                                    radius: screenWidth * 0.035,
                                    backgroundColor: const Color(0xFF096056),
                                    child: Icon(Icons.remove, color: Colors.white, size: screenWidth * 0.04),
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                Text('${item.quantity}', style: TextStyle(fontSize: screenWidth * 0.04)),
                                SizedBox(width: screenWidth * 0.02),
                                GestureDetector(
                                  onTap: () => cart.increaseQuantity(item.id),
                                  child: CircleAvatar(
                                    radius: screenWidth * 0.035,
                                    backgroundColor: const Color(0xFF096056),
                                    child: Icon(Icons.add, color: Colors.white, size: screenWidth * 0.04),
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text("Delete Item"),
                                    content: const Text("Are you sure you want to delete this item?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          cart.removeItem(item.id);
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Delete", style: TextStyle(color: Colors.redAccent)),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Icon(Icons.delete, color: Colors.redAccent, size: screenWidth * 0.06),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.015),
            color: const Color(0xFFB2DAD6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total: ₹${cart.totalAmount.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  ),
                  onPressed: () {
                    if (cart.items.isEmpty) return;
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Confirm Checkout"),
                        content: const Text("Are you sure you want to place the order and clear the cart?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              cart.clearCart();
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Order Placed"),
                                  content: const Text("Your order has been placed successfully!"),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: const Text("OK"),
                                    )
                                  ],
                                ),
                              );
                            },
                            child: const Text("Yes", style: TextStyle(color: Colors.green)),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text("Checkout", style: TextStyle(fontSize: screenWidth * 0.04)),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.03),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF096056),
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                ),
                onPressed: () {
                  if (cart.items.isEmpty) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DeliveryDetailsScreen(totalAmount: cart.totalAmount),
                    ),
                  );
                },
                child: Text("Buy Now", style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.045)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../view_models/cart_view_model.dart';
// import '../home_data/home_navigation_bar.dart';
// import 'delivery_details/delivery_details_screen.dart';
//
// class AddToCartScreen extends StatelessWidget {
//   const AddToCartScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final cart = Provider.of<CartViewModel>(context);
//     final items = cart.items.values.toList();
//
//     return Scaffold(
//       appBar: AppBar(
//         leading: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: CircleAvatar(
//             backgroundColor: const Color(0xFFF8FBFB),
//             child: IconButton(
//               icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF096056)),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ),
//         ),
//         title: const Text("Foods Cart", style: TextStyle(color: Colors.white)),
//         backgroundColor: const Color(0xFF096056),
//       ),
//       body: items.isEmpty
//           ? const Center(child: Text("Foods cart is empty"))
//           : Column(
//         children: [
//           Expanded(
//             child: GridView.builder(
//               padding: const EdgeInsets.all(12),
//               itemCount: items.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 12,
//                 mainAxisSpacing: 12,
//                 childAspectRatio: 0.75,
//               ),
//               itemBuilder: (context, i) {
//                 final item = items[i];
//
//                 return Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 6,
//                         offset: Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       ClipRRect(
//                         borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
//                         child: item.image.isNotEmpty
//                             ? Image.network(
//                           item.image,
//                           height: 120,
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                         )
//                             : Container(
//                           height: 120,
//                           color: Colors.grey[200],
//                           child: const Icon(Icons.image_not_supported, size: 40),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//                         child: Text(
//                           item.name,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 16,
//                             color: Color(0xFF096056),
//                           ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8),
//                         child: Text(
//                           "₹${item.price} x ${item.quantity}",
//                           style: const TextStyle(fontSize: 14, color: Colors.black54),
//                         ),
//                       ),
//                       const Spacer(),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(bottom: 10),
//                               child: Row(
//                                 children: [
//                                   GestureDetector(
//                                     onTap: () {
//                                       if (item.quantity > 1) {
//                                         cart.decreaseQuantity(item.id);
//                                       }
//                                     },
//                                     child: const CircleAvatar(
//                                       radius: 14,
//                                       backgroundColor: Color(0xFF096056),
//                                       child: Icon(Icons.remove, color: Colors.white, size: 18),
//                                     ),
//                                   ),
//                                   const SizedBox(width: 8),
//                                   Text('${item.quantity}',
//                                       style: const TextStyle(fontSize: 16)),
//                                   const SizedBox(width: 8),
//                                   GestureDetector(
//                                     onTap: () {
//                                       cart.increaseQuantity(item.id);
//                                     },
//                                     child: const CircleAvatar(
//                                       radius: 14,
//                                       backgroundColor: Color(0xFF096056),
//                                       child: Icon(Icons.add, color: Colors.white, size: 18),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(bottom: 10),
//                               child: GestureDetector(
//                                 onTap: () {
//                                   showDialog(
//                                     context: context,
//                                     builder: (context) => AlertDialog(
//                                       title: const Text("Delete Item"),
//                                       content: const Text("Are you sure you want to delete this item?"),
//                                       actions: [
//                                         TextButton(
//                                           onPressed: () => Navigator.pop(context),
//                                           child: const Text("Cancel"),
//                                         ),
//                                         TextButton(
//                                           onPressed: () {
//                                             cart.removeItem(item.id);
//                                             Navigator.pop(context);
//                                           },
//                                           child: const Text("Delete",
//                                               style: TextStyle(color: Colors.redAccent)),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                                 child: const Icon(Icons.delete, color: Colors.redAccent),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             color: const Color(0xFFB2DAD6),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("Total: ₹${cart.totalAmount.toStringAsFixed(2)}",
//                     style: const TextStyle(
//                         fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     foregroundColor: Colors.black,
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                   ),
//                   onPressed: () {
//                     if (cart.items.isEmpty) return;
//                     showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: const Text("Confirm Checkout"),
//                         content: const Text("Are you sure you want to place the order and clear the cart?"),
//                         actions: [
//                           TextButton(
//                             onPressed: () => Navigator.pop(context),
//                             child: const Text("Cancel"),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               cart.clearCart();
//                               Navigator.pop(context); // close confirmation
//                               showDialog(
//                                 context: context,
//                                 builder: (context) => AlertDialog(
//                                   title: const Text("Order Placed"),
//                                   content: const Text("Your order has been placed successfully!"),
//                                   actions: [
//                                     TextButton(
//                                       onPressed: () {
//                                         Navigator.of(context).pop(); // close success
//                                       },
//                                       child: const Text("OK"),
//                                     )
//                                   ],
//                                 ),
//                               );
//                             },
//                             child: const Text("Yes", style: TextStyle(color: Colors.green)),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                   child: const Text("Checkout"),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF096056),
//                   padding: const EdgeInsets.symmetric(vertical: 12),
//                 ),
//                 onPressed: () {
//                   if (cart.items.isEmpty) return;
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => DeliveryDetailsScreen(
//                         totalAmount: cart.totalAmount,
//                       ),
//                     ),
//                   );
//                 },
//                 child: const Text("Buy Now",
//                     style: TextStyle(color: Colors.white, fontSize: 17)),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
