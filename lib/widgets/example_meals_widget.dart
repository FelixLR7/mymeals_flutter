import 'package:flutter/material.dart';

import 'package:project_test/models/meal_model.dart';
import 'package:project_test/providers/meal_provider.dart';
import 'package:project_test/widgets/checkbox_list_widget.dart';

class ExampleMealsWidget extends StatefulWidget {
  Function saveExampleMealsCallback;

  ExampleMealsWidget({Key key, @required this.saveExampleMealsCallback})
      : super(key: key);

  @override
  _ExampleMealsWidgetState createState() =>
      _ExampleMealsWidgetState(saveExampleMealsCallback);
}

class _ExampleMealsWidgetState extends State<ExampleMealsWidget> {
  List<MealModel> _mealsList = [];
  Function saveExampleMealsCallback;
  List<int> _selectedMeals;
  _ExampleMealsWidgetState(this.saveExampleMealsCallback);

  @override
  void initState() {
    super.initState();
    initializeList();
    print('después init');
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          (_mealsList.isEmpty) ? _loading() : _createList(),
          RaisedButton(
            child: Text('Guardar'),
            onPressed: () {
              // final selectedMeals = _mealsList.where((meal) => meal.selected);
              // final ids = selectedMeals.map((meal) => meal.id).toList();
              // print(ids);
              // MealProvider mealProvider = new MealProvider();

              saveExampleMealsCallback(true);
            },
          ),
        ],
      ),
    );
  }

  Widget _loading() {
    return Expanded(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _createList() {
    return CheckboxListWidget(
      list: _mealsList,
      title: 'Lista test',
      error: 'Error test',
      callback: setSelectedMeals,
    );
  }

  void initializeList() async {
    MealProvider mealProvider = new MealProvider();
    _mealsList = await mealProvider.loadExampleMeals();
    print('después inside init');
    setState(() {});
  }

  setSelectedMeals(listSeletectedMeals) {
    setState(() {
      _selectedMeals = listSeletectedMeals;
    });
  }
}
