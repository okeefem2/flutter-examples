import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_expenses/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatefulWidget {
  final Transaction transaction;
  final Function deleteTransaction;
  // If this widget were stateful and in a list like it is, the state
  // Can be messed up when adding/removing from the list because the widgets in the list have
  // detached State objects held in the Element tree referenced to the widget by position in the
  // tree, which for a list is by index. So the widget below the deleted one moves up, and its state is removed
  // and the old state from the removed item is reassigned to the moved item
  // So, by using keys, we can help Flutter track the items and their state by the key instead of position
  TransactionCard({
    Key key,
    @required this.transaction,
    @required this.deleteTransaction,
  }) : super(key: key);

  @override
  _TransactionCardState createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  Color _bgColor;
  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.black,
      Colors.blue,
      Colors.green,
      Colors.purple
    ];

    _bgColor = availableColors[Random().nextInt(5)];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    border: Border.all(
                  // color: Theme.of(context).accentColor,
                  color: _bgColor,
                  width: 2,
                )),
                child: Text(
                  '\$${widget.transaction.amount.toStringAsFixed(2)}', // toString not need in interpolation, dart does this for us
                  style: Theme.of(context)
                      .textTheme
                      .title, // Treat this text as a title
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.transaction.title,
                      style: Theme.of(context).textTheme.title),
                  Text(DateFormat('yyyy-MM-dd').format(widget.transaction.date),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ))
                ],
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.delete),
            color: Theme.of(context).errorColor,
            onPressed: () => widget.deleteTransaction(widget.transaction.id),
          )
        ],
      ),
    );
  }
}
