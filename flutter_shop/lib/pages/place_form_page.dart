import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_shop/models/place.dart';
import 'package:flutter_shop/services/places_service.dart';
import 'package:flutter_shop/widgets/app_drawer.dart';
import 'package:flutter_shop/widgets/image_input.dart';
import 'package:flutter_shop/widgets/location_input.dart';
import 'package:provider/provider.dart';

class PlaceFormPage extends StatefulWidget {
  static const route = '/place-form';
  @override
  _PlaceFormPageState createState() => _PlaceFormPageState();
}

class _PlaceFormPageState extends State<PlaceFormPage> {
  final _titleController = TextEditingController();
  File _image;
  PlaceLocation _location;

  void _selectImage(File image) {
    // Since no ui change needed when this is updated no need for set state
    _image = image;
  }

  void _selectLocation({double lat, double long}) async {
    _location = await PlaceLocation.fromLatLng(lat: lat, long: long);
  }

  void _save() {
    if (_titleController.text.isEmpty || _image == null) return;
    Provider.of<PlacesService>(context)
        .addPlace(_titleController.text, _image, _location);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Add Place'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _save,
          ),
        ],
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween, // Not needed due to the expanded widget within
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    // Normally would use form, but skipping for brevity
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      controller: _titleController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(onSelectImage: _selectImage),
                    SizedBox(
                      height: 10,
                    ),
                    LocationInput(onSelectLocation: _selectLocation),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            onPressed: _save,
            elevation: 0,
            color: Theme.of(context).accentColor,
            materialTapTargetSize: MaterialTapTargetSize
                .shrinkWrap, // Remove extra margin aroun button
          )
        ],
      ),
    );
    ;
  }
}
