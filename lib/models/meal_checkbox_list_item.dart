import 'dart:convert';

import 'package:project_test/models/listcheckboxbase_model.dart';

class MealCheckboxModel extends ListCheckboxBaseModel {
  MealCheckboxModel(id, name, {selected = false}) : super(id, name, selected);

  factory MealCheckboxModel.fromRawJson(String str) =>
      MealCheckboxModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MealCheckboxModel.fromJson(Map<String, dynamic> json) =>
      MealCheckboxModel(
        json["id"],
        json["name"],
        selected: json["selected"],
      );

  Map<String, dynamic> toJson() => super.toJson();
}
