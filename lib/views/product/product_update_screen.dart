
//
//
//
//
// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:seller_app/views/home_screen.dart';
//
// import '../../utils/imports.dart';
//
// class ProductUpdateScreen extends StatefulWidget {
//   final String productId;
//
//   ProductUpdateScreen({required this.productId});
//
//   @override
//   _ProductUpdateScreenState createState() => _ProductUpdateScreenState();
// }
//
// class _ProductUpdateScreenState extends State<ProductUpdateScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String _name = '';
//   double _price = 0.0;
//   String _description = '';
//   String _discount = '';
//   String _imageUrl = ''; // This will hold the image URL from Firestore
//   File? _imageFile; // Local image file (for the new image)
//
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final ImagePicker _picker = ImagePicker();
//
//   @override
//   void initState() {
//     super.initState();
//     _loadProductData();
//   }
//
//   // Load product data from Firestore
//   Future<void> _loadProductData() async {
//     try {
//       DocumentSnapshot doc = await _firestore.collection('products').doc(widget.productId).get();
//       if (doc.exists) {
//         final data = doc.data() as Map<String, dynamic>;
//         setState(() {
//           _name = data['name'] ?? '';
//           _price = (data['price'] ?? 0).toDouble();
//           _description = data['description'] ?? '';
//           _discount = data['discount'] ?? '';
//           _imageUrl = data['imageUrl'] ?? ''; // Load the existing image URL
//         });
//       } else {
//         print('No product found with this ID');
//       }
//     } catch (e) {
//       print('Error loading product data: $e');
//     }
//   }
//
//   // Function to pick an image using image_picker
//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//         _imageUrl = ''; // If a new image is selected, clear the old URL
//       });
//     }
//   }
//
//   // Upload the new image to Firebase Storage and return the image URL
//   Future<String> _uploadImage() async {
//     if (_imageFile == null) return _imageUrl; // Return the old URL if no new image is selected
//
//     try {
//       // Get a reference to Firebase Storage
//       String fileName = DateTime.now().millisecondsSinceEpoch.toString();
//       Reference storageRef = FirebaseStorage.instance.ref().child('product_images').child(fileName);
//
//       // Upload the file to Firebase Storage
//       UploadTask uploadTask = storageRef.putFile(_imageFile!);
//       TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
//
//       // Get the download URL for the image
//       String downloadUrl = await taskSnapshot.ref.getDownloadURL();
//       return downloadUrl;
//     } catch (e) {
//       print('Error uploading image: $e');
//       return _imageUrl; // If upload fails, return the old image URL
//     }
//   }
//
//   // Update product in Firestore
//   Future<void> _updateProduct() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     _formKey.currentState!.save();
//
//     try {
//       // Upload the image (if a new image is selected)
//       String updatedImageUrl = await _uploadImage();
//
//       // Update the product document in Firestore
//       await _firestore.collection('products').doc(widget.productId).update({
//         'name': _name,
//         'price': _price,
//         'description': _description,
//         'discount': _discount,
//         'imageUrl': updatedImageUrl, // Save the new image URL
//       });
//
//       // Navigate back to the previous screen
//       Navigator.pop(context);
//     } catch (e) {
//       print('Error updating product: $e');
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update product')));
//     }
//     Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Update Product')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               // Show the image (either from Firestore or the locally selected file)
//               _imageFile == null
//                   ? (_imageUrl.isNotEmpty
//                   ? Image.network(
//                 _imageUrl,
//                 height: 150,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               )
//                   : Container())
//                   : Image.file(
//                 _imageFile!,
//                 height: 150,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//               // Edit image button
//               ElevatedButton(
//                 onPressed: _pickImage,
//                 child: Text('Edit Image'),
//               ),
//               // Product name field
//               TextFormField(
//                 initialValue: _name,
//                 decoration: InputDecoration(labelText: 'Product Name'),
//                 validator: (value) => value!.isEmpty ? 'Enter a product name' : null,
//                 onSaved: (value) => _name = value!,
//               ),
//               // Price field
//               TextFormField(
//                 initialValue: _price.toString(),
//                 decoration: InputDecoration(labelText: 'Price'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) => value!.isEmpty ? 'Enter a price' : null,
//                 onSaved: (value) => _price = double.parse(value!),
//               ),
//               // Description field
//               TextFormField(
//                 initialValue: _description,
//                 decoration: InputDecoration(labelText: 'Description'),
//                 maxLines: 3,
//                 validator: (value) => value!.isEmpty ? 'Enter a description' : null,
//                 onSaved: (value) => _description = value!,
//               ),
//               // Discount field
//               TextFormField(
//                 initialValue: _discount,
//                 decoration: InputDecoration(labelText: 'Discount'),
//                 keyboardType: TextInputType.number,
//                 onSaved: (value) => _discount = value!,
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _updateProduct,
//                 child: Text('Update Product'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductUpdateScreen extends StatefulWidget {
  final String productId;

  ProductUpdateScreen({required this.productId});

  @override
  _ProductUpdateScreenState createState() => _ProductUpdateScreenState();
}

class _ProductUpdateScreenState extends State<ProductUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  double? _price;
  String? _description;
  String? _discount;
  String _imageUrl = '';
  File? _imageFile;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadProductData();
  }

  // Load product data from Firestore
  Future<void> _loadProductData() async {
    try {
      DocumentSnapshot doc = await _firestore.collection('products').doc(widget.productId).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        setState(() {
          _name = data['name'] ?? '';
          _price = (data['price'] ?? 0).toDouble();
          _description = data['description'] ?? '';
          _discount = data['discount'] ?? '';
          _imageUrl = data['imageUrl'] ?? '';
        });
      } else {
        print('No product found with this ID');
      }
    } catch (e) {
      print('Error loading product data: $e');
    }
  }

  // Function to pick an image using image_picker
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // Upload the new image to Firebase Storage and return the image URL
  Future<String?> _uploadImage() async {
    if (_imageFile == null) return _imageUrl;

    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef = FirebaseStorage.instance.ref().child('product_images/$fileName');
      UploadTask uploadTask = storageRef.putFile(_imageFile!);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  // Update product in Firestore
  Future<void> _updateProduct() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    try {
      String? updatedImageUrl = await _uploadImage();
      Map<String, dynamic> updatedData = {};

      if (_name != null) updatedData['name'] = _name;
      if (_price != null) updatedData['price'] = _price;
      if (_description != null) updatedData['description'] = _description;
      if (_discount != null) updatedData['discount'] = _discount;
      if (updatedImageUrl != null) updatedData['imageUrl'] = updatedImageUrl;

      if (updatedData.isNotEmpty) {
        await _firestore.collection('products').doc(widget.productId).update(updatedData);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Product updated successfully')));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No changes to update')));
      }
    } catch (e) {
      print('Error updating product: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update product')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Product')),
      body: _name == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _imageFile == null
                  ? (_imageUrl.isNotEmpty
                  ? Image.network(
                _imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              )
                  : Container(height: 200, color: Colors.grey[300]))
                  : Image.file(
                _imageFile!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Change Image'),
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Product Name'),
                validator: (value) => value!.isEmpty ? 'Enter a product name' : null,
                onSaved: (value) => _name = value,
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: _price != null ? _price.toString() : '',
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter a price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) => _price = double.tryParse(value!),
              ),

              SizedBox(height: 16),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                onSaved: (value) => _description = value,
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: _discount,
                decoration: InputDecoration(labelText: 'Discount'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _discount = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateProduct,
                child: Text('Update Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
