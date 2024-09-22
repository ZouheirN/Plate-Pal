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

class Recipe{
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
  final List<ExtendedIngredients>? extendedIngredients;
  final String? summary;

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
    );
  }
}

class ExtendedIngredients {
  final String? aisle;
  final double? amount;
  final String? consistency;
  final String? image;
  final Measures? measures;
  final List<String>? meta;
  final String? name;
  final String? original;
  final String? originalName;
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

class Measures {
  final Metric? metric;
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

class Metric {
  final double? amount;
  final String? unitShort;
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

class Us {
  final double? amount;
  final String? unitShort;
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