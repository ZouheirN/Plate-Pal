import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'recipe_instructions.g.dart';

@HiveType(typeId: 1)
class RecipeInstructionsEntity extends Equatable {
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final List<StepEntity>? steps;

  const RecipeInstructionsEntity({
    this.name,
    this.steps,
  });

  @override
  List<Object?> get props => [
        name,
        steps,
      ];
}

@HiveType(typeId: 2)
class StepEntity extends Equatable {
  @HiveField(0)
  final List<EntEntity>? equipment;
  @HiveField(1)
  final List<EntEntity>? ingredients;
  @HiveField(2)
  final num? number;
  @HiveField(3)
  final String? step;
  @HiveField(4)
  final LengthEntity? length;

  const StepEntity({
    this.equipment,
    this.ingredients,
    this.number,
    this.step,
    this.length,
  });

  @override
  List<Object?> get props => [
        equipment,
        ingredients,
        number,
        step,
        length,
      ];
}

@HiveType(typeId: 3)
class EntEntity extends Equatable {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? image;
  @HiveField(2)
  final String? name;
  @HiveField(3)
  final LengthEntity? temperature;

  const EntEntity({
    this.id,
    this.image,
    this.name,
    this.temperature,
  });

  @override
  List<Object?> get props => [
        id,
        image,
        name,
        temperature,
      ];
}

@HiveType(typeId: 4)
class LengthEntity extends Equatable {
  @HiveField(0)
  final num? number;
  @HiveField(1)
  final String? unit;

  const LengthEntity({
    this.number,
    this.unit,
  });

  @override
  List<Object?> get props => [
        number,
        unit,
      ];
}
