import 'package:flutter/material.dart';
import 'package:flutter_shop/providers/products_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatelessWidget {
  static const route = '/product-detail';
  @override
  Widget build(BuildContext context) {
    final productId =
        ModalRoute.of(context).settings.arguments as String; // Just one arg

    final productsData = Provider.of<ProductsProvider>(context,
        listen:
            false); // Don't rerun if the products change, just get the data once
    final product = productsData.getById(productId);
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
      ),
    );
  }
}
