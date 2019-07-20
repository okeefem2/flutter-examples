import 'package:flutter/material.dart';
import 'package:flutter_meals/data/dummy-categories.dart';
import 'package:flutter_meals/widgets/category_grid_item.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // margin: EdgeInsets.only(top: 50.0),
        child: GridView.builder(
          padding: const EdgeInsets.all(25.0),
          itemCount: DUMMY_CATEGORIES.length,
          // A sliver is a scrollable widget
          // Creates number of columns to fit the area given
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent:
                200.0, // Max size of a column created in the grid
            childAspectRatio: 3 / 2, // ratio of width to height
            crossAxisSpacing: 20, // Spacing between grid elements
            mainAxisSpacing: 20,
          ),
          itemBuilder: (context, index) => CategoryGridItem(
            category: DUMMY_CATEGORIES[index],
          ),
        ),
      ),
    );
  }
}
