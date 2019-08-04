import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_shop/models/product.dart';

class ProductsService {
  final _productsRef = Firestore.instance.collection('products');

  Stream<List<Product>> get products {
    return _productsRef.snapshots().map((snapshot) {
      return snapshot.documents
          .map((docSnapshot) => Product.fromSnapshot(docSnapshot));
    });
  }

  Stream<List<Product>> get favorites {
    return _productsRef
        .where('isFavorite', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.documents
          .map((docSnapshot) => Product.fromSnapshot(docSnapshot));
    });
    ;
  }

  Stream<Product> getById(String id) {
    return _productsRef.document(id).snapshots().map((docSnapshot) {
      return Product.fromSnapshot(docSnapshot);
    });
  }

  void saveProduct(Product product) {
    if (product.id == null) {
      _productsRef.add(product.toMap());
    } else {
      _productsRef.document(product.id).updateData(product.toMap());
    }
  }

  void deleteProduct(String id) {
    _productsRef.document(id).delete();
  }
}
