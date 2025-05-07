import 'package:flutter/material.dart';
import '../add_to_cart_screen.dart';
import 'conform_delivery_screen.dart';

class DeliveryDetailsScreen extends StatefulWidget {
  final double totalAmount;

  const DeliveryDetailsScreen({required this.totalAmount, super.key});

  @override
  State<DeliveryDetailsScreen> createState() => _DeliveryDetailsScreenState();
}

class _DeliveryDetailsScreenState extends State<DeliveryDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String phone = '';
  String address = '';

  void _saveAndContinue() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ConfirmDeliveryScreen(
            name: name,
            phone: phone,
            address: address,
            totalAmount: widget.totalAmount,
          ),
        ),
      );
    }
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
          title: const Text(
            "Delivery Details",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xFF096056)),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF096056),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(14))),
                      labelText: "Full Name",
                      labelStyle: TextStyle(
                        color: Color(0xFF096056),
                      )),
                  onSaved: (val) => name = val!,
                  validator: (val) => val!.isEmpty ? "Required" : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(14),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF096056),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(14))),
                      labelText: "Phone Number",
                      labelStyle: TextStyle(
                        color: Color(0xFF096056),
                      )),
                  keyboardType: TextInputType.phone,
                  onSaved: (val) => phone = val!,
                  validator: (val) =>
                      val!.length != 10 ? "Enter valid phone" : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF096056),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(14))),
                      labelText: "Delivery Address",
                      labelStyle: TextStyle(
                        color: Color(0xFF096056),
                      )),
                  maxLines: 2,
                  onSaved: (val) => address = val!,
                  validator: (val) => val!.isEmpty ? "Required" : null,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF096056)),
                onPressed: _saveAndContinue,
                child: const Text("Continue",
                    style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
