import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'random_recipes.g.dart';

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

@HiveType(typeId: 5)
class RecipeEntity extends Equatable {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final String? image;
  @HiveField(3)
  final int? servings;
  @HiveField(4)
  final int? readyInMinutes;
  @HiveField(5)
  final int? cookingMinutes;
  @HiveField(6)
  final int? preparationMinutes;
  @HiveField(7)
  final bool? cheap;
  @HiveField(8)
  final bool? dairyFree;
  @HiveField(9)
  final bool? glutenFree;
  @HiveField(10)
  final bool? vegan;
  @HiveField(11)
  final bool? vegetarian;
  @HiveField(12)
  final List<String>? dishTypes;
  @HiveField(13)
  final List<ExtendedIngredientsEntity>? extendedIngredients;
  @HiveField(14)
  final String? summary;
  @HiveField(15)
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

@HiveType(typeId: 6)
class ExtendedIngredientsEntity extends Equatable {
  @HiveField(0)
  final String? aisle;
  @HiveField(1)
  final double? amount;
  @HiveField(2)
  final String? consistency;
  @HiveField(3)
  final String? image;
  @HiveField(4)
  final MeasuresEntity? measures;
  @HiveField(5)
  final List<String>? meta;
  @HiveField(6)
  final String? name;
  @HiveField(7)
  final String? original;
  @HiveField(8)
  final String? originalName;
  @HiveField(9)
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

@HiveType(typeId: 7)
class MeasuresEntity extends Equatable {
  @HiveField(0)
  final MetricEntity? metric;
  @HiveField(1)
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

@HiveType(typeId: 8)
class MetricEntity extends Equatable {
  @HiveField(0)
  final double? amount;
  @HiveField(1)
  final String? unitShort;
  @HiveField(2)
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

@HiveType(typeId: 9)
class UsEntity extends Equatable {
  @HiveField(0)
  final double? amount;
  @HiveField(1)
  final String? unitShort;
  @HiveField(2)
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
