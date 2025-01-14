import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:platepal/features/recipes/domain/entities/random_recipes.dart';
import 'package:platepal/features/recipes/domain/entities/recipe_instructions.dart';
import 'package:platepal/features/recipes/domain/entities/similar_recipes.dart';

abstract class RecipesState extends Equatable {
  final RandomRecipesEntity? randomRecipes;
  final List<RecipeInstructionsEntity>? recipeInstructions;
  final List<SimilarRecipesEntity>? similarRecipes;
  final RecipeEntity? recipe;
  final DioException? error;

  const RecipesState({
    this.randomRecipes,
    this.recipeInstructions,
    this.similarRecipes,
    this.recipe,
    this.error,
  });

  @override
  List<Object?> get props =>
      [randomRecipes, recipeInstructions, similarRecipes, recipe, error];
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