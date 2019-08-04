import 'package:flutter/material.dart';
import 'package:flutter_shop/models/product.dart';
import 'package:flutter_shop/services/products_service.dart';
import 'package:flutter_shop/widgets/product_form.dart';
import 'package:provider/provider.dart';

class ProductFormPage extends StatelessWidget {
  static const route = '/product-form';
  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);
    final productId = ModalRoute.of(context).settings.arguments as String;
    return StreamProvider<Product>.value(
        value: productsService.getById(productId),
        initialData: null,
        child: ProductForm());
  }
}
