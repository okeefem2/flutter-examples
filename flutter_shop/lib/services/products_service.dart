import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_shop/models/product.dart';
import 'package:rxdart/rxdart.dart';

class ProductsService {
  final _productsRef = Firestore.instance.collection('products');
  final _userFavoritesRef = Firestore.instance.collection('userFavorites');

  Stream<List<Product>> getProducts(userId) {
    // Use combineLatest to react when either stream emits
    return CombineLatestStream.combine2(
        getUserFavorites(userId), _productsRef.snapshots(),
        (List<String> userFavorites, QuerySnapshot productSnapshots) {
      return productSnapshots.documents
          .map((DocumentSnapshot docSnapshot) => Product.fromSnapshot(
              docSnapshot,
              isFavorite: userFavorites.indexOf(docSnapshot.documentID) != -1))
          .toList();
    });
  }

  Stream<List<Product>> getUserProducts(userId) {
    return _productsRef
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.documents
          .map((docSnapshot) => Product.fromSnapshot(docSnapshot))
          .toList();
    });
  }

  Stream<List<String>> getUserFavorites(userId) {
    return _userFavoritesRef
        .document(userId)
        .collection('products')
        .snapshots()
        .map((snapshot) {
      return snapshot.documents
          .map((docSnapshot) => docSnapshot.documentID)
          .toList();
    });
  }

  Stream<Product> getById(String id) {
    return _productsRef.document(id).snapshots().map((docSnapshot) {
      return docSnapshot.exists
          ? Product.fromSnapshot(docSnapshot)
          : Product(
              userId: null,
              id: null,
              title: '',
              price: 0,
              description: '',
              imageUrl: '',
            );
    });
  }

  Future<void> saveProduct(Product product) {
    if (product.id == null) {
      return _productsRef.add(product.toMap());
    } else {
      return _productsRef.document(product.id).updateData(product.toMap());
    }
  }

  Future<void> deleteProduct(String id) {
    return _productsRef.document(id).delete();
  }

  Future<void> favoriteProduct(String userId, String id) async {
    var favoriteProductRef =
        _userFavoritesRef.document(userId).collection('products').document(id);
    var favoriteProduct = await favoriteProductRef.get();

    if (favoriteProduct.exists) {
      favoriteProductRef.delete();
    } else {
      favoriteProductRef.setData({'isFavorite': true});
    }
  }
}
