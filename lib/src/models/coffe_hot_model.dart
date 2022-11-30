// To parse this JSON data, do
//
//     final coffeHotModel = coffeHotModelFromJson(jsonString);

// ignore_for_file: unnecessary_null_in_if_null_operators

import 'dart:convert';

List<CoffeHotModel> coffeHotModelFromJson(String str) =>
    List<CoffeHotModel>.from(
        json.decode(str).map((x) => CoffeHotModel.fromJson(x)));

String coffeHotModelToJson(List<CoffeHotModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CoffeHotModel {
  CoffeHotModel({
    required this.title,
    required this.description,
    required this.ingredients,
    required this.image,
    required this.id,
  });

  String title;
  String description;
  List<String> ingredients;
  String? image;
  int id;

  factory CoffeHotModel.fromJson(Map<String, dynamic> json) => CoffeHotModel(
        title: json["title"],
        description: json["description"],
        ingredients: List<String>.from(json["ingredients"].map((x) => x)),
        image: json["image"] ?? null,
        id: int.parse(json["id"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "ingredients": List<dynamic>.from(ingredients.map((x) => x)),
        "image": image ?? null,
        "id": id,
      };
}
