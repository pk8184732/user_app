

import 'package:flutter/material.dart';
import '../../home_data/home_navigation_bar.dart';

class BuyNowScreen extends StatelessWidget {
  final String paymentId;

  const BuyNowScreen({required this.paymentId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order Success"), backgroundColor: const Color(0xFF096056)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 80),
              const SizedBox(height: 20),
              const Text("Payment Successful!", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text("Payment ID: $paymentId", style: TextStyle(fontSize: 14, color: Colors.grey[700])),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeNavigationBar()),
                        (route) => false,
                  );
                },
                child: const Text("Back to Home"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
