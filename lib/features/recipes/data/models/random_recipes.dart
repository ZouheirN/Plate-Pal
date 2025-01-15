import 'package:platepal/features/recipes/domain/entities/random_recipes.dart';

class RandomRecipesModel extends RandomRecipesEntity {
  const RandomRecipesModel({
    super.recipes,
  });

  factory RandomRecipesModel.fromJson(Map<String, dynamic> json) {
    return RandomRecipesModel(
      recipes: json['recipes'] != null
          ? (json['recipes'] as List)
              .map((i) => RecipeModel.fromJson(i))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    List<RecipeModel>? recipes = this.recipes as List<RecipeModel>?;

    return {
      'recipes': recipes?.map((e) => e.toJson()).toList(),
    };
  }
}

class RecipeModel extends RecipeEntity {
  RecipeModel({
    super.id,
    super.title,
    super.image,
    super.servings,
    super.readyInMinutes,
    super.cookingMinutes,
    super.preparationMinutes,
    super.cheap,
    super.dairyFree,
    super.glutenFree,
    super.vegan,
    super.vegetarian,
    super.dishTypes,
    super.extendedIngredients,
    super.summary,
    super.sourceUrl,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      servings: json['servings'],
      readyInMinutes: json['readyInMinutes'],
      cookingMinutes: json['cookingMinutes'],
      preparationMinutes: json['preparationMinutes'],
      cheap: json['cheap'],
      dairyFree: json['dairyFree'],
      glutenFree: json['glutenFree'],
      vegan: json['vegan'],
      vegetarian: json['vegetarian'],
      dishTypes:
          json['dishTypes'] != null ? List<String>.from(json['dishTypes']) : [],
      extendedIngredients: json['extendedIngredients'] != null
          ? (json['extendedIngredients'] as List)
              .map((i) => ExtendedIngredientsModel.fromJson(Map<String, dynamic>.from(i)))
              .toList()
          : [],
      summary: json['summary'],
      sourceUrl: json['sourceUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    List<ExtendedIngredientsModel> extendedIngredients =
        this.extendedIngredients as List<ExtendedIngredientsModel>;

    return {
      'id': id,
      'title': title,
      'image': image,
      'servings': servings,
      'readyInMinutes': readyInMinutes,
      'cookingMinutes': cookingMinutes,
      'preparationMinutes': preparationMinutes,
      'cheap': cheap,
      'dairyFree': dairyFree,
      'glutenFree': glutenFree,
      'vegan': vegan,
      'vegetarian': vegetarian,
      'dishTypes': dishTypes,
      'extendedIngredients':
          extendedIngredients.map((e) => e.toJson()).toList(),
      'summary': summary,
      'sourceUrl': sourceUrl,
    };
  }
}

class ExtendedIngredientsModel extends ExtendedIngredientsEntity {
  ExtendedIngredientsModel({
    super.aisle,
    super.amount,
    super.consistency,
    super.image,
    super.measures,
    super.meta,
    super.name,
    super.original,
    super.originalName,
    super.unit,
  });

  factory ExtendedIngredientsModel.fromJson(Map<String, dynamic> json) {
    return ExtendedIngredientsModel(
      aisle: json['aisle'],
      amount: json['amount'],
      consistency: json['consistency'],
      image: json['image'],
      measures: MeasuresModel.fromJson(Map<String, dynamic>.from(json['measures'])),
      meta: json['meta'] != null ? List<String>.from(json['meta']) : [],
      name: json['name'],
      original: json['original'],
      originalName: json['originalName'],
      unit: json['unit'],
    );
  }

  Map<String, dynamic> toJson() {
    MeasuresModel measures = this.measures as MeasuresModel;

    return {
      'aisle': aisle,
      'amount': amount,
      'consistency': consistency,
      'image': image,
      'measures': measures.toJson(),
      'meta': meta,
      'name': name,
      'original': original,
      'originalName': originalName,
      'unit': unit,
    };
  }
}

class MeasuresModel extends MeasuresEntity {
  MeasuresModel({
    super.metric,
    super.us,
  });

  factory MeasuresModel.fromJson(Map<String, dynamic> json) {
    return MeasuresModel(
      metric: MetricModel.fromJson(Map<String, dynamic>.from(json['metric'])),
      us: UsModel.fromJson(Map<String, dynamic>.from(json['us'])),
    );
  }

  Map<String, dynamic> toJson() {
    MetricModel metric = this.metric as MetricModel;
    UsModel? us = this.us as UsModel?;

    return {
      'metric': metric.toJson(),
      'us': us?.toJson(),
    };
  }
}

class MetricModel extends MetricEntity {
  MetricModel({
    super.amount,
    super.unitShort,
    super.unitLong,
  });

  factory MetricModel.fromJson(Map<String, dynamic> json) {
    return MetricModel(
      amount: json['amount'],
      unitShort: json['unitShort'],
      unitLong: json['unitLong'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'unitShort': unitShort,
      'unitLong': unitLong,
    };
  }
}

class UsModel extends UsEntity {
  UsModel({
    super.amount,
    super.unitShort,
    super.unitLong,
  });

  factory UsModel.fromJson(Map<String, dynamic> json) {
    return UsModel(
      amount: json['amount'],
      unitShort: json['unitShort'],
      unitLong: json['unitLong'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'unitShort': unitShort,
      'unitLong': unitLong,
    };
  }
}
