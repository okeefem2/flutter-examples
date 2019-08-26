import 'package:flutter/material.dart';
import 'package:flutter_shop/helpers/location_helper.dart';
import 'package:flutter_shop/pages/map_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectLocation;

  const LocationInput({Key key, this.onSelectLocation}) : super(key: key);
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  void _showPreview({lat, long}) {
    setState(() {
      _previewImageUrl =
          LocationHelper.generateLocationPreviewImage(lat: lat, long: long);
    });
  }

  Future<void> _getCurrentLocation() async {
    final LocationData location = await Location().getLocation();
    _showPreview(lat: location.latitude, long: location.longitude);
    widget.onSelectLocation(lat: location.latitude, long: location.longitude);
  }

  Future<void> _selectLocation() async {
    final LatLng selectedLocation =
        await Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (ctx) => MapPage(
        allowSelection: true,
      ),
    ));
    if (selectedLocation == null) return;
    _showPreview(
        lat: selectedLocation.latitude, long: selectedLocation.longitude);
    widget.onSelectLocation(
        lat: selectedLocation.latitude, long: selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 150,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          width: double.infinity,
          child: _previewImageUrl == null
              ? Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.my_location),
              label: Text('Current Location'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _getCurrentLocation,
            ),
            FlatButton.icon(
              icon: Icon(Icons.map),
              label: Text('Select On Map'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _selectLocation,
            )
          ],
        )
      ],
    );
  }
}
