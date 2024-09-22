part of 'recipe_bloc.dart';

@immutable
sealed class RecipeEvent {}

final class RecipeInstructionFetchEvent extends RecipeEvent {
  final int recipeId;

  RecipeInstructionFetchEvent(this.recipeId);
}