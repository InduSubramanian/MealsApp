//How one category will look!

import 'package:flutter/material.dart';

import '../pages/category_meal_page.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final Color color;
  final String title;

  CategoryItem(this.id, this.title, this.color);

  //NAVIGATE TO MEAL PAGE WHEN CLICK ON CARD
  //How? Using predefined routes and addition of arguments
  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CategoryMealPage.routeName,
      arguments: {'id': id, 'title': title},
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [color.withOpacity(0.7), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
