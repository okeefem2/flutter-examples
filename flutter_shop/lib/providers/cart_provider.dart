import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get cartItems {
    return {..._cartItems};
  }

  int get count {
    return _cartItems.keys
        .fold(0, (count, key) => count + _cartItems[key].quantity);
  }

  CartItem getByIndex(int index) {
    return cartItems.values.toList()[index];
  }

  String getIdByIndex(int index) {
    return cartItems.keys.toList()[index];
  }

  double get total {
    return _cartItems.keys.fold(
        0,
        (count, key) =>
            count + (_cartItems[key].price * _cartItems[key].quantity));
  }

  void add({String productId, double price, String title, int quantity = 1}) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
        productId,
        (cartItem) => CartItem(
          id: cartItem.id,
          title: cartItem.title,
          price: cartItem.price,
          quantity: cartItem.quantity + quantity,
        ),
      );
    } else {
      _cartItems.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: quantity,
        ),
      );
    }
    notifyListeners();
  }

  void remove(String id) {
    _cartItems.remove(id);
    notifyListeners();
  }

  void clear() {
    _cartItems = {};
    notifyListeners();
  }
}
