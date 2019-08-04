import 'package:flutter/material.dart';
import 'package:flutter_shop/models/order_item.dart';
import 'package:flutter_shop/services/orders_service.dart';
import 'package:flutter_shop/widgets/app_drawer.dart';
import 'package:flutter_shop/widgets/order_list_item.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
  static const route = '/orders';
  final userId = '12345'; // TODO when user is determined
  @override
  Widget build(BuildContext context) {
    final ordersService = Provider.of<OrdersService>(context);
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(title: Text('Your Orders')),
        body: StreamProvider<List<OrderItem>>.value(
            value: ordersService.getUserOrders(
                userId), // TODO use actual user Id when that part is implemented
            initialData: [],
            child: buildListView(context)));
  }

  ListView buildListView(context) {
    var orders = Provider.of<List<OrderItem>>(context);
    return ListView.builder(
      itemBuilder: (ctx, index) => OrderListItem(orderItem: orders[index]),
      itemCount: orders.length,
    );
  }
}
