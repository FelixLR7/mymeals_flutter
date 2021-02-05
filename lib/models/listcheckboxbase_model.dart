import 'dart:convert';

class ListCheckboxBaseModel {
  final int id;
  final String name;
  bool selected;

  ListCheckboxBaseModel(this.id, this.name, this.selected);

  factory ListCheckboxBaseModel.fromRawJson(String str) =>
      ListCheckboxBaseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListCheckboxBaseModel.fromJson(Map<String, dynamic> json) =>
      ListCheckboxBaseModel(json["id"], json["name"], json["selected"]);

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "selected": selected};
}
