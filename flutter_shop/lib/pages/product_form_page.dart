import 'package:flutter/material.dart';
import 'package:flutter_shop/providers/product_provider.dart';
import 'package:flutter_shop/providers/products_provider.dart';
import 'package:provider/provider.dart';

class ProductFormPage extends StatefulWidget {
  static const route = '/product-form';
  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
  };
  var _init = true;
  var _product = Product(
    id: null,
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
  );
  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus &&
        _imageUrlController.text.startsWith('http')) {
      // Lost focus
      setState(
          () {}); // Rebuild the screen to catch url change if the user focuses out without hitting done
    }
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_init) {
      final productId = ModalRoute.of(context).settings.arguments as String;

      if (productId != null) {
        final product = Provider.of<ProductsProvider>(context, listen: false)
            .getById(productId);
        _product = product;
        _initValues = {
          'title': product.title,
          'description': product.description,
          'price': product.price.toString(),
        };

        _imageUrlController.text = product.imageUrl;
      }
      _init = false;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _save() {
    // Calls onSave of all fields in the form
    final isValid = _form.currentState.validate();
    if (!isValid) return;
    _form.currentState.save();

    Provider.of<ProductsProvider>(context, listen: false).saveProduct(_product);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _save,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: ListView(
            // using a SingleChildScrollView and Column here instead could help
            // if the form is long. ListView dynamically adds/removes widgets as you scroll so input data
            // could be lost in cases where this occurs
            children: <Widget>[
              TextFormField(
                initialValue: _initValues['title'],
                validator: (value) {
                  return value.isEmpty
                      ? 'Please provide a value'
                      : null; // value is correct if null
                  // returning text is the error message
                },
                onSaved: (value) => _product = _product.update(title: value),
                decoration: InputDecoration(
                  labelText: 'Title', // Placeholder
                  // errorStyle: , // can set the error styles too
                ),
                textInputAction: TextInputAction
                    .next, // Pressing button will move to next input
                onFieldSubmitted: (_) => // Focus in using the focus node
                    FocusScope.of(context).requestFocus(_priceFocusNode),
              ),
              TextFormField(
                initialValue: _initValues['price'],
                validator: (value) {
                  if (value.isEmpty) return 'Please provide a value';
                  var parsedValue = double.tryParse(value);
                  if (parsedValue == null)
                    return 'Please provide a valid number';
                  if (parsedValue <= 0)
                    return 'Please provide a positive non zero number';
                  return null;
                },
                onSaved: (value) =>
                    _product = _product.update(price: double.parse(value)),
                decoration: InputDecoration(
                  labelText: 'Price', // Placeholder
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_descriptionFocusNode),
                focusNode: _priceFocusNode,
              ),
              TextFormField(
                initialValue: _initValues['description'],
                validator: (value) {
                  if (value.isEmpty) return 'Please provide a value';
                  return null;
                },
                onSaved: (value) =>
                    _product = _product.update(description: value),
                decoration: InputDecoration(
                  labelText: 'Description', // Placeholder
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.next,
                focusNode: _descriptionFocusNode,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 10, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter a url')
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) return 'Please provide a value';
                        if (!value.startsWith('http'))
                          return 'Please enter a valid URL';
                        return null;
                      },
                      onSaved: (value) =>
                          _product = _product.update(imageUrl: value),
                      // Text form field has unbounded width, so inside the row we need bounds
                      decoration: InputDecoration(
                        labelText: 'Image Url', // Placeholder
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) => _save(),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
