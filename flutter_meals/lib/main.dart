import 'package:flutter/material.dart';
import 'package:flutter_meals/data/dummy-recipes.dart';
import 'package:flutter_meals/pages/categories.dart';
import 'package:flutter_meals/pages/category_meals.dart';
import 'package:flutter_meals/pages/meal_detail.dart';
import 'package:flutter_meals/pages/tabs.dart';

import 'models/meal.dart';
import 'pages/favorites.dart';
import 'pages/filters.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _favoriteMeals = [];

  List<Meal> _meals = DUMMY_MEALS;

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      print(filterData);
      _meals = DUMMY_MEALS.where((meal) {
        return (_filters['gluten'] && meal.isGlutenFree) ||
            (_filters['vegan'] && meal.isVegan) ||
            (_filters['vegetarian'] && meal.isVegetarian) ||
            (_filters['lactose'] && meal.isLactoseFree);
      }).toList();
    });
  }

  void _favoriteMeal(Meal meal) {
    setState(() {
      if (!_isFavoriteMeal(meal.id)) {
        _favoriteMeals.add(meal);
      } else {
        _favoriteMeals.removeWhere((m) => m.id == meal.id);
      }
      print(_favoriteMeals);
    });
  }

  bool _isFavoriteMeal(String id) {
    return _favoriteMeals.any((m) => m.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deli Meals',
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
        primarySwatch: Colors.purple,
        accentColor: Colors.tealAccent,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              body2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              title: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      // Home page/entrypoint of the app
      // home: Categories(),
      initialRoute: '/', // defaults to '/'
      routes: {
        '/': (ctx) =>
            Tabs(favoriteMeals: _favoriteMeals), // Same as defining home above
        CategoryMeals.routeName: (ctx) => CategoryMeals(meals: _meals),
        MealDetail.routeName: (ctx) => MealDetail(
              favoriteMeal: _favoriteMeal,
              isFavorite: _isFavoriteMeal,
            ),
        Filters.routeName: (ctx) =>
            Filters(setFilters: _setFilters, filters: _filters),
      },
      // Could be used for dynamic routes
      // onGenerateRoute: (settings) =>
      //     MaterialPageRoute(builder: (ctx) => Categories()),
      // When no other routes match the named route sent
      onUnknownRoute: (settings) =>
          MaterialPageRoute(builder: (ctx) => Categories()),
    );
  }
}
