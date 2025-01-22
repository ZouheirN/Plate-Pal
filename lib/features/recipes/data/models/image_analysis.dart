import 'package:platepal/features/recipes/domain/entities/image_analysis.dart';

class ImageAnalysisModel extends ImageAnalysisEntity {
  ImageAnalysisModel({
    super.nutrition,
    super.category,
    super.recipes,
  });

  factory ImageAnalysisModel.fromJson(Map<String, dynamic> json) {
    return ImageAnalysisModel(
      nutrition: json['nutrition'] != null
          ? NutritionModel.fromJson(json['nutrition'])
          : null,
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'])
          : null,
      recipes: json['recipes'] != null
          ? (json['recipes'] as List)
              .map((i) => RecipeIAModel.fromJson(i))
              .toList()
          : null,
    );
  }
}

class CategoryModel extends CategoryEntity {
  CategoryModel({
    super.name,
    super.probability,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'],
      probability: json['probability'],
    );
  }
}

class NutritionModel extends NutritionEntity {
  NutritionModel({
    super.recipesUsed,
    super.calories,
    super.fat,
    super.protein,
    super.carbs,
  });

  factory NutritionModel.fromJson(Map<String, dynamic> json) {
    return NutritionModel(
      recipesUsed: json['recipesUsed'],
      calories: json['calories'] != null
          ? CaloriesModel.fromJson(json['calories'])
          : null,
      fat: json['fat'] != null
          ? CaloriesModel.fromJson(json['fat'])
          : null,
      protein: json['protein'] != null
          ? CaloriesModel.fromJson(json['protein'])
          : null,
      carbs: json['carbs'] != null
          ? CaloriesModel.fromJson(json['carbs'])
          : null,
    );
  }
}

class CaloriesModel extends CaloriesEntity {
  CaloriesModel({
    super.value,
    super.unit,
    super.confidenceRange95Percent,
    super.standardDeviation,
  });

  factory CaloriesModel.fromJson(Map<String, dynamic> json) {
    return CaloriesModel(
      value: json['value'],
      unit: json['unit'],
      confidenceRange95Percent: json['confidenceRange95Percent'] != null
          ? ConfidenceRange95PercentModel.fromJson(json['confidenceRange95Percent'])
          : null,
      standardDeviation: json['standardDeviation'],
    );
  }
}

class ConfidenceRange95PercentModel extends ConfidenceRange95PercentEntity {
  ConfidenceRange95PercentModel({
    super.min,
    super.max,
  });

  factory ConfidenceRange95PercentModel.fromJson(Map<String, dynamic> json) {
    return ConfidenceRange95PercentModel(
      min: json['min'],
      max: json['max'],
    );
  }
}

class RecipeIAModel extends RecipeIAEntity {
  RecipeIAModel({
    super.id,
    super.title,
    super.sourceUrl,
    super.imageType,
  });

  factory RecipeIAModel.fromJson(Map<String, dynamic> json) {
    return RecipeIAModel(
      id: json['id'],
      title: json['title'],
      sourceUrl: json['sourceUrl'],
      imageType: json['imageType'],
    );
  }
}
