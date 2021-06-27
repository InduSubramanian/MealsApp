//Details about one specific meal - Steps and Instructions

import 'package:MealsApp/dummy_data.dart';

import 'package:flutter/material.dart';

class MealDetailPage extends StatelessWidget {
  static const routeName = '/meal-detail';
  final Function toggleFavourite;
  final Function isFavourite;
  MealDetailPage(this.toggleFavourite, this.isFavourite);

  Widget buildSectionTitle(BuildContext context, title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Text(title, style: Theme.of(context).textTheme.headline6),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
        height: 200,
        width: 320,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final routeArg =
        ModalRoute.of(context).settings.arguments as Map<String, String>;

    final mealid = routeArg['id'];

    final selectedMeal = DUMMY_MEALS.firstWhere((meals) => mealid == meals.id);

    print(selectedMeal.ingredients);
    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedMeal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.scaleDown,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            //Container to hold the List View
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).accentColor),
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    child: Text(
                      selectedMeal.ingredients[index],
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                },
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            //Builder to make the SectionTitle
            buildSectionTitle(context, 'Steps'),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${index + 1}'),
                      ),
                      title: Text(
                        selectedMeal.steps[index],
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Divider(
                      thickness: 1.5,
                    ),
                  ],
                ),
                itemCount: selectedMeal.steps.length,
              ),
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //     onPressed: () {
      //       Navigator.of(context).pop(mealid);
      //     },
      //     child: Icon(Icons.delete),
      //     backgroundColor: Theme.of(context).primaryColor),
      floatingActionButton: FloatingActionButton(
          child:
              isFavourite(mealid) ? Icon(Icons.star) : Icon(Icons.star_outline),
          onPressed: () => toggleFavourite(mealid),
          backgroundColor: Theme.of(context).primaryColor),
    );
  }
}
