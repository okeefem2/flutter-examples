import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/cart_page.dart';
import 'package:flutter_shop/providers/cart_provider.dart';
import 'package:flutter_shop/providers/products_provider.dart';
import 'package:flutter_shop/widgets/app_drawer.dart';
import 'package:flutter_shop/widgets/badge.dart';
import 'package:flutter_shop/widgets/products_grid.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductOverviewPage extends StatefulWidget {
  @override
  _ProductOverviewPageState createState() => _ProductOverviewPageState();
}

class _ProductOverviewPageState extends State<ProductOverviewPage> {
  bool _favoritesOnly = false;
  @override
  Widget build(BuildContext context) {
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
          Consumer<CartProvider>(
              builder: (ctx, cartData, child) => Badge(
                    value: cartData.count.toString(),
                    child: child,
                  ),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CartPage.route);
                },
                icon: const Icon(Icons.shopping_cart),
              )),
          // )
        ],
      ),
      body: new ProductsGrid(favoritesOnly: _favoritesOnly),
    );
  }
}
