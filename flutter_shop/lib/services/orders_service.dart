import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_shop/models/cart_item.dart';
import 'package:flutter_shop/models/order_item.dart';

class OrdersService {
  final _ordersRef = Firestore.instance.collection('orders');

  Stream<List<OrderItem>> getUserOrders(String userId) {
    return _ordersRef
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.documents
          .map((docSnapshot) => OrderItem.fromSnapshot(docSnapshot));
    });
  }

  Stream<List<CartItem>> getProductsForOrder(orderId) {
    return _ordersRef
        .document(orderId)
        .collection('products')
        .snapshots()
        .map((snapshot) {
      return snapshot.documents
          .map((docSnapshot) => CartItem.fromSnapshot(docSnapshot));
    });
  }

  void addOrder(String userId, List<CartItem> cartItems, double total) async {
    var orderRef = await _ordersRef
        .add({'amount': total, 'dateTime': DateTime.now(), 'userId': userId});

    var productsRef = orderRef.collection('products');
    cartItems.forEach((c) => productsRef.add(c.toMap()));
  }
}
