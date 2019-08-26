import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/models/cart_item.dart';
import 'package:flutter_shop/services/cart_service.dart';
import 'package:flutter_shop/widgets/app_drawer.dart';
import 'package:flutter_shop/widgets/cart_button.dart';
import 'package:flutter_shop/widgets/products_grid.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductOverviewPage extends StatefulWidget {
  static const route = 'product-overview';
  @override
  _ProductOverviewPageState createState() => _ProductOverviewPageState();
}

class _ProductOverviewPageState extends State<ProductOverviewPage> {
  bool _favoritesOnly = false;

  @override
  Widget build(BuildContext context) {
    final cartService = Provider.of<CartService>(context, listen: false);
    var user = Provider.of<FirebaseUser>(context, listen: false);

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('Shop'),
        actions: <Widget>[
          // Use local widget state for filtering!
          // Consumer<ProductsProvider>(
          //   builder: (ctx, products, _) =>
          PopupMenuButton(
            onSelected: (FilterOptions selected) {
              setState(() {
                _favoritesOnly = selected == FilterOptions.Favorites;
              });
            },
            icon: const Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text('Favorites'),
                value: FilterOptions.Favorites,
              ),
              const PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
          StreamProvider<List<CartItem>>.value(
              value: cartService.getCartItems(user
                  .uid), // TODO use actual user Id when that part is implemented
              initialData: [],
              child: CartButton())
          // )
        ],
      ),
      body: new ProductsGrid(favoritesOnly: _favoritesOnly),
    );
  }
}
