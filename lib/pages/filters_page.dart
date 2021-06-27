import '../widgets/main_drawer.dart';

import 'package:flutter/material.dart';

class FiltersPage extends StatefulWidget {
  static const routeName = '/filters';

  final Function _saveFilters;
  final Map<String, bool> _currentFilters;

  FiltersPage(this._currentFilters, this._saveFilters);

  @override
  _FiltersPageState createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  var _glutenFree = false;
  var _lactoseFree = false;
  var _vegan = false;
  var _vegetarian = false;

  @override
  void initState() {
    _glutenFree = widget._currentFilters['glutenFree'];
    _lactoseFree = widget._currentFilters['lactoseFree'];
    _vegan = widget._currentFilters['vegan'];
    _vegetarian = widget._currentFilters['vegetarian'];

    super.initState();
  }

  Widget buildSwitchTile(
      String title, String description, var current, Function update) {
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(description),
        value: current,
        onChanged: update);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtered Meals'),
      ),
      drawer: MainDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          final newfilters = {
            'glutenFree': _glutenFree,
            'lactoseFree': _lactoseFree,
            'vegan': _vegan,
            'vegetarian': _vegetarian,
          };

          widget._saveFilters(newfilters);
        },
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              'Adjust your meal selection',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                buildSwitchTile(
                  'Gluten-free',
                  'Only include gluten-free meals',
                  _glutenFree,
                  (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                    });
                  },
                ),
                buildSwitchTile(
                  'Lacotse-free',
                  'Only include lactose-free meals',
                  _lactoseFree,
                  (newValue) {
                    setState(() {
                      _lactoseFree = newValue;
                    });
                  },
                ),
                buildSwitchTile(
                  'Vegan',
                  'Only include Vegan meals',
                  _vegan,
                  (newValue) {
                    setState(() {
                      _vegan = newValue;
                    });
                  },
                ),
                buildSwitchTile(
                  'Vegetarian',
                  'Only include vegetarian meals',
                  _vegetarian,
                  (newValue) {
                    setState(() {
                      _vegetarian = newValue;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
