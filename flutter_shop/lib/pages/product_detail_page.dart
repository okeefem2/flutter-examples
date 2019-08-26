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
        initialData: new Product(
            id: '',
            description: '',
            title: '',
            price: 0,
            userId: '',
            imageUrl: null),
        child: new ProductDetail());
  }
}

class ProductDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var product = Provider.of<Product>(context);
    // get product
    return Scaffold(
        // appBar: AppBar(
        //     title: Text(
        //   product.title,
        // )),
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 300,
          pinned: true, // Sticky header
          flexibleSpace: FlexibleSpaceBar(
            title: Text(product?.title),
            background: Hero(
                tag: product?.id,
                child: product?.imageUrl != null
                    ? Image.network(product?.imageUrl, fit: BoxFit.cover)
                    : Image.asset('assets/images/product-placeholder.png')),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(height: 20),
            Text('\$${product?.price}',
                style: TextStyle(color: Colors.grey, fontSize: 20)),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                product?.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            SizedBox(height: 20),
          ]),
        )
      ],
    ));
  }
}
