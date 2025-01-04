part of 'recipes_search_bloc.dart';

@immutable
sealed class RecipesSearchEvent {}

final class RecipesSearchByCategoriesFetchEvent extends RecipesSearchEvent {
  final List<String> cuisines;
  final List<String> diets;

  RecipesSearchByCategoriesFetchEvent(this.cuisines, this.diets);
}

final class RecipesSearchFetchEvent extends RecipesSearchEvent {
  final String query;

  RecipesSearchFetchEvent(this.query);
}