part of 'recipes_home_bloc.dart';

@immutable
sealed class RecipesHomeState {}

final class RecipesHomeInitial extends RecipesHomeState {}

final class RecipesHomeLoading extends RecipesHomeState {}

final class RecipesHomeSuccess extends RecipesHomeState {
  final RandomRecipeModel randomRecipeModel;

  RecipesHomeSuccess(this.randomRecipeModel);
}

final class RecipesHomeError extends RecipesHomeState {
  final String message;

  RecipesHomeError(this.message);
}