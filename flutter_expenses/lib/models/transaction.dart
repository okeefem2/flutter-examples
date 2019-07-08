import 'package:flutter/foundation.dart';

class Transaction {
  // Make these each runtime constants, so when they get their initial value
  // They do not change afterward
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date,
  });
}
