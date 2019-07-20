import 'package:flutter/material.dart';
import 'package:flutter_meals/widgets/main_drawer.dart';

class Filters extends StatefulWidget {
  static const routeName = '/filters';

  final Function setFilters;
  final Map<String, bool> filters;

  const Filters({Key key, @required this.setFilters, @required this.filters})
      : super(key: key);

  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.filters['gluten'];
    _lactoseFree = widget.filters['lactose'];
    _vegan = widget.filters['vegan'];
    _vegetarian = widget.filters['vegetarian'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Filters'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final filters = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                };
                widget.setFilters(filters);
              },
            ),
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Text('Adjust your meal selection',
                  style: Theme.of(context).textTheme.title),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  buildSwitchListTile(_glutenFree, 'Gluten-free',
                      () => _glutenFree = !_glutenFree),
                  buildSwitchListTile(_vegan, 'Vegan', () => _vegan = !_vegan),
                  buildSwitchListTile(_vegetarian, 'Vegetarian',
                      () => _vegetarian = !_vegetarian),
                  buildSwitchListTile(_lactoseFree, 'Lactose-free',
                      () => _lactoseFree = !_lactoseFree),
                ],
              ),
            )
          ],
        ));
  }

  SwitchListTile buildSwitchListTile(
      bool switchValue, String label, Function setFn) {
    return SwitchListTile(
      title: Text(
        label,
      ),
      value: switchValue,
      subtitle: Text('Include $label meals'),
      onChanged: (value) {
        setState(setFn);
      },
    );
  }
}
