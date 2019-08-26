import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_shop/models/place.dart';

class PlacesService {
  final _placesRef = Firestore.instance.collection('places');

  Stream<List<Place>> getPlaces() {
    return _placesRef.snapshots().map((snapshot) {
      return snapshot.documents
          .map((docSnapshot) => Place.fromSnapshot(docSnapshot))
          .toList();
    });
  }

  Stream<Place> getPlace(String id) {
    return _placesRef.document(id).snapshots().map((docSnapshot) {
      return Place.fromSnapshot(docSnapshot);
    });
  }

  Future<void> addPlace(
      String title, File image, PlaceLocation location) async {
    return _placesRef.add({
      'title': title,
      'imagePath': image.path,
      'location': location.toMap()
    });
  }
}
