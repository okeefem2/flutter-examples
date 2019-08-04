import 'package:flutter/material.dart';
import 'package:flutter_shop/models/cart_item.dart';
import 'package:flutter_shop/services/cart_service.dart';
import 'package:provider/provider.dart';

class CartListItem extends StatelessWidget {
  final CartItem cartItem;

  const CartListItem({Key key, this.cartItem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Are you sure'),
                  content: Text('There is no going back'),
                  contentPadding: EdgeInsets.all(10),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('No'),
                      onPressed: () {
                        // Pop the dialog off the stack and yield the desired value to the dialog future
                        Navigator.of(ctx).pop(false);
                      },
                    ),
                    FlatButton(
                      child: Text('Yes'),
                      onPressed: () {
                        Navigator.of(ctx).pop(true);
                      },
                    ),
                  ],
                ));
      },
      direction: DismissDirection.endToStart,
      key: ValueKey(cartItem.productId),
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
        Provider.of<CartService>(context, listen: false).remove('12345',
            cartItem.productId); // TODO change userId when that is done
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
