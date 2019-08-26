import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/auth_page.dart';
import 'package:flutter_shop/pages/orders_page.dart';
import 'package:flutter_shop/pages/place_form_page.dart';
import 'package:flutter_shop/pages/places_list_page.dart';
import 'package:flutter_shop/pages/user_products_page.dart';
import 'package:flutter_shop/services/auth_service.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: <Widget>[
        AppBar(
          title: Text('Hello'),
          automaticallyImplyLeading: false,
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.shop),
          title: Text('Shop'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/');
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.payment),
          title: Text('Orders'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(OrdersPage.route);
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.edit),
          title: Text('Products'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(UserProductsPage.route);
            // For one off custom route animations
            // Navigator.of(context).pushReplacement(
            //   CustomRoute(
            //     builder: (ctx) => UserProductsPage(),
            //   ),
            // );
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.done),
          title: Text('Log Out'),
          onTap: () {
            // To avoid open drawer scaffold teardown errors
            Navigator.of(context).pop();
            Provider.of<AuthService>(context).signOut();
            Navigator.of(context).pushReplacementNamed(AuthPage.route);
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.add_location),
          title: Text('Add Location'),
          onTap: () {
            // To avoid open drawer scaffold teardown errors
            Navigator.of(context).pushNamed(PlaceFormPage.route);
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.location_city),
          title: Text('Locations'),
          onTap: () {
            // To avoid open drawer scaffold teardown errors
            Navigator.of(context).pushReplacementNamed(PlacesListPage.route);
          },
        ),
      ],
    ));
  }
}
