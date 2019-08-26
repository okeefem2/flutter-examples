import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/models/order_item.dart';
import 'package:flutter_shop/services/orders_service.dart';
import 'package:flutter_shop/widgets/app_drawer.dart';
import 'package:flutter_shop/widgets/order_list_item.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
  static const route = '/orders';
  @override
  Widget build(BuildContext context) {
    final ordersService = Provider.of<OrdersService>(context);
    var user = Provider.of<FirebaseUser>(context, listen: false);
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(title: Text('Your Orders')),
        body: StreamProvider<List<OrderItem>>.value(
            value: ordersService.getUserOrders(user.uid),
            initialData: [],
            child: new OrdersList()));
  }
}

class OrdersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var orders = Provider.of<List<OrderItem>>(context);
    return ListView.builder(
      itemBuilder: (ctx, index) => OrderListItem(orderItem: orders[index]),
      itemCount: orders != null ? orders.length : 0,
    );
  }
}
