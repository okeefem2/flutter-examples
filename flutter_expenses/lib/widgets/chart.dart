import 'package:flutter/material.dart';
import 'package:flutter_expenses/models/transaction.dart';
import 'package:intl/intl.dart';

import 'chart_bar.dart';

class Chart extends StatelessWidget {
  // Expecting these to be the transactions from the last 7 days
  final List<Transaction> recentTransactions;

  const Chart({Key key, this.recentTransactions}) : super(key: key);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      // Get the weekday relative to today
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double amount = 0;
      // for (var i = 0; i < recentTransactions.length; i++) {
      for (var tx in recentTransactions) {
        if (tx.date.day == weekDay.day &&
            tx.date.month == weekDay.month &&
            tx.date.year == weekDay.year) {
          amount += tx.amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay),
        'amount': amount,
      };
    }).reversed.toList();
  }

  double get totalAmount {
    // Basically a reduce from JS!
    return groupedTransactionValues.fold(
        0.0, (sum, data) => sum + data['amount']);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ...groupedTransactionValues
              .map((data) => Flexible(
                    // flex: 2, use this to distribute the space, similar to flexbox
                    fit: FlexFit
                        .tight, // Forces the child to take up the full space available,
                    // loose makes it so the child only takes up the space needed for content
                    // Expanded is the same as Flexible with flex fit tight set
                    child: ChartBar(
                      label: data['day'],
                      amount: data['amount'],
                      amountPercent: totalAmount == 0
                          ? 0
                          : (data['amount'] as double) / totalAmount,
                    ),
                  ))
              .toList()
        ],
      ),
    );
  }
}
