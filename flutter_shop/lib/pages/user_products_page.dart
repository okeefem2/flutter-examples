import 'package:flutter/material.dart';
import 'package:flutter_shop/models/product.dart';
import 'package:flutter_shop/services/products_service.dart';
import 'package:flutter_shop/widgets/app_drawer.dart';
import 'package:flutter_shop/widgets/user_product_list_item.dart';
import 'package:provider/provider.dart';

import 'product_form_page.dart';

class UserProductsPage extends StatelessWidget {
  static const route = '/user-products';
  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: const Text('Your Products'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(ProductFormPage.route);
              },
            )
          ],
        ),
        body: StreamProvider<List<Product>>.value(
            value: productsService.products,
            initialData: null,
            child: new ProductsList()));
  }
}

class ProductsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var products = Provider.of<List<Product>>(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (_, index) => Column(
                children: <Widget>[
                  UserProductListItem(product: products[index]),
                  Divider(),
                ],
              )),
    );
  }
}
