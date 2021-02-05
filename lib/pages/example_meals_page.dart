import 'package:flutter/material.dart';
import 'package:project_test/providers/meal_provider.dart';
import 'package:project_test/widgets/checkbox_list_widget.dart';

class ExampleMealsPage extends StatefulWidget {
  static final routeName = 'examplemeals';
  static final pageName = 'Comidas de ejemplo';

  ExampleMealsPage({Key key}) : super(key: key);

  @override
  _ExampleMealsPageState createState() => _ExampleMealsPageState();
}

class _ExampleMealsPageState extends State<ExampleMealsPage> {
  List<int> _selectedIds = [];

  @override
  Widget build(BuildContext context) {
    MealProvider mealProvider = new MealProvider();

    return Scaffold(
      appBar: AppBar(
        title: Text(ExampleMealsPage.pageName),
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: mealProvider.loadExampleMeals(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return CheckboxListWidget(
                  list: snapshot.data,
                  error: 'Tienes que seleccionar al menos una categoría',
                  callback: setSelectedIds,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
      floatingActionButton: _addMealsFAB(),
    );
  }

  _addMealsFAB() {
    return FloatingActionButton.extended(
      label: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(Icons.save),
          ),
          Text('Guardar'),
        ],
      ),
      onPressed: _selectedIds.isNotEmpty ? _addMeals : null,
      backgroundColor: _selectedIds.isNotEmpty ? Colors.blue : Colors.grey,
    );
  }

  setSelectedIds(idsList) {
    setState(() {
      _selectedIds = idsList;
    });
  }

  void _addMeals() {}
}
