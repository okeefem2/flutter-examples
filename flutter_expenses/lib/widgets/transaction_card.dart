import 'package:flutter/material.dart';
import 'package:flutter_expenses/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final Transaction _transaction;
  final Function deleteTransaction;

  TransactionCard(this._transaction, this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).accentColor, width: 2)),
                child: Text(
                  '\$${_transaction.amount.toStringAsFixed(2)}', // toString not need in interpolation, dart does this for us
                  style: Theme.of(context)
                      .textTheme
                      .title, // Treat this text as a title
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(_transaction.title,
                      style: Theme.of(context).textTheme.title),
                  Text(DateFormat('yyyy-MM-dd').format(_transaction.date),
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
            onPressed: () => deleteTransaction(_transaction.id),
          )
        ],
      ),
    );
  }
}
