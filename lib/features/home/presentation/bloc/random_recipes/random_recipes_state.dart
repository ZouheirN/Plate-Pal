import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:platepal/features/home/domain/entities/random_recipes.dart';

abstract class RandomRecipesState extends Equatable {
  final RandomRecipesEntity? randomRecipes;
  final DioException? error;

  const RandomRecipesState({this.randomRecipes, this.error});

  @override
  List<Object?> get props => [randomRecipes, error];
}

class RandomRecipesLoading extends RandomRecipesState {
  const RandomRecipesLoading();
}

class RandomRecipesDone extends RandomRecipesState {
  const RandomRecipesDone({required RandomRecipesEntity randomRecipes})
      : super(randomRecipes: randomRecipes);
}

class RandomRecipesError extends RandomRecipesState {
  const RandomRecipesError({required DioException error}) : super(error: error);
}
