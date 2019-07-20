import 'package:flutter/material.dart';
import 'package:flutter_meals/models/category.dart';
import 'package:flutter_meals/pages/category_meals.dart';

class CategoryGridItem extends StatelessWidget {
  final Category category;

  const CategoryGridItem({Key key, @required this.category}) : super(key: key);

  _selectCategory(BuildContext context) {
    Navigator.of(context)
        .pushNamed(CategoryMeals.routeName, arguments: {'category': category});
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (_) => CategoryMeals(category: category),
    // ));
  }

  @override
  Widget build(BuildContext context) {
    var radius = BorderRadius.circular(15);
    return InkWell(
      // Gesture detector with ripple effect
      onTap: () => _selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: radius,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.title,
        ),
        decoration: BoxDecoration(
          borderRadius: radius,
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.7),
              category.color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }
}
