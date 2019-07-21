import 'package:flutter/material.dart';
import 'package:flutter_shop/providers/products_provider.dart';
import 'package:flutter_shop/widgets/product_grid_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool favoritesOnly;

  const ProductsGrid({Key key, this.favoritesOnly}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final products =
        favoritesOnly ? productsData.favorites : productsData.products;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        // ChangeNotifierProvider will clean up 'Subscriptions' for us
        // builder: (ctx) => products[i], // Use if context is neeeded
        value: products[i],
        // Create a provider for each of the products
        child: ProductGridItem(),
      ),
      // This Sliver delegate is used to add a fixed number of items in a row
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, childAspectRatio: 3 / 2, // Taller than wide
        crossAxisSpacing: 10, mainAxisSpacing: 10,
      ),
    );
  }
}
