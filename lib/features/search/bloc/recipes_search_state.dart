part of 'recipes_search_bloc.dart';

@immutable
sealed class RecipesSearchState {}

final class RecipesSearchInitial extends RecipesSearchState {}

final class RecipesSearchLoading extends RecipesSearchState {}

final class RecipesSearchSuccess extends RecipesSearchState {
  final SearchRecipeModel searchRecipeModel;

  RecipesSearchSuccess(this.searchRecipeModel);
}

final class RecipesSearchError extends RecipesSearchState {
  final String message;

  RecipesSearchError(this.message);
}