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