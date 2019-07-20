import 'package:flutter/material.dart';
import 'package:flutter_meals/models/category.dart';
import 'package:flutter_meals/models/meal.dart';
import 'package:flutter_meals/widgets/meal_list_item.dart';

class CategoryMeals extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> meals;

  const CategoryMeals({Key key, @required this.meals}) : super(key: key);

  @override
  _CategoryMealsState createState() => _CategoryMealsState();
}

class _CategoryMealsState extends State<CategoryMeals> {
  Category category;
  List<Meal> categoryMeals;

  bool _dataLoaded = false;
  void _removeMeal(String id) {
    setState(() {
      categoryMeals.removeWhere((m) => m.id == id);
    });
  }

  @override
  void didChangeDependencies() {
    if (!_dataLoaded) {
      // Can't use init state because of(context) calls are not available in init state
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, Category>;
      category = routeArgs['category'];
      categoryMeals = widget.meals
          .where((d) => d.categories.contains(category.id))
          .toList();
      this._dataLoaded = true;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: ListView.builder(
        itemCount: categoryMeals.length,
        itemBuilder: (ctx, index) => MealListItem(
          meal: categoryMeals[index],
          removeItem: _removeMeal,
        ),
      ),
    );
  }
}
