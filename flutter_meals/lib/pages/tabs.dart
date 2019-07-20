import 'package:flutter/material.dart';
import 'package:flutter_meals/models/meal.dart';
import 'package:flutter_meals/pages/categories.dart';
import 'package:flutter_meals/widgets/main_drawer.dart';

import 'favorites.dart';

class Tabs extends StatefulWidget {
  final List<Meal> favoriteMeals;

  const Tabs({Key key, @required this.favoriteMeals}) : super(key: key);
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  List<Map<String, dynamic>> _pages;
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [
      {
        'widget': Categories(),
        'title': 'Categories',
      },
      {
        'widget': Favorites(
            favoriteMeals:
                widget.favoriteMeals), // In init state to access widget
        'title': 'Favorites',
      }
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Tabs on top
    // return DefaultTabController(
    //     length: 2,
    //     child: Scaffold(
    //       appBar: AppBar(
    //         bottom: TabBar(
    //           tabs: <Widget>[
    //             Tab(icon: Icon(Icons.category), text: 'Categories'),
    //             Tab(icon: Icon(Icons.star), text: 'Favorites'),
    //           ],
    //         ),
    //       ),
    //       body: TabBarView(
    //         children: <Widget>[
    //           Categories(),
    //           Favorites(),
    //         ],
    //       ),
    //     ));
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      drawer: Drawer(
        child: MainDrawer(),
      ),
      body: _pages[_selectedPageIndex]['widget'],
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).accentColor,
          currentIndex: _selectedPageIndex,
          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.category),
                title: Text('Categories')),
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.star),
                title: Text('Favorites')),
          ]),
    );
  }
}
