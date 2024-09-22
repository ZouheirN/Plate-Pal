import 'dart:convert';

List<RecipeInstructionsModel> recipeInstructionsModelFromJson(List<dynamic> data) => List<RecipeInstructionsModel>.from(data.map((x) => RecipeInstructionsModel.fromJson(x)));

String recipeInstructionsModelToJson(List<RecipeInstructionsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecipeInstructionsModel {
  String? name;
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

class StepModel {
  List<Ent>? equipment;
  List<Ent>? ingredients;
  int? number;
  String? step;
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

class Ent {
  int? id;
  String? image;
  String? name;
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

class Length {
  int? number;
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
