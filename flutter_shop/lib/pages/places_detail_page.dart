import 'package:flutter/material.dart';
import 'package:flutter_shop/models/place.dart';
import 'package:flutter_shop/services/places_service.dart';
import 'package:flutter_shop/widgets/place_detail.dart';
import 'package:provider/provider.dart';

class PlacesDetailPage extends StatelessWidget {
  static const route = '/places-detail';
  @override
  Widget build(BuildContext context) {
    final placesService = Provider.of<PlacesService>(context);
    final id = ModalRoute.of(context).settings.arguments;
    return StreamProvider<Place>.value(
      value: placesService.getPlace(id),
      initialData:
          Place(id: null, title: null, imagePath: null, location: null),
      child: new PlaceDetail(),
    );
  }
}
