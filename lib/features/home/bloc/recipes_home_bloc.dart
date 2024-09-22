import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:platepal/features/home/models/random_recipe_model.dart';
import 'package:platepal/main.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'recipes_home_event.dart';
part 'recipes_home_state.dart';

class RecipesHomeBloc extends Bloc<RecipesHomeEvent, RecipesHomeState> {
  RecipesHomeBloc() : super(RecipesHomeInitial()) {
    on<RecipesHomeFetchRandomEvent>(recipesHomeFetchRandomEvent);
  }

  Future<void> recipesHomeFetchRandomEvent(
      RecipesHomeFetchRandomEvent event, Emitter<RecipesHomeState> emit) async {
    emit(RecipesHomeLoading());

    Uri uri = Uri.https(
      'api.spoonacular.com',
      '/recipes/random',
      {
        'apiKey': dotenv.env['API_KEY'],
        'number': '10',
        'includeNutrition': 'false'
      },
    );

    try {
      final result = await Dio().getUri(
        uri,
      );

      emit(RecipesHomeSuccess(RandomRecipeModel.fromJson(result.data)));
    } catch (e) {
      logger.e(e);
      emit(RecipesHomeError(e.toString()));
    }
  }
}
