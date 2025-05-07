

import 'package:flutter/material.dart';
import '../../home_data/home_navigation_bar.dart';

class BuyNowScreen extends StatelessWidget {
  final String paymentId;

  const BuyNowScreen({required this.paymentId, super.key});

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
          title: const Text("Order Success",style: TextStyle(color: Colors.white),), backgroundColor: const Color(0xFF096056)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 80),
              const SizedBox(height: 20),
              const Text("Payment Successful!", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Color(0xFF096056))),
              const SizedBox(height: 12),
              Text("Payment ID: $paymentId", style: const TextStyle(fontSize: 14, color: Color(
                  0xFF629790))),
              const SizedBox(height: 30),
              ElevatedButton(
                style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Color(0xFF096056))),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeNavigationBar()),
                        (route) => false,
                  );
                },
                child: const Text("Back to Home",style: TextStyle(color: Colors.white),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
