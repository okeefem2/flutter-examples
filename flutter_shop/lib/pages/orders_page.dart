import 'package:flutter/material.dart';
import 'package:flutter_shop/providers/orders_provider.dart';
import 'package:flutter_shop/widgets/app_drawer.dart';
import 'package:flutter_shop/widgets/order_list_item.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
  static const route = '/orders';
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrdersProvider>(context);
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(title: Text('Your Orders')),
        body: ListView.builder(
          itemBuilder: (ctx, index) =>
              OrderListItem(orderItem: orders.orders[index]),
          itemCount: orders.orders.length,
        ));
  }
}
