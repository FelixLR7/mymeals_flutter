import 'dart:convert';

class ScheduleModel {
  final int id;
  final String name;

  ScheduleModel(this.id, this.name);

  factory ScheduleModel.fromRawJson(String str) =>
      ScheduleModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ScheduleModel.fromJson(Map<String, dynamic> json) =>
      ScheduleModel(json["id"], json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
