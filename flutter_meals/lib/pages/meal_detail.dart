import 'package:flutter/material.dart';
import 'package:flutter_meals/data/dummy-recipes.dart';
import 'package:flutter_meals/models/meal.dart';

class MealDetail extends StatelessWidget {
  static const routeName = '/meal-detail';

  final Function favoriteMeal;
  final Function isFavorite;

  const MealDetail(
      {Key key, @required this.favoriteMeal, @required this.isFavorite})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final String id = routeArgs['id'];
    final bool showRemove = routeArgs['showRemove'];
    final Meal meal =
        DUMMY_MEALS.firstWhere((meal) => meal.id == id, orElse: () => null);

    final bool isFavoriteMeal = isFavorite(meal.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(isFavoriteMeal ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              favoriteMeal(meal);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            // Inside of the column, to have a listView, need to wrap it in a container with a fixed height
            // Because the column tries to have infinite height, and the listview needs to have a parent with
            // a fixed height
            buildSectionContainer(
                meal,
                context,
                ListView.builder(
                  itemCount: meal.ingredients.length,
                  itemBuilder: (ctx, index) => Card(
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Text(meal.ingredients[index]),
                    ),
                  ),
                )),
            buildSectionTitle(context, 'Recipe'),
            buildSectionContainer(
                meal,
                context,
                ListView.builder(
                  itemCount: meal.steps.length,
                  itemBuilder: (ctx, index) => Column(
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('# ${index + 1}'),
                        ),
                        title: Text(meal.steps[index]),
                      ),
                      Divider(),
                    ],
                  ),
                )),
          ],
        ),
      ),
      floatingActionButton: showRemove
          ? FloatingActionButton(
              child: Icon(Icons.delete),
              onPressed: () {
                // Pass the id back to delete it
                Navigator.of(context).pop(meal.id);
              },
            )
          : Container(),
    );
  }

  Container buildSectionContainer(
      Meal meal, BuildContext context, Widget sectionContent) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 250,
      width: 300,
      child: sectionContent,
    );
  }

  Container buildSectionTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(title, style: Theme.of(context).textTheme.title),
    );
  }
}
