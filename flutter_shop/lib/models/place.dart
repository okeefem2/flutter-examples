import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_shop/helpers/location_helper.dart';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  const PlaceLocation({
    @required this.latitude,
    @required this.longitude,
    this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    };
  }

  PlaceLocation.fromMap(Map<String, dynamic> map)
      : assert(map['latitude'] != null),
        assert(map['longitude'] != null),
        assert(map['address'] != null),
        latitude = map['latitude'],
        longitude = map['longitude'],
        address = map['address'];

  static Future<PlaceLocation> fromLatLng({double lat, double long}) async {
    final address = await LocationHelper.getAddress(lat: lat, long: long);
    return PlaceLocation(latitude: lat, longitude: long, address: address);
  }
}

class Place {
  final String id;
  final String title;
  final PlaceLocation location;
  final String imagePath;

  Place({
    @required this.id,
    @required this.title,
    @required this.location,
    @required this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'location': location != null ? location.toMap() : null,
      'imagePath': imagePath,
    };
  }

  Place.fromMap(Map<String, dynamic> map, {this.id})
      : assert(map['title'] != null),
        assert(map['imagePath'] != null),
        title = map['title'],
        location = map['location'] != null
            ? PlaceLocation.fromMap(
                new Map<String, dynamic>.from(map['location']))
            : null,
        imagePath = map[
            'imagePath']; // Todo probably just store the id to fetch from sqlite for now

  Place.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, id: snapshot.documentID);
}
