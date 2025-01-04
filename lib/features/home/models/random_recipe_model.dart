import 'package:hive/hive.dart';

part 'random_recipe_model.g.dart';

class RandomRecipeModel {
  List<Recipe>? recipes;

  RandomRecipeModel({
    this.recipes,
  });

  factory RandomRecipeModel.fromJson(Map<String, dynamic> json) {
    return RandomRecipeModel(
      recipes: json['recipes'] != null ? (json['recipes'] as List).map((i) => Recipe.fromJson(i)).toList() : null,
    );
  }
}

@HiveType(typeId: 0)
class Recipe{
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
  final List<ExtendedIngredients>? extendedIngredients;
  @HiveField(14)
  final String? summary;
  @HiveField(15)
  final String? sourceUrl;

  Recipe({
    required this.id,
    required this.title,
    required this.image,
    required this.servings,
    required this.readyInMinutes,
    required this.cookingMinutes,
    required this.preparationMinutes,
    required this.cheap,
    required this.dairyFree,
    required this.glutenFree,
    required this.vegan,
    required this.vegetarian,
    required this.dishTypes,
    required this.extendedIngredients,
    required this.summary,
    required this.sourceUrl,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
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
      dishTypes: json['dishTypes'] != null ? List<String>.from(json['dishTypes']) : [],
      extendedIngredients: json['extendedIngredients'] != null ? (json['extendedIngredients'] as List).map((i) => ExtendedIngredients.fromJson(i)).toList() : [],
      summary: json['summary'],
      sourceUrl: json['sourceUrl'],
    );
  }
}

@HiveType(typeId: 1)
class ExtendedIngredients {
  @HiveField(0)
  final String? aisle;
  @HiveField(1)
  final double? amount;
  @HiveField(2)
  final String? consistency;
  @HiveField(3)
  final String? image;
  @HiveField(4)
  final Measures? measures;
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

  ExtendedIngredients({
    required this.aisle,
    required this.amount,
    required this.consistency,
    required this.image,
    required this.measures,
    required this.meta,
    required this.name,
    required this.original,
    required this.originalName,
    required this.unit,
  });

  factory ExtendedIngredients.fromJson(Map<String, dynamic> json) {
    return ExtendedIngredients(
      aisle: json['aisle'],
      amount: json['amount'],
      consistency: json['consistency'],
      image: json['image'],
      measures: Measures.fromJson(json['measures']),
      meta: json['meta'] != null ? List<String>.from(json['meta']) : [],
      name: json['name'],
      original: json['original'],
      originalName: json['originalName'],
      unit: json['unit'],
    );
  }
}

@HiveType(typeId: 2)
class Measures {
  @HiveField(0)
  final Metric? metric;
  @HiveField(1)
  final Us? us;

  Measures({
    required this.metric,
    required this.us,
  });

  factory Measures.fromJson(Map<String, dynamic> json) {
    return Measures(
      metric: Metric.fromJson(json['metric']),
      us: Us.fromJson(json['us']),
    );
  }
}

@HiveType(typeId: 3)
class Metric {
  @HiveField(0)
  final double? amount;
  @HiveField(1)
  final String? unitShort;
  @HiveField(2)
  final String? unitLong;

  Metric({
    required this.amount,
    required this.unitShort,
    required this.unitLong,
  });

  factory Metric.fromJson(Map<String, dynamic> json) {
    return Metric(
      amount: json['amount'],
      unitShort: json['unitShort'],
      unitLong: json['unitLong'],
    );
  }
}

@HiveType(typeId: 4)
class Us {
  @HiveField(0)
  final double? amount;
  @HiveField(1)
  final String? unitShort;
  @HiveField(2)
  final String? unitLong;

  Us({
    required this.amount,
    required this.unitShort,
    required this.unitLong,
  });

  factory Us.fromJson(Map<String, dynamic> json) {
    return Us(
      amount: json['amount'],
      unitShort: json['unitShort'],
      unitLong: json['unitLong'],
    );
  }
}