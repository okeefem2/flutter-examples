import 'package:flutter/material.dart';
import 'package:flutter_shop/models/product.dart';
import 'package:flutter_shop/services/products_service.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatelessWidget {
  static const route = '/product-detail';
  @override
  Widget build(BuildContext context) {
    final productId =
        ModalRoute.of(context).settings.arguments as String; // Just one arg

    final productsService =
        Provider.of<ProductsService>(context, listen: false);

    return StreamProvider<Product>.value(
        value: productsService.getById(productId),
        initialData: null,
        child: buildScaffold(context));
  }

  Widget buildScaffold(BuildContext context) {
    var product = Provider.of<Product>(context);
    // get product
    return Scaffold(
        appBar: AppBar(
            title: Text(
          product.title,
        )),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
              height: 300,
              child: Image.network(product.imageUrl, fit: BoxFit.cover),
              width: double.infinity,
            ),
            SizedBox(height: 10),
            Text('\$${product.price}',
                style: TextStyle(color: Colors.grey, fontSize: 20)),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                product.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ]),
        ));
  }
}
