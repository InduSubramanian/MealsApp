import 'package:flutter/material.dart';

import './dummy_data.dart';
import './pages/category_meal_page.dart';
import './pages/meal_detail_page.dart';
import './pages/filters_page.dart';
import './pages/tabs_page.dart';
import './models/meals.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'glutenFree': false,
    'lactoseFree': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meals> _availableMeals = DUMMY_MEALS;
  List<Meals> _favouriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(
      () {
        print('OldFilterCond');
        print(_filters);
        _filters = filterData;

        print('NewFilterCond');
        print(filterData);

        _availableMeals = DUMMY_MEALS.where(
          (meal) {
            if (meal.isGlutenFree && _filters['glutenFree']) {
              return true;
            }
            if (meal.isLactoseFree && _filters['lactoseFree']) {
              return true;
            }
            if (meal.isVegan && _filters['vegan']) {
              return true;
            }
            if (meal.isVegetarian && _filters['vegeatrian']) {
              return true;
            }
            return false;
          },
        ).toList();
      },
    );
  }

  void _toggleFavourite(String id) {
    final existingIndex =
        _favouriteMeals.indexWhere((favMeal) => favMeal.id == id);
    if (existingIndex >= 0) {
      setState(() {
        _favouriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favouriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == id));
      });
    }
  }

  bool _isFavourite(String id) {
    return _favouriteMeals.any((favMeal) => favMeal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Deli Meals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyText2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            headline6: TextStyle(
              fontFamily: 'RobotoCondensed',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            )),
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsPage(_favouriteMeals),
        CategoryMealPage.routeName: (ctx) => CategoryMealPage(_availableMeals),
        MealDetailPage.routeName: (ctx) =>
            MealDetailPage(_toggleFavourite, _isFavourite),
        FiltersPage.routeName: (ctx) => FiltersPage(_filters, _setFilters),
      },

      onGenerateRoute: (settings) {
        print(settings.name);
        return MaterialPageRoute(
          builder: (ctx) => TabsPage(_favouriteMeals),
        );
      },
      //If nothing works, this will be shown
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => TabsPage(_favouriteMeals),
        );
      },
    );
  }
}
