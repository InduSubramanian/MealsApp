import 'package:flutter/material.dart';

import '../models/meals.dart';
import '../widgets/meal_item.dart';

class FavouritesPage extends StatelessWidget {
  final List<Meals> favouriteMeals;
  FavouritesPage(this.favouriteMeals);

  @override
  Widget build(BuildContext context) {
    if (favouriteMeals.isEmpty) {
      return Center(
        child: Text('You have no favourites yet! - go add some!'),
      );
    } else {
      return ListView.builder(
        padding: EdgeInsets.all(10),
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favouriteMeals[index].id,
            title: favouriteMeals[index].title,
            affordability: favouriteMeals[index].affordability,
            complexity: favouriteMeals[index].complexity,
            duration: favouriteMeals[index].duration,
            imageUrl: favouriteMeals[index].imageUrl,
 
            // removeItem: _removeItem
          );
        },
        itemCount: favouriteMeals.length,
      );
    }
  }
}
