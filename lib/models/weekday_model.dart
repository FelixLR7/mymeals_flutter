import 'dart:convert';

class WeekdayModel {
  final int id;
  final String name;

  WeekdayModel(this.id, this.name);

  factory WeekdayModel.fromRawJson(String str) =>
      WeekdayModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WeekdayModel.fromJson(Map<String, dynamic> json) =>
      WeekdayModel(json["id"], json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
