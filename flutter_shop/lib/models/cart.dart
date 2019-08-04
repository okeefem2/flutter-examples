import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'cart_item.dart';

class Cart {
  final String userId; // use userId as the id to allow one per user
  // final double total; // TODO this should really be a field aggregated by cloud functions
  final List<CartItem> cartItems;
  final DocumentReference reference;

  Cart({
    @required this.userId,
    @required this.cartItems,
    @required this.reference,
  });

  Cart.fromMap(
      Map<String, dynamic> map, List<DocumentSnapshot> productDocuments,
      {@required this.userId, @required this.reference})
      : cartItems = productDocuments.map((d) => CartItem.fromSnapshot(d));

  Cart.fromSnapshot(DocumentSnapshot snapshot, QuerySnapshot cartItemsSnapshot)
      : this.fromMap(snapshot.data, cartItemsSnapshot.documents,
            userId: snapshot.documentID, reference: snapshot.reference);
}
