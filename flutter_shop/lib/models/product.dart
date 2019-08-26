import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final String userId;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    @required this.price,
    @required this.userId,
    this.isFavorite = false,
  });

  Product update({
    String id,
    String title,
    String description,
    String imageUrl,
    String userId,
    double price,
  }) {
    return Product(
      id: id == null ? this.id : id,
      title: title == null ? this.title : title,
      description: description == null ? this.description : description,
      price: price == null ? this.price : price,
      imageUrl: imageUrl == null ? this.imageUrl : imageUrl,
      userId: userId == null ? this.userId : userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'userId': userId,
    };
  }

  Product.fromMap(Map<String, dynamic> map, {this.id, this.isFavorite})
      : assert(map['title'] != null),
        assert(map['description'] != null),
        assert(map['price'] != null),
        assert(map['imageUrl'] != null),
        assert(map['userId'] != null),
        title = map['title'],
        description = map['description'],
        price = map['price'],
        imageUrl = map['imageUrl'],
        userId = map['userId'];

  Product.fromSnapshot(DocumentSnapshot snapshot, {isFavorite = false})
      : this.fromMap(snapshot.data,
            id: snapshot.documentID, isFavorite: isFavorite);
}
