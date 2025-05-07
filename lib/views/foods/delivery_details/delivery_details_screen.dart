
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../add_to_cart_screen.dart';
import 'buy_now_screen.dart';

class DeliveryDetailsScreen extends StatefulWidget {
  final double totalAmount;

  const DeliveryDetailsScreen({required this.totalAmount, super.key});

  @override
  State<DeliveryDetailsScreen> createState() => _DeliveryDetailsScreenState();
}

class _DeliveryDetailsScreenState extends State<DeliveryDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  late Razorpay _razorpay;

  String name = '';
  String address = '';
  String phone = '';

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => BuyNowScreen(paymentId: response.paymentId!),
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment failed: ${response.message}")),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("External wallet selected: ${response.walletName}")),
    );
  }

  void _startPayment() {
    var options = {
      'key': 'rzp_test_yourkeyhere', // Replace with real Razorpay key
      'amount': (widget.totalAmount * 100).toInt(),
      'name': name,
      'description': 'Order Payment',
      'prefill': {'contact': phone, 'email': 'user@example.com'},
      'notes': {'address': address}
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
          title: const Text("Delivery Details",style: TextStyle(color: Colors.white),), backgroundColor: const Color(0xFF096056)),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(

                  decoration: InputDecoration(labelText: "Full Name",border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                  onSaved: (val) => name = val!,
                  validator: (val) => val!.isEmpty ? "Required" : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: "Phone Number",border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                  keyboardType: TextInputType.phone,
                  onSaved: (val) => phone = val!,
                  validator: (val) => val!.length != 10 ? "Enter valid phone" : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: "Delivery Address",border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                  maxLines: 2,
                  onSaved: (val) => address = val!,
                  validator: (val) => val!.isEmpty ? "Required" : null,
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Color(0xFF096056)
                  )),
                  onPressed: () {
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Proceed to Payment",style: TextStyle(color: Colors.white,fontSize: 18),),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
