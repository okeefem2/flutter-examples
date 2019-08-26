import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_shop/models/place.dart';
import 'package:flutter_shop/pages/places_detail_page.dart';
import 'package:provider/provider.dart';

class PlacesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var places = Provider.of<List<Place>>(context);
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (ctx, i) => ListTile(
        leading: CircleAvatar(
          backgroundImage: FileImage(File(places[i].imagePath)),
        ),
        title: Text(places[i].title),
        subtitle: Text(places[i].location != null
            ? places[i].location.address
            : 'Not Set'),
        onTap: () {
          Navigator.of(context)
              .pushNamed(PlacesDetailPage.route, arguments: places[i].id);
        },
      ),
    );
  }
}
