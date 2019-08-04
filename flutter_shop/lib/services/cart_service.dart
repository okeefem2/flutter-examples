import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_shop/models/cart.dart';
import 'package:flutter_shop/models/cart_item.dart';

class CartService {
  final _cartsRef = Firestore.instance.collection('carts');

  // // One cart per user
  // Stream<Cart> getCartForUser(userId) {
  //   return _cartsRef
  //       .document(userId)
  //       .snapshots()
  //       .map((snapshot) => Cart.fromSnapshot(snapshot));
  // }

  Stream<List<CartItem>> getCartItems(userId) {
    return _cartsRef
        .document(userId)
        .collection('cartItems')
        .snapshots()
        .map((snapshot) {
      return snapshot.documents
          .map((cartItemSnapshot) => CartItem.fromSnapshot(cartItemSnapshot))
          .toList();
    });
  }

  int getTotalQuantity(List<CartItem> cartItems) {
    return cartItems.fold(0, (count, cartItem) => count + cartItem.quantity);
  }

  double getTotal(List<CartItem> cartItems) {
    return cartItems.fold(
        0, (count, cartItem) => count + (cartItem.price * cartItem.quantity));
  }

  void add(String userId,
      {String productId, double price, String title, int quantity = 1}) async {
    var cartItemsRef = _cartsRef.document(userId).collection('cartItems');
    var cartItem =
        CartItem.fromSnapshot(await cartItemsRef.document(productId).get());
    if (cartItem != null) {
      cartItemsRef
          .document(productId)
          .updateData({'quantity': cartItem.quantity + quantity});
    } else {
      var newCartItem = CartItem(
        productId: productId,
        title: title,
        price: price,
        quantity: quantity,
      );
      cartItemsRef.document(productId).setData(newCartItem.toMap());
    }
  }

  void remove(String userId, String productId) {
    _cartsRef
        .document(userId)
        .collection('cartItems')
        .document(productId)
        .delete();
  }

  void clear(String userId) {
    _cartsRef.document(userId).delete();
  }

  void removeOne(String userId, String productId) async {
    var cartItemsRef = _cartsRef.document(userId).collection('cartItems');
    var cartItem =
        CartItem.fromSnapshot(await cartItemsRef.document(productId).get());

    if (cartItem.quantity > 1) {
      cartItemsRef
          .document(cartItem.productId)
          .updateData({'quantity': cartItem.quantity - 1});
    } else {
      remove(userId, cartItem.productId);
    }
  }
}
