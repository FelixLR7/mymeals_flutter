import 'dart:async';

import 'package:project_test/models/meal_model.dart';
import 'package:project_test/providers/meal_provider.dart';
import 'package:rxdart/rxdart.dart';

class MealsBloc {
  List<MealModel> _meals = [];
  final _mealsController = new BehaviorSubject<List<MealModel>>();
  final _mealProvider = new MealProvider();

  static final MealsBloc _instance = new MealsBloc._();

  Stream<List<MealModel>> get mealsStream => _mealsController.stream;

  Function(List<MealModel>) get mealsSink => _mealsController.sink.add;

  factory MealsBloc() {
    return _instance;
  }

  MealsBloc._();

  void dispose() {
    _mealsController?.close();
  }

  Future<bool> addMeal(MealModel meal) async {
    bool isCreated = await _mealProvider.createMeal(meal);

    if (isCreated) {
      _meals.add(meal);
      mealsSink(_meals);

      return true;
    }

    return false;
  }

  Future<bool> addExampleMeals(List<MealModel> meals) {}

  void loadMeals() async {
    await Future.delayed(Duration(seconds: 2));
    mealsSink(_meals);
  }
}
