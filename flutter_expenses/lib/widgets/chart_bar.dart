import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double amountPercent;

  // Const constructor needs all final props
  // Every instance is immutable when created
  // Then if we know that a widget will never change after compile time, using const in front of the object
  // creation will make it so the widget is never rebuilt
  const ChartBar({Key key, this.label, this.amount, this.amountPercent})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: buildBar,
    );
  }

  Widget buildBar(BuildContext context, BoxConstraints constraints) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        // Fitted box Keeps the label from overflowing
        // Wrapping in a container keeps everything aligned properly if the fitted box changes the child size
        Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
                child: Text('\$${amount.toStringAsFixed(0)}',
                    style: Theme.of(context).textTheme.body1))),
        Container(
          height: constraints.maxHeight *
              0.6, // Dynamically set height based on available space
          width: 10,
          child: Stack(
            children: <Widget>[
              // First widget is bottom
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: amountPercent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          height: constraints.maxHeight * 0.15,
          child: Text('$label', style: Theme.of(context).textTheme.body1),
        ),
      ],
    );
  }
}
