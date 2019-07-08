import 'package:flutter/material.dart';
import 'package:flutter_expenses/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final Function _addTransaction;

  TransactionForm(this._addTransaction);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime _date;

  void _showDatepicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((date) => setState(() => _date = date));
  }

  void _submit() {
    final title = _titleController.text;
    final amount = double.tryParse(_amountController.text);
    if (title != null && (amount != null && amount > 0) && _date != null) {
      var transaction = Transaction(
          id: DateTime.now().toString(),
          amount: amount,
          title: title,
          date: _date);
      widget._addTransaction(transaction);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom +
                10 // View Insets gives things in the view like the soft keyboard
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (val) => _submit(),
              // onChanged: (val) => _title = val,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (val) => _submit(),
              // onChanged: (val) => _amount = val,
            ),
            Container(
              height: 50,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: _date == null
                        ? Text('No Date Chosen')
                        : Text(
                            'Date: ${DateFormat('yyyy-MM-dd').format(_date)}'),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _showDatepicker,
                  ),
                ],
              ),
            ),
            RaisedButton(
              child: Text(
                'Add Transaction',
                style: TextStyle(fontSize: 18),
              ),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: _submit,
            )
          ],
        ),
      ),
    ));
  }
}
