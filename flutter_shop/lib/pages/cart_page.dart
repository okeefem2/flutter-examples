import 'package:flutter/material.dart';
import 'package:flutter_shop/providers/cart_provider.dart';
import 'package:flutter_shop/providers/orders_provider.dart';
import 'package:flutter_shop/widgets/cart_list_item.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  static const route = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Your Cart')),
      body: Column(
        children: <Widget>[
          Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text('Total', style: TextStyle(fontSize: 20)),
                      const Spacer(),
                      Chip(
                        label: Text('\$${cart.total.toStringAsFixed(2)}',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .title
                                    .color)),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      FlatButton(
                        child: const Text('Order Now'),
                        onPressed: () {
                          Provider.of<OrdersProvider>(context, listen: false)
                              .addOrder(
                                  cart.cartItems.values.toList(), cart.total);
                          cart.clear();
                        },
                        textColor: Theme.of(context).primaryColor,
                      )
                    ],
                  ))),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.cartItems.length,
              itemBuilder: (context, index) => CartListItem(
                  cartItem: cart.getByIndex(index),
                  productId: cart.getIdByIndex(index)),
            ),
          )
        ],
      ),
    );
  }
}
