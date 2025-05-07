
class FoodModel {
  final String id;
  final String name;
  final double price;
  final String description;
  final double discount;
  final int stock;
  final int quantity;
  final String imageUrl;

  FoodModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.discount,
    required this.stock,
    required this.quantity,
    required this.imageUrl,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json, String id) {
    return FoodModel(
      id: id,
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      discount: (json['discount'] ?? 0).toDouble(),
      stock: (json['stock'] ?? 0).toInt(),
      quantity: (json['quantity'] ?? 0).toInt(),
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'description': description,
      'discount': discount,
      'stock': stock,
      'quantity': quantity,
      'imageUrl': imageUrl,
    };
  }
}
