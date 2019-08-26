import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/models/cart_item.dart';
import 'package:flutter_shop/services/cart_service.dart';
import 'package:flutter_shop/services/orders_service.dart';
import 'package:flutter_shop/widgets/cart_list_item.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  static const route = '/cart';
  @override
  Widget build(BuildContext context) {
    final cartService = Provider.of<CartService>(context, listen: false);
    var user = Provider.of<FirebaseUser>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text('Your Cart')),
      body: StreamProvider<List<CartItem>>.value(
          value: cartService.getCartItems(user
              .uid), // TODO use actual user Id when that part is implemented
          initialData: [],
          child: new Cart(userId: user.uid, cartService: cartService)),
    );
  }
}

class Cart extends StatelessWidget {
  const Cart({
    Key key,
    @required this.userId,
    @required this.cartService,
  }) : super(key: key);

  final String userId;
  final CartService cartService;

  @override
  Widget build(BuildContext context) {
    var cartItems = Provider.of<List<CartItem>>(context);
    final cartTotal = cartService.getTotal(cartItems);
    return Column(
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
                      label: Text('\$${cartTotal.toStringAsFixed(2)}',
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
                        Provider.of<OrdersService>(context, listen: false)
                            .addOrder(userId, cartItems, cartTotal);
                        cartService.clear(userId);
                        Navigator.of(context).pop();
                      },
                      textColor: Theme.of(context).primaryColor,
                    )
                  ],
                ))),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) =>
                CartListItem(cartItem: cartItems[index]),
          ),
        )
      ],
    );
  }
}
