import 'package:flutter/material.dart';
import 'package:project_test/pages/meal_page.dart';

class NewMealFABWidget extends StatelessWidget {
  const NewMealFABWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.pushNamed(context, MealPage.routeName);
      },
    );
  }
}
