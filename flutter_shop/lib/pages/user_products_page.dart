import 'package:flutter/material.dart';
import 'package:flutter_shop/providers/products_provider.dart';
import 'package:flutter_shop/widgets/app_drawer.dart';
import 'package:flutter_shop/widgets/user_product_list_item.dart';
import 'package:provider/provider.dart';

import 'product_form_page.dart';

class UserProductsPage extends StatelessWidget {
  static const route = '/user-products';
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
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
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
              itemCount: productsProvider.products.length,
              itemBuilder: (_, index) => Column(
                    children: <Widget>[
                      UserProductListItem(
                          product: productsProvider.products[index]),
                      Divider(),
                    ],
                  )),
        ));
  }
}
