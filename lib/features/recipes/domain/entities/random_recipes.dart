import 'package:hive_ce/hive.dart';

class RandomRecipesEntity {
  final List<RecipeEntity>? recipes;

  const RandomRecipesEntity({
    this.recipes,
  });
}

class RecipeEntity extends HiveObject {
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

  RecipeEntity({
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
}

class ExtendedIngredientsEntity extends HiveObject {
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

  ExtendedIngredientsEntity({
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
}

class MeasuresEntity extends HiveObject {
  final MetricEntity? metric;
  final UsEntity? us;

  MeasuresEntity({
    this.metric,
    this.us,
  });
}

class MetricEntity extends HiveObject {
  final double? amount;
  final String? unitShort;
  final String? unitLong;

  MetricEntity({
    this.amount,
    this.unitShort,
    this.unitLong,
  });
}

class UsEntity extends HiveObject {
  final double? amount;
  final String? unitShort;
  final String? unitLong;

  UsEntity({
    this.amount,
    this.unitShort,
    this.unitLong,
  });
}
