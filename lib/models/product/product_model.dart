
//
//
// class Product {
//   final String id;
//   final String name;
//   final double price;
//
//   Product({required this.id, required this.name, required this.price});
//
//   factory Product.fromJson(Map<String, dynamic> json, String id) {
//     return Product(
//       id: id,
//       name: json['name'],
//       price: json['price'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'price': price,
//     };
//   }
// }


class Product {
  final String id;
  final String name;
  final double price;
  final String description;
  final double discount;
  final int stock;
  final int quantity;
  final String imageUrl; // Added imageUrl field

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.discount,
    required this.stock,
    required this.quantity,
    required this.imageUrl, // Added imageUrl in constructor
  });

  // Factory constructor to create a Product object from a JSON map
  factory Product.fromJson(Map<String, dynamic> json, String id) {
    return Product(
      id: id,
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      discount: (json['discount'] ?? 0).toDouble(),
      stock: (json['stock'] ?? 0).toInt(),
      quantity: (json['quantity'] ?? 0).toInt(),
      imageUrl: json['imageUrl'] ?? '', // Handle missing imageUrl gracefully
    );
  }

  // Method to convert a Product object into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'description': description,
      'discount': discount,
      'stock': stock,
      'quantity': quantity,
      'imageUrl': imageUrl, // Include imageUrl in the JSON map
    };
  }
}
