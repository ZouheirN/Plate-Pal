import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';

import '../../../main.dart';
import '../models/search_recipe_model.dart';

part 'recipes_search_event.dart';

part 'recipes_search_state.dart';

class RecipesSearchBloc extends Bloc<RecipesSearchEvent, RecipesSearchState> {
  RecipesSearchBloc() : super(RecipesSearchInitial()) {
    on<RecipesSearchByCategoriesFetchEvent>(
        recipesSearchByCategoriesFetchEvent);
    on<RecipesSearchFetchEvent>(recipesSearchFetchEvent);
  }

  Future<void> recipesSearchByCategoriesFetchEvent(
      RecipesSearchByCategoriesFetchEvent event,
      Emitter<RecipesSearchState> emit) async {
    emit(RecipesSearchLoading());

    final cuisines = event.cuisines.isNotEmpty ? event.cuisines.join(',') : '';
    final diets = event.diets.isNotEmpty ? event.diets.join(',') : '';

    Uri uri = Uri.https(
      'api.spoonacular.com',
      '/recipes/complexSearch',
      {
        'apiKey': dotenv.env['API_KEY'],
        'includeNutrition': 'false',
        'cuisine': cuisines,
        'diet': diets,
      },
    );

    try {
      final result = await Dio().getUri(
        uri,
      );

      emit(RecipesSearchSuccess(SearchRecipeModel.fromJson(result.data)));
    } catch (e) {
      logger.e(e);
      emit(RecipesSearchError(e.toString()));
    }
  }

  Future<void> recipesSearchFetchEvent(
      RecipesSearchFetchEvent event,
      Emitter<RecipesSearchState> emit) async {
    emit(RecipesSearchLoading());

    Uri uri = Uri.https(
      'api.spoonacular.com',
      '/recipes/complexSearch',
      {
        'apiKey': dotenv.env['API_KEY'],
        'includeNutrition': 'false',
        'query': event.query,
      },
    );

    try {
      final result = await Dio().getUri(
        uri,
      );

      emit(RecipesSearchSuccess(SearchRecipeModel.fromJson(result.data)));
    } catch (e) {
      logger.e(e);
      emit(RecipesSearchError(e.toString()));
    }
  }
}
