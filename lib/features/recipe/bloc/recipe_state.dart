part of 'recipe_bloc.dart';

@immutable
sealed class RecipeState {}

final class RecipeInstructionInitial extends RecipeState {}

final class RecipeInstructionLoading extends RecipeState {}

final class RecipeInstructionSuccess extends RecipeState {
  final List<RecipeInstructionsModel> recipeInstructionModel;

  RecipeInstructionSuccess(this.recipeInstructionModel);
}

final class RecipeInstructionError extends RecipeState {
  final String message;

  RecipeInstructionError(this.message);
}

final class SimilarRecipesSuccess extends RecipeState {
  final List<SimilarRecipesModel> similarRecipes;

  SimilarRecipesSuccess(this.similarRecipes);
}

final class RecipeInformationSuccess extends RecipeState {
  final RecipeModel recipe;

  RecipeInformationSuccess(this.recipe);
}