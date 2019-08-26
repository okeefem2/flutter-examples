import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_shop/models/cart_item.dart';

class CartService {
  final _cartsRef = Firestore.instance.collection('carts');

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

  Future<void> add(String userId,
      {String productId, double price, String title, int quantity = 1}) async {
    var cartItemsRef = _cartsRef.document(userId).collection('cartItems');
    var cartItemSnapshot = await cartItemsRef.document(productId).get();

    if (cartItemSnapshot.exists) {
      var cartItem = CartItem.fromSnapshot(cartItemSnapshot);
      return cartItemsRef
          .document(productId)
          .updateData({'quantity': cartItem.quantity + quantity});
    } else {
      print('Adding to cart');
      var newCartItem = CartItem(
        productId: productId,
        title: title,
        price: price,
        quantity: quantity,
      );
      return cartItemsRef.document(productId).setData(newCartItem.toMap());
    }
  }

  Future<void> remove(String userId, String productId) {
    return _cartsRef
        .document(userId)
        .collection('cartItems')
        .document(productId)
        .delete();
  }

  Future<void> clear(String userId) {
    print(userId);

    return Firestore.instance.runTransaction((Transaction tx) async {
      var cartDocRef = _cartsRef.document(userId);
      var cartItemDocs =
          await cartDocRef.collection('cartItems').getDocuments();
      cartItemDocs.documents.forEach((cartItemSnapshot) async =>
          await cartItemSnapshot.reference.delete());
      await cartDocRef.delete();
    });
  }

  Future<void> removeOne(String userId, String productId) async {
    var cartItemsRef = _cartsRef.document(userId).collection('cartItems');
    var cartItem =
        CartItem.fromSnapshot(await cartItemsRef.document(productId).get());

    if (cartItem.quantity > 1) {
      return cartItemsRef
          .document(cartItem.productId)
          .updateData({'quantity': cartItem.quantity - 1});
    } else {
      return remove(userId, cartItem.productId);
    }
  }
}
