import 'package:flutter/material.dart';
import 'package:flutter_shop/models/cart_item.dart';
import 'package:flutter_shop/pages/cart_page.dart';
import 'package:flutter_shop/services/cart_service.dart';
import 'package:provider/provider.dart';

import 'badge.dart';

class CartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<List<CartItem>>(context);
    final cartService = Provider.of<CartService>(context, listen: false);
    return Badge(
      value: cartService.getTotalQuantity(cartItems).toString(),
      child: IconButton(
        onPressed: () {
          Navigator.of(context).pushNamed(CartPage.route);
        },
        icon: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
