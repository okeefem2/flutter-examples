import 'package:flutter/material.dart';
import 'package:flutter_shop/models/product.dart';
import 'package:flutter_shop/services/products_service.dart';
import 'package:flutter_shop/widgets/product_grid_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool favoritesOnly;

  const ProductsGrid({Key key, this.favoritesOnly}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);

    return StreamProvider<List<Product>>.value(
        value: favoritesOnly
            ? productsService.favorites
            : productsService.products,
        initialData: null,
        child: buildGrid(context));
  }

  Widget buildGrid(BuildContext context) {
    var products = Provider.of<List<Product>>(context);
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ProductGridItem(product: products[i]),
      // This Sliver delegate is used to add a fixed number of items in a row
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, childAspectRatio: 3 / 2, // Taller than wide
        crossAxisSpacing: 10, mainAxisSpacing: 10,
      ),
    );
  }
}
