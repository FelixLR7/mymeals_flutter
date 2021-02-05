import 'dart:convert';

import 'package:project_test/models/meal_checkbox_list_item.dart';
import 'package:project_test/providers/base_provider.dart';
import 'package:http/http.dart' as http;

import 'package:project_test/models/meal_model.dart';

///
class MealProvider extends BaseProvider {
  String mealUrl = 'meal';
  String exampleMealsUrl = 'examplemeals';
  String token;

  MealProvider() : super() {
    headers['Authorization'] = "Bearer " + BaseProvider.preferences.token;
  }

  Future<List<MealModel>> loadExampleMeals() async {
    await Future.delayed(Duration(seconds: 2));
    return [
      MealModel(id: 1, name: 'Macarrones con atún'),
      MealModel(id: 2, name: 'Macarrones con chorizo'),
      MealModel(id: 3, name: 'Macarrones carbonara'),
    ];
  }

  Future<bool> saveExampleMeals(List<int> meals) async {
    final apiRes = await http.post(BaseProvider.url + exampleMealsUrl,
        headers: headers, body: meals);
  }

  Future<bool> createMeal(MealModel meal) async {
    final apiRes = await http.post(
      BaseProvider.url + mealUrl,
      headers: headers,
      body: meal.toRawJson(),
    );

    final Map<String, dynamic> jsonRes = jsonDecode(apiRes.body);

    return jsonRes['success'] ?? false;
  }
}
