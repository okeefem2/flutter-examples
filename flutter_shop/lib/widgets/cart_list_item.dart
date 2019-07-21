import 'package:flutter/material.dart';
import 'package:flutter_shop/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartListItem extends StatelessWidget {
  final CartItem cartItem;
  final String productId;

  const CartListItem({Key key, this.cartItem, this.productId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: ValueKey(cartItem.id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      ),
      onDismissed: (direction) {
        Provider.of<CartProvider>(context, listen: false).remove(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListTile(
            leading: CircleAvatar(
                child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(child: Text('\$${cartItem.price}')),
            )),
            title: Text(cartItem.title),
            subtitle: Text('Total \$${cartItem.price * cartItem.quantity}'),
            trailing: Text('${cartItem.quantity} X'),
          ),
        ),
      ),
    );
  }
}
