import 'dart:convert';

import 'package:project_test/models/category_model.dart';
import 'package:project_test/models/schedule_model.dart';
import 'package:project_test/models/weekday_model.dart';

class MealModel {
  final int id;
  String name;
  CategoryModel category;
  List<WeekdayModel> weekdays;
  List<ScheduleModel> schedules;

  MealModel({this.id, this.name, this.category, this.weekdays, this.schedules});

  factory MealModel.fromRawJson(String str) =>
      MealModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MealModel.fromJson(Map<String, dynamic> json) => MealModel(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        weekdays: List<WeekdayModel>.from(
            json["weekdays"].map((x) => WeekdayModel.fromJson(x))),
        schedules: List<ScheduleModel>.from(
            json["schedules"].map((x) => ScheduleModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category_id": category.id,
        "weekdays": List<int>.from(weekdays.map((x) => x.id)),
        "schedules": List<int>.from(schedules.map((x) => x.id))
      };
}
