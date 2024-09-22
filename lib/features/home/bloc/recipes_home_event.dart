part of 'recipes_home_bloc.dart';

@immutable
sealed class RecipesHomeEvent {}

final class RecipesHomeFetchRandomEvent extends RecipesHomeEvent {}