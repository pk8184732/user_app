
class CartModel {
  final String id;
  final String name;
  final double price;
  int quantity;
  String image;

  CartModel({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
  });
}
