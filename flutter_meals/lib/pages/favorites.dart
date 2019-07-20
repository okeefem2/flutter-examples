import 'package:flutter/material.dart';
import 'package:flutter_meals/models/meal.dart';
import 'package:flutter_meals/widgets/meal_list_item.dart';

class Favorites extends StatelessWidget {
  static const routeName = '/favorites';
  final List<Meal> favoriteMeals;

  const Favorites({Key key, this.favoriteMeals}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return favoriteMeals.isNotEmpty
        ? ListView.builder(
            itemCount: favoriteMeals.length,
            itemBuilder: (ctx, index) => MealListItem(
              meal: favoriteMeals[index],
            ),
          )
        : Center(
            child: Text('No favorites yet, go forth and add some!'),
          );
  }
}
