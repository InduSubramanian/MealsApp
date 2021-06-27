import 'package:flutter/material.dart';

import './categories_page.dart';
import './favourites_page.dart';
import '../widgets/main_drawer.dart';
import '../models/meals.dart';

class TabsPage extends StatefulWidget {
  final List<Meals> favouriteMeals;
  TabsPage(this.favouriteMeals);
  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  List<Map<String, Widget>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {'page': CategoriesPage(), 'title': Text('Categories')},
      {
        'page': FavouritesPage(widget.favouriteMeals),
        'title': Text('Favourites')
      },
    ];
    super.initState();
  }

  _selectPage(int index) {
    setState(() => _selectedPageIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: _pages[_selectedPageIndex]['title']),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Theme.of(context).accentColor,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.category),
              label: 'Categories'),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.star),
              label: 'Favourites'),
        ],
      ),
    );
  }
}
