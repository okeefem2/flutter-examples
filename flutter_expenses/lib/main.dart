import 'package:flutter/material.dart';
import 'package:flutter_expenses/widgets/chart.dart';
import 'package:flutter_expenses/widgets/transaction_form.dart';
import 'package:flutter_expenses/widgets/transactions_list.dart';

import 'models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Expense App',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.purple,
          accentColor: Colors.teal,
          fontFamily: 'Quicksand',
          // Create a default appbar theme with custom styling for anything marked as a title
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                    ),
                    button: TextStyle(
                      color: Colors.white,
                    ),
                  ))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {\
  bool _showChart = true;
  final List<Transaction> transactions = [
    Transaction(
      id: 't1',
      title: 'Axe',
      amount: 6.66,
      date: new DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Acoustic',
      amount: 10.99,
      date: new DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'Gibson',
      amount: 60.66,
      date: new DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'Fender',
      amount: 50.99,
      date: new DateTime.now(),
    ),
    Transaction(
      id: 't5',
      title: 'Mapex Drums',
      amount: 666.66,
      date: new DateTime.now(),
    ),
    Transaction(
      id: 't6',
      title: 'Pearl Drums',
      amount: 10.99,
      date: new DateTime.now(),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return transactions
        .where(
            (tx) => tx.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  void _addTransaction(Transaction transaction) {
    setState(() {
      transactions.add(transaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _showTransactionForm(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
            // Avoid closing the sheet when tapping
            // onTap: () {},
            // behavior: HitTestBehavior.opaque,
            child: TransactionForm(_addTransaction),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Flutter Expense App'),
      actions: <Widget>[
        FlatButton(
          child: Icon(Icons.add),
          onPressed: () => _showTransactionForm(context),
          textColor: Colors.white,
        )
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     Text('Show Chart'),
          //     Switch(
          //       onChanged: (value) {
          //         setState(() {
          //           _showChart = value;
          //         });
          //       },
          //       value: _showChart,
          //     ),
          //   ],
          // ),
          Container(
            height: (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                (MediaQuery.of(context).orientation == Orientation.portrait
                    ? 0.2
                    : 0.4),
            child: Chart(recentTransactions: _recentTransactions),
          ),
          Container(
            height: (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                (MediaQuery.of(context).orientation == Orientation.portrait
                    ? 0.8
                    : 0.6),
            child: TransactionList(
              transactions: transactions,
              deleteTransaction: _deleteTransaction,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTransactionForm(context),
        tooltip: 'Add Transaction',
        child: Icon(Icons.add),
      ),
    );
  }
}
