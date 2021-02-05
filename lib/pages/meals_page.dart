import 'package:flutter/material.dart';
import 'package:project_test/bloc/meals_bloc.dart';
import 'package:project_test/models/meal_model.dart';
import 'package:project_test/widgets/drawer_widget.dart';
import 'package:project_test/widgets/newmealFAB_widget.dart';

class MealsPage extends StatelessWidget {
  static final routeName = 'meals';
  static final pageName = 'Comidas';

  const MealsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MealsBloc _mealsBloc = MealsBloc();
    _mealsBloc.loadMeals();

    return Scaffold(
      appBar: AppBar(
        title: Text(pageName),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print('buscar');
            },
          ),
          IconButton(
            icon: Icon(Icons.add_to_photos),
            onPressed: () {
              Navigator.pushNamed(context, 'examplemeals');
            },
          ),
        ],
      ),
      drawer: MenuWidget(),
      drawerEdgeDragWidth: MenuWidget.getDragWidth(context),
      body: Container(
        child: StreamBuilder(
          stream: _mealsBloc.mealsStream,
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: _list(snapshot.data),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: NewMealFABWidget(),
    );
  }

  List<Widget> _list(List<MealModel> data) {
    return data.map((element) {
      return Container(
        child: ListTile(
          title: Text(element.name),
        ),
      );
    }).toList();
  }
}
