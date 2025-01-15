import 'package:hive_ce/hive.dart';

class RecipeInstructionsEntity extends HiveObject {
  final String? name;

  final List<StepEntity>? steps;

  RecipeInstructionsEntity({
    this.name,
    this.steps,
  });
}

class StepEntity extends HiveObject {
  final List<EntEntity>? equipment;
  final List<EntEntity>? ingredients;
  final num? number;
  final String? step;
  final LengthEntity? length;

  StepEntity({
    this.equipment,
    this.ingredients,
    this.number,
    this.step,
    this.length,
  });
}

class EntEntity extends HiveObject {
  final int? id;
  final String? image;
  final String? name;
  final LengthEntity? temperature;

  EntEntity({
    this.id,
    this.image,
    this.name,
    this.temperature,
  });
}

class LengthEntity extends HiveObject {
  final num? number;
  final String? unit;

  LengthEntity({
    this.number,
    this.unit,
  });
}
