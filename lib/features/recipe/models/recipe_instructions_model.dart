import 'dart:convert';
import 'package:hive/hive.dart';

part 'recipe_instructions_model.g.dart';

List<RecipeInstructionsModel> recipeInstructionsModelFromJson(List<dynamic> data) => List<RecipeInstructionsModel>.from(data.map((x) => RecipeInstructionsModel.fromJson(x)));

String recipeInstructionsModelToJson(List<RecipeInstructionsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 5)
class RecipeInstructionsModel {
  @HiveField(0)
  String? name;
  @HiveField(1)
  List<StepModel>? steps;

  RecipeInstructionsModel({
    this.name,
    this.steps,
  });

  factory RecipeInstructionsModel.fromJson(Map<String, dynamic> json) => RecipeInstructionsModel(
    name: json["name"],
    steps: json["steps"] == null ? [] : List<StepModel>.from(json["steps"]!.map((x) => StepModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "steps": steps == null ? [] : List<dynamic>.from(steps!.map((x) => x.toJson())),
  };
}

@HiveType(typeId: 6)
class StepModel {
  @HiveField(0)
  List<Ent>? equipment;
  @HiveField(1)
  List<Ent>? ingredients;
  @HiveField(2)
  num? number;
  @HiveField(3)
  String? step;
  @HiveField(4)
  Length? length;

  StepModel({
    this.equipment,
    this.ingredients,
    this.number,
    this.step,
    this.length,
  });

  factory StepModel.fromJson(Map<String, dynamic> json) => StepModel(
    equipment: json["equipment"] == null ? [] : List<Ent>.from(json["equipment"]!.map((x) => Ent.fromJson(x))),
    ingredients: json["ingredients"] == null ? [] : List<Ent>.from(json["ingredients"]!.map((x) => Ent.fromJson(x))),
    number: json["number"],
    step: json["step"],
    length: json["length"] == null ? null : Length.fromJson(json["length"]),
  );

  Map<String, dynamic> toJson() => {
    "equipment": equipment == null ? [] : List<dynamic>.from(equipment!.map((x) => x.toJson())),
    "ingredients": ingredients == null ? [] : List<dynamic>.from(ingredients!.map((x) => x.toJson())),
    "number": number,
    "step": step,
    "length": length?.toJson(),
  };
}

@HiveType(typeId: 7)
class Ent {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? image;
  @HiveField(2)
  String? name;
  @HiveField(3)
  Length? temperature;

  Ent({
    this.id,
    this.image,
    this.name,
    this.temperature,
  });

  factory Ent.fromJson(Map<String, dynamic> json) => Ent(
    id: json["id"],
    image: json["image"],
    name: json["name"],
    temperature: json["temperature"] == null ? null : Length.fromJson(json["temperature"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "name": name,
    "temperature": temperature?.toJson(),
  };
}

@HiveType(typeId: 8)
class Length {
  @HiveField(0)
  num? number;
  @HiveField(1)
  String? unit;

  Length({
    this.number,
    this.unit,
  });

  factory Length.fromJson(Map<String, dynamic> json) => Length(
    number: json["number"],
    unit: json["unit"],
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "unit": unit,
  };
}
