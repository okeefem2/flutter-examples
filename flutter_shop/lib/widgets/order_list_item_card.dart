import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_shop/models/cart_item.dart';
import 'package:flutter_shop/models/order_item.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderListItemCard extends StatefulWidget {
  final OrderItem orderItem;

  const OrderListItemCard({Key key, this.orderItem}) : super(key: key);

  @override
  _OrderListItemCardState createState() => _OrderListItemCardState();
}

class _OrderListItemCardState extends State<OrderListItemCard> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    var products = Provider.of<List<CartItem>>(context);
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _expanded ? min(products.length * 20.0 + 110, 200) : 95,
      child: Card(
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
            AnimatedContainer(
                duration: Duration(milliseconds: 300),
                // Get cart items for order here
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                height: _expanded ? min(products.length * 20.0 + 10, 100) : 0,
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (ctx, index) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        products[index].title,
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        '${products[index].quantity} x \$${products[index].price}',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                ))
          ],
        ),
        margin: EdgeInsets.all(10),
      ),
    );
  }
}
