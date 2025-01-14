import 'package:equatable/equatable.dart';

class RandomRecipesEntity extends Equatable {
  final List<RecipeEntity>? recipes;

  const RandomRecipesEntity({
    this.recipes,
  });

  @override
  List<Object?> get props => [
        recipes,
      ];
}

class RecipeEntity extends Equatable {
  final int? id;
  final String? title;
  final String? image;
  final int? servings;
  final int? readyInMinutes;
  final int? cookingMinutes;
  final int? preparationMinutes;
  final bool? cheap;
  final bool? dairyFree;
  final bool? glutenFree;
  final bool? vegan;
  final bool? vegetarian;
  final List<String>? dishTypes;
  final List<ExtendedIngredientsEntity>? extendedIngredients;
  final String? summary;
  final String? sourceUrl;

  const RecipeEntity({
    this.id,
    this.title,
    this.image,
    this.servings,
    this.readyInMinutes,
    this.cookingMinutes,
    this.preparationMinutes,
    this.cheap,
    this.dairyFree,
    this.glutenFree,
    this.vegan,
    this.vegetarian,
    this.dishTypes,
    this.extendedIngredients,
    this.summary,
    this.sourceUrl,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        image,
        servings,
        readyInMinutes,
        cookingMinutes,
        preparationMinutes,
        cheap,
        dairyFree,
        glutenFree,
        vegan,
        vegetarian,
        dishTypes,
        extendedIngredients,
        summary,
        sourceUrl,
      ];
}

class ExtendedIngredientsEntity extends Equatable {
  final String? aisle;
  final double? amount;
  final String? consistency;
  final String? image;
  final MeasuresEntity? measures;
  final List<String>? meta;
  final String? name;
  final String? original;
  final String? originalName;
  final String? unit;

  const ExtendedIngredientsEntity({
    this.aisle,
    this.amount,
    this.consistency,
    this.image,
    this.measures,
    this.meta,
    this.name,
    this.original,
    this.originalName,
    this.unit,
  });

  @override
  List<Object?> get props => [
        aisle,
        amount,
        consistency,
        image,
        measures,
        meta,
        name,
        original,
        originalName,
        unit,
      ];
}

class MeasuresEntity extends Equatable {
  final MetricEntity? metric;
  final UsEntity? us;

  const MeasuresEntity({
    this.metric,
    this.us,
  });

  @override
  List<Object?> get props => [
        metric,
        us,
      ];
}

class MetricEntity extends Equatable {
  final double? amount;
  final String? unitShort;
  final String? unitLong;

  const MetricEntity({
    this.amount,
    this.unitShort,
    this.unitLong,
  });

  @override
  List<Object?> get props => [
        amount,
        unitShort,
        unitLong,
      ];
}

class UsEntity extends Equatable {
  final double? amount;
  final String? unitShort;
  final String? unitLong;

  const UsEntity({
    this.amount,
    this.unitShort,
    this.unitLong,
  });

  @override
  List<Object?> get props => [
        amount,
        unitShort,
        unitLong,
      ];
}
