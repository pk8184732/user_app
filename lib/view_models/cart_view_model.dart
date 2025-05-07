
import 'package:flutter/cupertino.dart';
import '../models/cart/cart_model.dart';

class CartViewModel extends ChangeNotifier {
  final Map<String, CartModel> _items = {};

  Map<String, CartModel> get items => _items;

  void addItem(String id, String name, double price, String image) {
    if (_items.containsKey(id)) {
      _items[id]!.quantity += 1;
    } else {
      _items[id] = CartModel(
        id: id,
        name: name,
        price: price,
        quantity: 1,
        image: image,
      );
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void increaseQuantity(String id) {
    _items[id]!.quantity += 1;
    notifyListeners();
  }

  void decreaseQuantity(String id) {
    if (_items[id]!.quantity > 1) {
      _items[id]!.quantity -= 1;
    } else {
      _items.remove(id);
    }
    notifyListeners();
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, item) {
      total += item.price * item.quantity;
    });
    return total;
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
