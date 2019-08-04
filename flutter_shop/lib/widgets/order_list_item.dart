import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_shop/models/cart_item.dart';
import 'package:flutter_shop/models/order_item.dart';
import 'package:flutter_shop/services/orders_service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
    final ordersService = Provider.of<OrdersService>(context);
    return StreamProvider<List<CartItem>>.value(
        value: ordersService.getProductsForOrder(widget.orderItem.id),
        initialData: null,
        child: buildOrderListItem(context));
  }

  Card buildOrderListItem(BuildContext context) {
    var products = Provider.of<List<CartItem>>(context);
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
                // Get cart items for order here
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                height: min(products.length * 10.0 + 100, 100),
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
    );
  }
}
