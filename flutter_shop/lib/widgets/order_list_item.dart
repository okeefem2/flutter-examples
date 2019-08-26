import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_shop/models/cart_item.dart';
import 'package:flutter_shop/models/order_item.dart';
import 'package:flutter_shop/services/orders_service.dart';
import 'package:flutter_shop/widgets/order_list_item_card.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderListItem extends StatelessWidget {
  final OrderItem orderItem;

  const OrderListItem({Key key, this.orderItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordersService = Provider.of<OrdersService>(context, listen: false);
    return StreamProvider<List<CartItem>>.value(
        value: ordersService.getProductsForOrder(orderItem.id),
        initialData: [],
        child: OrderListItemCard(
          orderItem: orderItem,
        ));
  }
}
