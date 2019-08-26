import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_shop/models/place.dart';
import 'package:flutter_shop/pages/map_page.dart';
import 'package:provider/provider.dart';

class PlaceDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final place = Provider.of<Place>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(place != null ? place.title : ''),
      ),
      body: Column(
        children: <Widget>[
          Container(
              height: 250,
              width: double.infinity,
              child: Image.file(
                File(place.imagePath),
                fit: BoxFit.cover,
                width: double.infinity,
              )),
          SizedBox(height: 10),
          Text(
            place.location != null ? place.location.address : '',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          SizedBox(height: 10),
          FlatButton(
            child: Text('View on map'),
            textColor: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => MapPage(
                    initialLocation:
                        place.location != null ? place.location : null,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
    ;
  }
}
