import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartItem {
  // In a cart and an order, only one cartItem per product
  final String productId;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.productId,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'title': title,
      'quantity': quantity,
      'price': price,
    };
  }

  CartItem.fromMap(Map<String, dynamic> map, {this.productId})
      : assert(map['title'] != null),
        assert(map['quantity'] != null),
        assert(map['price'] != null),
        title = map['title'],
        quantity = map['quantity'],
        price = map['price'];

  CartItem.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, productId: snapshot.documentID);
}
