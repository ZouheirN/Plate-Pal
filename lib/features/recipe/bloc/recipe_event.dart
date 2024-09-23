part of 'recipe_bloc.dart';

@immutable
sealed class RecipeEvent {}

final class RecipeInstructionFetchEvent extends RecipeEvent {
  final int recipeId;

  RecipeInstructionFetchEvent(this.recipeId);
}

final class RecipeInstructionSuccessEvent extends RecipeEvent {
  final List<RecipeInstructionsModel> recipeInstructionsModel;

  RecipeInstructionSuccessEvent(this.recipeInstructionsModel);
}

final class SimilarRecipesFetchEvent extends RecipeEvent {
  final int recipeId;

  SimilarRecipesFetchEvent(this.recipeId);
}