import 'package:equatable/equatable.dart';

class RecipeInstructionsEntity extends Equatable {
  final String? name;
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

class StepEntity extends Equatable {
  final List<EntEntity>? equipment;
  final List<EntEntity>? ingredients;
  final num? number;
  final String? step;
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

class EntEntity extends Equatable {
  final int? id;
  final String? image;
  final String? name;
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

class LengthEntity extends Equatable {
  final num? number;
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
