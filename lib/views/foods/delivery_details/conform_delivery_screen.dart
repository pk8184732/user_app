


import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../add_to_cart_screen.dart';
import 'buy_now_screen.dart';
import 'delivery_details_screen.dart';

class ConfirmDeliveryScreen extends StatefulWidget {
  final String name, phone, address;
  final double totalAmount;

  const ConfirmDeliveryScreen({
    required this.name,
    required this.phone,
    required this.address,
    required this.totalAmount,
    super.key,
  });

  @override
  State<ConfirmDeliveryScreen> createState() => _ConfirmDeliveryScreenState();
}

class _ConfirmDeliveryScreenState extends State<ConfirmDeliveryScreen> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handleSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handleError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handleSuccess(PaymentSuccessResponse response) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => BuyNowScreen(paymentId: response.paymentId!),
      ),
    );
  }

  void _handleError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment Failed: ${response.message}")),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Wallet: ${response.walletName}")),
    );
  }

  void _startPayment() {
    var options = {
      'key': 'rzp_test_fDHQt7hg7IlYBv',
      'amount': (widget.totalAmount * 100).toInt(),
      'name': widget.name,
      'description': 'Payment for order',
      'prefill': {
        'contact': widget.phone,
        'email': 'example@demo.com',
      },
      'notes': {
        'address': widget.address,
      }
    };
    _razorpay.open(options);
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
                        builder: (context) => const AddToCartScreen(),
                      ));
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Color(0xFF096056),
                )),
          ),
        ),
        title: const Text("Confirm Delivery",style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xFF096056),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit,color: Colors.white,),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => DeliveryDetailsScreen(totalAmount: widget.totalAmount),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Color(0xFF096056),),
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text("Name: ${widget.name}",style: const TextStyle(fontSize: 19,color: Colors.white),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text("Phone: ${widget.phone}",style: const TextStyle(fontSize: 19,color:  Colors.white),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text("Address: ${widget.address}",style: const TextStyle(fontSize: 19,color: Colors.white),),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _startPayment,
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF096056)),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Proceed to Pay", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18)),
                ),
              ),
            ),
            const SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }
}

