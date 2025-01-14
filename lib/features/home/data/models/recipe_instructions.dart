import 'dart:convert';

import 'package:platepal/features/home/domain/entities/recipe_instructions.dart';

List<RecipeInstructionsModel> recipeInstructionsModelFromJson(
        List<dynamic> data) =>
    List<RecipeInstructionsModel>.from(
        data.map((x) => RecipeInstructionsModel.fromJson(x)));

String recipeInstructionsModelToJson(List<RecipeInstructionsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecipeInstructionsModel extends RecipeInstructionsEntity {
  const RecipeInstructionsModel({
    super.name,
    super.steps,
  });

  factory RecipeInstructionsModel.fromJson(Map<String, dynamic> json) =>
      RecipeInstructionsModel(
        name: json["name"],
        steps: json["steps"] == null
            ? []
            : List<StepModel>.from(
                json["steps"]!.map((x) => StepModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() {
    List<StepModel>? steps = this.steps as List<StepModel>?;

    return {
      "name": name,
      "steps":
          steps == null ? [] : List<dynamic>.from(steps.map((x) => x.toJson())),
    };
  }
}

class StepModel extends StepEntity {
  const StepModel({
    super.equipment,
    super.ingredients,
    super.number,
    super.step,
    super.length,
  });

  factory StepModel.fromJson(Map<String, dynamic> json) => StepModel(
        equipment: json["equipment"] == null
            ? []
            : List<EntModel>.from(
                json["equipment"]!.map((x) => EntModel.fromJson(x))),
        ingredients: json["ingredients"] == null
            ? []
            : List<EntModel>.from(
                json["ingredients"]!.map((x) => EntModel.fromJson(x))),
        number: json["number"],
        step: json["step"],
        length: json["length"] == null
            ? null
            : LengthModel.fromJson(json["length"]),
      );

  Map<String, dynamic> toJson() {
    List<EntModel>? equipment = this.equipment as List<EntModel>?;
    List<EntModel>? ingredients = this.ingredients as List<EntModel>?;
    LengthModel? length = this.length as LengthModel?;

    return {
      "equipment": equipment == null
          ? []
          : List<dynamic>.from(equipment.map((x) => x.toJson())),
      "ingredients": ingredients == null
          ? []
          : List<dynamic>.from(ingredients.map((x) => x.toJson())),
      "number": number,
      "step": step,
      "length": length?.toJson(),
    };
  }
}

class EntModel extends EntEntity {
  const EntModel({
    super.id,
    super.image,
    super.name,
    super.temperature,
  });

  factory EntModel.fromJson(Map<String, dynamic> json) => EntModel(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        temperature: json["temperature"] == null
            ? null
            : LengthModel.fromJson(json["temperature"]),
      );

  Map<String, dynamic> toJson() {
    LengthModel temperature = this.temperature as LengthModel;

    return {
      "id": id,
      "image": image,
      "name": name,
      "temperature": temperature.toJson(),
    };
  }
}

class LengthModel extends LengthEntity {
  const LengthModel({
    super.number,
    super.unit,
  });

  factory LengthModel.fromJson(Map<String, dynamic> json) => LengthModel(
        number: json["number"],
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "unit": unit,
      };
}
