import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';
import 'package:platepal/features/recipe/models/recipe_instructions_model.dart';
import 'package:platepal/main.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeBloc() : super(RecipeInstructionInitial()) {
    on<RecipeInstructionFetchEvent>(recipeInstructionFetchEvent);
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
}
