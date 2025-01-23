import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:platepal/features/recipes/domain/entities/image_analysis.dart';
import 'package:platepal/features/recipes/domain/entities/random_recipes.dart';
import 'package:platepal/features/recipes/domain/entities/recipe_instructions.dart';
import 'package:platepal/features/recipes/domain/entities/search_recipe.dart';
import 'package:platepal/features/recipes/domain/entities/similar_recipes.dart';

abstract class RecipesState {
  final RandomRecipesEntity? randomRecipes;
  final List<RecipeInstructionsEntity>? recipeInstructions;
  final List<SimilarRecipesEntity>? similarRecipes;
  final RecipeEntity? recipe;
  final SearchRecipeEntity? searchRecipe;
  final ValueListenable? recipeAnalysis;
  final ImageAnalysisEntity? imageAnalysis;
  final File? image;
  final DioException? error;
  final Exception? exception;

  const RecipesState({
    this.randomRecipes,
    this.recipeInstructions,
    this.similarRecipes,
    this.recipe,
    this.searchRecipe,
    this.recipeAnalysis,
    this.imageAnalysis,
    this.image,
    this.error,
    this.exception,
  });
}

class RecipesLoading extends RecipesState {
  const RecipesLoading();
}

class RandomRecipesDone extends RecipesState {
  const RandomRecipesDone({required RandomRecipesEntity randomRecipes})
      : super(randomRecipes: randomRecipes);
}

class RandomRecipesError extends RecipesState {
  const RandomRecipesError({required DioException error}) : super(error: error);
}

class RecipeInstructionsDone extends RecipesState {
  const RecipeInstructionsDone(
      {required List<RecipeInstructionsEntity> recipeInstructions})
      : super(recipeInstructions: recipeInstructions);
}

class RecipeInstructionsError extends RecipesState {
  const RecipeInstructionsError({required DioException error})
      : super(error: error);
}

class SimilarRecipesDone extends RecipesState {
  const SimilarRecipesDone({required List<SimilarRecipesEntity> similarRecipes})
      : super(similarRecipes: similarRecipes);
}

class SimilarRecipesError extends RecipesState {
  const SimilarRecipesError({required DioException error})
      : super(error: error);
}

class RecipeInformationDone extends RecipesState {
  const RecipeInformationDone({required RecipeEntity recipe})
      : super(recipe: recipe);
}

class RecipeInformationError extends RecipesState {
  const RecipeInformationError({required DioException error})
      : super(error: error);
}

class SearchRecipesDone extends RecipesState {
  const SearchRecipesDone({required SearchRecipeEntity searchRecipe})
      : super(searchRecipe: searchRecipe);
}

class SearchRecipesError extends RecipesState {
  const SearchRecipesError({required DioException error}) : super(error: error);
}

class RecipeAnalysisDone extends RecipesState {
  const RecipeAnalysisDone(ValueListenable valueListenable)
      : super(recipeAnalysis: valueListenable);
}

class RecipeAnalysisError extends RecipesState {
  const RecipeAnalysisError({required Exception exception})
      : super(exception: exception);
}

class ImageAnalysisDone extends RecipesState {
  const ImageAnalysisDone(ImageAnalysisEntity imageAnalysis, File image)
      : super(imageAnalysis: imageAnalysis, image: image);
}

class ImageAnalysisError extends RecipesState {
  const ImageAnalysisError({required DioException error}) : super(error: error);
}

class StoreImageAnalysisDone extends RecipesState {
  const StoreImageAnalysisDone();
}

class StoreImageAnalysisError extends RecipesState {
  const StoreImageAnalysisError({required Exception exception})
      : super(exception: exception);
}

class DeleteImageAnalysisDone extends RecipesState {
  const DeleteImageAnalysisDone();
}

class DeleteImageAnalysisError extends RecipesState {
  const DeleteImageAnalysisError({required Exception exception})
      : super(exception: exception);
}