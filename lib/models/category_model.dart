import 'dart:convert';

class CategoryModel {
  final int id;
  final String name;

  CategoryModel(this.id, this.name);

  factory CategoryModel.fromRawJson(String str) =>
      CategoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      CategoryModel(json["id"], json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
