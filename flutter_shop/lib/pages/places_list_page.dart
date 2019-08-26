import 'package:flutter/material.dart';
import 'package:flutter_shop/models/place.dart';
import 'package:flutter_shop/pages/place_form_page.dart';
import 'package:flutter_shop/services/places_service.dart';
import 'package:flutter_shop/widgets/app_drawer.dart';
import 'package:flutter_shop/widgets/places_list.dart';
import 'package:provider/provider.dart';

class PlacesListPage extends StatelessWidget {
  static const route = '/places-list';

  @override
  Widget build(BuildContext context) {
    final placesService = Provider.of<PlacesService>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(PlaceFormPage.route);
            },
          ),
        ],
      ),
      body: Center(
        child: StreamProvider<List<Place>>.value(
            value: placesService.getPlaces(),
            initialData: [],
            child: new PlacesList()),
      ),
    );
  }
}
