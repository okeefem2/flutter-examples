import 'package:flutter/material.dart';
import 'package:flutter_shop/helpers/custom_route.dart';
import 'package:flutter_shop/pages/auth_page.dart';
import 'package:flutter_shop/pages/cart_page.dart';
import 'package:flutter_shop/pages/home_page.dart';
import 'package:flutter_shop/pages/map_page.dart';
import 'package:flutter_shop/pages/orders_page.dart';
import 'package:flutter_shop/pages/place_form_page.dart';
import 'package:flutter_shop/pages/places_detail_page.dart';
import 'package:flutter_shop/pages/places_list_page.dart';
import 'package:flutter_shop/pages/product_detail_page.dart';
import 'package:flutter_shop/pages/product_overview_page.dart';
import 'package:flutter_shop/pages/user_products_page.dart';
import 'package:flutter_shop/services/auth_service.dart';
import 'package:flutter_shop/services/cart_service.dart';
import 'package:flutter_shop/services/orders_service.dart';
import 'package:flutter_shop/services/places_service.dart';
import 'package:flutter_shop/services/products_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'pages/product_form_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CartService>.value(
          value: CartService(),
        ),
        Provider<OrdersService>.value(
          value: OrdersService(),
        ),
        Provider<ProductsService>.value(
          value: ProductsService(),
        ),
        Provider<AuthService>.value(
          value: AuthService(),
        ),
        Provider<PlacesService>.value(
          value: PlacesService(),
        ),
        StreamProvider<FirebaseUser>.value(
          value: FirebaseAuth.instance.onAuthStateChanged,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        title: 'Shop',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.green,
          accentColor: Colors.orangeAccent,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.iOS: CustomPageTransitionBuilder(),
            TargetPlatform.android: CustomPageTransitionBuilder(),
          }),
          // textTheme: ThemeData.light().textTheme.copyWith(
          //       body1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
          //       body2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
          //       title: TextStyle(
          //         fontFamily: 'RobotoCondensed',
          //         fontSize: 20,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
        ),
        // Home page/entrypoint of the app
        // home: Categories(),
        initialRoute: '/', // defaults to '/'
        routes: {
          '/': (ctx) => HomePage(), // Same as defining home above
          ProductDetailPage.route: (ctx) => ProductDetailPage(),
          CartPage.route: (ctx) => CartPage(),
          OrdersPage.route: (ctx) => OrdersPage(),
          UserProductsPage.route: (ctx) => UserProductsPage(),
          UserProductsPage.route: (ctx) => UserProductsPage(),
          ProductFormPage.route: (ctx) => ProductFormPage(),
          PlaceFormPage.route: (ctx) => PlaceFormPage(),
          PlacesListPage.route: (ctx) => PlacesListPage(),
          PlacesDetailPage.route: (ctx) => PlacesDetailPage(),
          MapPage.route: (ctx) => MapPage(),
          AuthPage.route: (ctx) => AuthPage(),
        },
        // Could be used for dynamic routes
        // onGenerateRoute: (settings) =>
        //     MaterialPageRoute(builder: (ctx) => Categories()),
        // When no other routes match the named route sent
        onUnknownRoute: (settings) =>
            MaterialPageRoute(builder: (ctx) => ProductOverviewPage()),
      ),
    );
  }
}
