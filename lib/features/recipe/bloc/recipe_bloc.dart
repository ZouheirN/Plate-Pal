import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';
import 'package:platepal/features/home/models/random_recipe_model.dart';
import 'package:platepal/features/recipe/models/recipe_instructions_model.dart';
import 'package:platepal/features/recipe/models/similar_recipes_model.dart';
import 'package:platepal/main.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeBloc() : super(RecipeInstructionInitial()) {
    on<RecipeInstructionFetchEvent>(recipeInstructionFetchEvent);
    on<RecipeInstructionSuccessEvent>(recipeInstructionSuccessEvent);
    on<SimilarRecipesFetchEvent>(similarRecipesFetchEvent);
    on<RecipeInformationFetchEvent>(recipeInformationFetchEvent);
  }

  FutureOr<void> recipeInstructionFetchEvent(
      RecipeInstructionFetchEvent event, Emitter<RecipeState> emit) async {
    emit(RecipeInstructionLoading());

    Uri uri = Uri.https(
      'api.spoonacular.com',
      '/recipes/${event.recipeId}/analyzedInstructions',
      {
        'apiKey': dotenv.env['API_KEY'],
      },
    );

    try {
      final result = await Dio().getUri(
        uri,
      );

      emit(RecipeInstructionSuccess(
          recipeInstructionsModelFromJson(result.data)));
    } catch (e) {
      logger.e(e);
      emit(RecipeInstructionError(e.toString()));
    }
  }

  FutureOr<void> recipeInstructionSuccessEvent(
      RecipeInstructionSuccessEvent event, Emitter<RecipeState> emit) {
    emit(RecipeInstructionSuccess(event.recipeInstructionsModel));
  }

  Future<void> similarRecipesFetchEvent(
      SimilarRecipesFetchEvent event, Emitter<RecipeState> emit) async {
    Uri uri = Uri.https(
      'api.spoonacular.com',
      '/recipes/${event.recipeId}/similar',
      {
        'apiKey': dotenv.env['API_KEY'],
      },
    );

    try {
      final result = await Dio().getUri(
        uri,
      );

      emit(SimilarRecipesSuccess(similarRecipesModelFromJson(result.data)));
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> recipeInformationFetchEvent(
      RecipeInformationFetchEvent event, Emitter<RecipeState> emit) async {
    Uri uri = Uri.https(
      'api.spoonacular.com',
      '/recipes/${event.recipeId}/information',
      {
        'apiKey': dotenv.env['API_KEY'],
      },
    );

    try {
      final result = await Dio().getUri(
        uri,
      );

      emit(RecipeInformationSuccess(Recipe.fromJson(result.data)));
    } catch (e) {
      logger.e(e);
    }
  }
}
