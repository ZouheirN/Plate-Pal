import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:platepal/features/recipes/data/models/image_analysis.dart';
import 'package:platepal/features/recipes/data/models/random_recipes.dart';
import 'package:platepal/features/recipes/data/models/recipe_instructions.dart';
import 'package:platepal/features/recipes/data/models/search_recipe.dart';
import 'package:platepal/features/recipes/data/models/similar_recipes.dart';

abstract interface class RecipesLocalDataSource {
  Future<void> storeRandomRecipes({
    required RandomRecipesModel recipes,
  });

  RandomRecipesModel? loadRandomRecipes();

  Future<void> storeRecipeInstructions({
    required List<RecipeInstructionsModel> instructions,
    required int recipeId,
  });

  List<RecipeInstructionsModel>? loadRecipeInstructions({
    required int recipeId,
  });

  Future<void> storeSimilarRecipes({
    required List<SimilarRecipesModel> similarRecipes,
    required int recipeId,
  });

  List<SimilarRecipesModel>? loadSimilarRecipes({
    required int recipeId,
  });

  Future<void> storeRecipeInformation({
    required RecipeModel recipe,
    required int recipeId,
  });

  RecipeModel? loadRecipeInformation({
    required int recipeId,
  });

  Future<void> storeSearchRecipes({
    required SearchRecipeModel recipes,
    required String query,
  });

  SearchRecipeModel? loadSearchRecipes({
    required String query,
  });

  Future<void> storeSearchRecipesByCategories({
    required SearchRecipeModel recipes,
    required String cuisines,
    required String diets,
  });

  SearchRecipeModel? loadSearchRecipesByCategories({
    required String cuisines,
    required String diets,
  });

  ValueListenable<Box>? getRecipeAnalysis();

  Future<void> storeImageAnalysis({
    required File image,
    required ImageAnalysisModel imageAnalysis,
  });

  Future<void> deleteImageAnalysis({
    required File image,
  });
}

class RecipesLocalDataSourceImpl implements RecipesLocalDataSource {
  final Box cacheBox;
  final Box recipeAnalysisBox;

  RecipesLocalDataSourceImpl({
    required this.cacheBox,
    required this.recipeAnalysisBox,
  });

  @override
  Future<void> storeRandomRecipes({required RandomRecipesModel recipes}) async {
    await cacheBox.clear();
    await cacheBox.put('randomRecipes', recipes);
  }

  @override
  RandomRecipesModel? loadRandomRecipes() {
    return cacheBox.get('randomRecipes');
  }

  @override
  Future<void> storeRecipeInstructions({
    required List<RecipeInstructionsModel> instructions,
    required int recipeId,
  }) async {
    await cacheBox.clear();
    await cacheBox.put('recipeInstructions+$recipeId', instructions);
  }

  @override
  List<RecipeInstructionsModel>? loadRecipeInstructions({
    required int recipeId,
  }) {
    return cacheBox.get('recipeInstructions+$recipeId');
  }

  @override
  Future<void> storeSimilarRecipes({
    required List<SimilarRecipesModel> similarRecipes,
    required int recipeId,
  }) async {
    await cacheBox.clear();
    await cacheBox.put('similarRecipes+$recipeId', similarRecipes);
  }

  @override
  List<SimilarRecipesModel>? loadSimilarRecipes({
    required int recipeId,
  }) {
    return cacheBox.get('similarRecipes+$recipeId');
  }

  @override
  Future<void> storeRecipeInformation({
    required RecipeModel recipe,
    required int recipeId,
  }) async {
    await cacheBox.clear();
    await cacheBox.put('recipeInformation+$recipeId', recipe);
  }

  @override
  RecipeModel? loadRecipeInformation({
    required int recipeId,
  }) {
    return cacheBox.get('recipeInformation+$recipeId');
  }

  @override
  Future<void> storeSearchRecipes({
    required SearchRecipeModel recipes,
    required String query,
  }) async {
    await cacheBox.clear();
    await cacheBox.put('searchRecipes+$query', recipes);
  }

  @override
  SearchRecipeModel? loadSearchRecipes({
    required String query,
  }) {
    return cacheBox.get('searchRecipes+$query');
  }

  @override
  Future<void> storeSearchRecipesByCategories({
    required SearchRecipeModel recipes,
    required String cuisines,
    required String diets,
  }) async {
    await cacheBox.clear();
    await cacheBox.put('searchRecipesByCategories+$cuisines+$diets', recipes);
  }

  @override
  SearchRecipeModel? loadSearchRecipesByCategories({
    required String cuisines,
    required String diets,
  }) {
    return cacheBox.get('searchRecipesByCategories+$cuisines+$diets');
  }

  @override
  ValueListenable<Box>? getRecipeAnalysis() {
    return recipeAnalysisBox.listenable();
  }

  @override
  Future<void> storeImageAnalysis({
    required File image,
    required ImageAnalysisModel imageAnalysis,
  }) async {
    final key = image.path;

    return await recipeAnalysisBox.put(key, imageAnalysis);
  }

  @override
  Future<void> deleteImageAnalysis({required File image}) {
    final key = image.path;

    return recipeAnalysisBox.delete(key);
  }
}
