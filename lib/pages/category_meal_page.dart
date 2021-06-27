//Displaying meals under on category

import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';

import '../models/meals.dart';

class CategoryMealPage extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meals> availableMeals;

  CategoryMealPage(this.availableMeals);

  @override
  _CategoryMealPageState createState() => _CategoryMealPageState();
}

class _CategoryMealPageState extends State<CategoryMealPage> {
  String categoryTitle;
  List<Meals> displayedMeals;
  bool _loadedInitData = false;

  @override
  //Whenever like. it is called before build and different from initState cause it gets context.
  void didChangeDependencies() {
    //This is executed everytime widget tree gets rebuild so everytime build is called, unlike initState
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      final String categoryId = routeArgs['id'];
      categoryTitle = routeArgs['title'];
      displayedMeals = widget.availableMeals
          .where(
            (meal) => meal.categories.contains(categoryId),
          )
          .toList();

      _loadedInitData = true;
    }

    super.didChangeDependencies();
  }

  // _removeItem(mealId) {
  //   print(mealId);
  //   setState(() {
  //     displayedMeals.removeWhere((meal) => meal.id == mealId);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    //How to extract the data from after routing
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            affordability: displayedMeals[index].affordability,
            complexity: displayedMeals[index].complexity,
            duration: displayedMeals[index].duration,
            imageUrl: displayedMeals[index].imageUrl,
            // removeItem: _removeItem
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
