import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_shop/providers/orders_provider.dart';
import 'package:intl/intl.dart';

class OrderListItem extends StatefulWidget {
  final OrderItem orderItem;

  const OrderListItem({Key key, this.orderItem}) : super(key: key);

  @override
  _OrderListItemState createState() => _OrderListItemState();
}

class _OrderListItemState extends State<OrderListItem> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.orderItem.amount}'),
            subtitle: Text(
                DateFormat('dd/MM/yyyy').format(widget.orderItem.dateTime)),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                height: min(widget.orderItem.products.length * 10.0 + 100, 100),
                child: ListView.builder(
                  itemCount: widget.orderItem.products.length,
                  itemBuilder: (ctx, index) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.orderItem.products[index].title,
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        '${widget.orderItem.products[index].quantity} x \$${widget.orderItem.products[index].price}',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                ))
        ],
      ),
      margin: EdgeInsets.all(10),
    );
  }
}
