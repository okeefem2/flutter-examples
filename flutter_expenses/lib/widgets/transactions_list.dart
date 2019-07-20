import 'package:flutter/material.dart';
import 'package:flutter_expenses/models/transaction.dart';
import 'package:flutter_expenses/widgets/transaction_card.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  const TransactionList({Key key, this.transactions, this.deleteTransaction})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // better perf would be to have a separate tx list widget
      // child: SingleChildScrollView(
      //   // Single child scroll view needs to have a parent with a fixed height
      //   child: Column(
      //     children: transactions.map((tx) => TransactionCard(tx)).toList(),
      //   ),
      // ),
      // ListView needs parent with a fixed height
      // ListView renders all items even when off screen,
      // ListView.builder does not render what is not shown
      child:
          transactions.isNotEmpty // TODO set it this way to test, need to flip
              ? ListView(
                  // ListView builder doesn't work with the keys right now...
                  // So use the builder when the children are stateless! but not when stateful
                  children: transactions
                      .map((tx) => TransactionCard(
                          key: ValueKey(tx.id),
                          transaction: tx,
                          deleteTransaction: deleteTransaction))
                      .toList(),
                )
              // ? ListView.builder(
              //     itemCount: transactions.length,
              //     itemBuilder: (ctx, index) => TransactionCard(
              //         key: ValueKey(transactions[index].id),
              //         transaction: transactions[index],
              //         deleteTransaction: deleteTransaction),
              //   )
              : LayoutBuilder(builder: buildNoTx),
    );
  }

  Column buildNoTx(BuildContext context, BoxConstraints boxConstraints) {
    return Column(
      children: <Widget>[
        Text(
          'No transactions added yet!',
          style: Theme.of(context).textTheme.title,
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
            height: boxConstraints.maxHeight * 0.6,
            child: Image.asset(
              'assets/images/waiting.png',
              fit: BoxFit.cover,
            )),
      ],
    );
  }
}
