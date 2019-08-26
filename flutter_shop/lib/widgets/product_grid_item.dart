import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/models/product.dart';
import 'package:flutter_shop/services/cart_service.dart';
import 'package:flutter_shop/services/products_service.dart';
import 'package:provider/provider.dart';

class ProductGridItem extends StatelessWidget {
  final Product product;

  const ProductGridItem({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartService = Provider.of<CartService>(context, listen: false);
    final user = Provider.of<FirebaseUser>(context, listen: false);
    // Using provider of will re run the entire build method, but you can use the Consumer widget around what you specifically want to rebuild when a change is
    // consumed. Also the 3rd arg to the consumer builder is a child widget/tree that will not rebuild when new data is consumed
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed('/product-detail', arguments: product.id);
            },
            child: Hero(
              // Hero allows for reuse of image across pages
              tag: product.id,
              child: FadeInImage(
                fit: BoxFit.cover,
                placeholder:
                    AssetImage('assets/images/product-placeholder.png'),
                image: NetworkImage(product.imageUrl),
              ),
            )),
        footer: GridTileBar(
          title: Text(product.title, textAlign: TextAlign.center),
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: product.isFavorite != null && product.isFavorite
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_border),
            color: Theme.of(context).accentColor,
            onPressed: () {
              Provider.of<ProductsService>(context, listen: false)
                  .favoriteProduct(user.uid, product.id);
            },
          ),
          trailing: IconButton(
            icon: Icon(Icons.add_shopping_cart),
            color: Theme.of(context).accentColor,
            onPressed: () {
              cartService.add(
                user.uid,
                productId: product.id,
                price: product.price,
                title: product.title,
              );
              // Grab the nearest scaffold in the tree of the given context
              Scaffold.of(context).hideCurrentSnackBar(); // Prevent multi snack
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('${product.title} added to cart!'),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cartService.removeOne(user.uid, product.id);
                    },
                  )));
            },
          ),
        ),
      ),
    );
  }
}
