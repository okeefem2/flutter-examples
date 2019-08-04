import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'cart_item.dart';

class OrderItem {
  final String id;
  final double amount;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'dateTime': dateTime,
    };
  }

  OrderItem.fromMap(Map<String, dynamic> map, {this.id})
      : assert(map['amount'] != null),
        assert(map['dateTime'] != null),
        amount = map['amount'],
        dateTime = map['dateTime'];

  OrderItem.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, id: snapshot.documentID);
}
