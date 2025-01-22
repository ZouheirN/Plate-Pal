import 'package:hive_ce/hive.dart';

class ImageAnalysisEntity extends HiveObject {
  final NutritionEntity? nutrition;
  final CategoryEntity? category;
  final List<RecipeIAEntity>? recipes;

  ImageAnalysisEntity({
    this.nutrition,
    this.category,
    this.recipes,
  });
}

class CategoryEntity extends HiveObject {
  final String? name;
  final num? probability;

  CategoryEntity({
    this.name,
    this.probability,
  });
}

class NutritionEntity extends HiveObject {
  final num? recipesUsed;
  final CaloriesEntity? calories;
  final CaloriesEntity? fat;
  final CaloriesEntity? protein;
  final CaloriesEntity? carbs;

  NutritionEntity({
    this.recipesUsed,
    this.calories,
    this.fat,
    this.protein,
    this.carbs,
  });
}

class CaloriesEntity extends HiveObject {
  final num? value;
  final String? unit;
  final ConfidenceRange95PercentEntity? confidenceRange95Percent;
  final num? standardDeviation;

  CaloriesEntity({
    this.value,
    this.unit,
    this.confidenceRange95Percent,
    this.standardDeviation,
  });
}

class ConfidenceRange95PercentEntity extends HiveObject {
  final num? min;
  final num? max;

  ConfidenceRange95PercentEntity({
    this.min,
    this.max,
  });
}

class RecipeIAEntity extends HiveObject {
  final num? id;
  final String? title;
  final String? imageType;
  final String? sourceUrl;

  RecipeIAEntity({
    this.id,
    this.title,
    this.imageType,
    this.sourceUrl,
  });
}
