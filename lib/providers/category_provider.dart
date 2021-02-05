import 'dart:convert';

import 'package:project_test/models/category_model.dart';
import 'package:project_test/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class CategoryProvider extends BaseProvider {
  String mealUrl = 'meal';
  String token;

  CategoryProvider() : super() {
    headers['Authorization'] = "Bearer " + BaseProvider.preferences.token;
  }

  Future<bool> saveCategories(List<CategoryModel> categories) async {
    final apiRes = await http.post(
      BaseProvider.url + mealUrl,
      headers: headers,
      // body: categories.toRawJson(),
    );

    final Map<String, dynamic> jsonRes = jsonDecode(apiRes.body);

    print(jsonRes);

    return jsonRes['success'] ?? false;
  }

  Future<List<CategoryModel>> loadAllCategories() async {
    await Future.delayed(Duration(seconds: 2));
    return [
      CategoryModel(1, 'Carne'),
      CategoryModel(2, 'Pescado'),
      CategoryModel(3, 'Pasta'),
    ];
  }

  Future<List<CategoryModel>> loadUserCategories() async {
    await Future.delayed(Duration(seconds: 2));
    return [
      CategoryModel(1, 'Carne User'),
      CategoryModel(2, 'Pescado User'),
      CategoryModel(3, 'Pasta User'),
    ];
  }
}
