import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool isFavorite;
  DocumentReference reference; // TODO make final when app is reactive

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    @required this.price,
    this.isFavorite = false,
  });

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Product update({
    String id,
    String title,
    String description,
    String imageUrl,
    double price,
  }) {
    return Product(
      id: id == null ? this.id : id,
      title: title == null ? this.title : title,
      description: description == null ? this.description : description,
      price: price == null ? this.price : price,
      imageUrl: imageUrl == null ? this.imageUrl : imageUrl,
      isFavorite: this.isFavorite,
    );
  }

  Product.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['id'] != null),
        assert(map['title'] != null),
        assert(map['description'] != null),
        assert(map['imageUrl'] != null),
        assert(map['price'] != null),
        id = map['id'],
        title = map['title'],
        description = map['description'],
        imageUrl = map['imageUrl'],
        price = map['price'];

  Product.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
