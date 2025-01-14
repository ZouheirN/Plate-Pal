import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platepal/core/resources/data_state.dart';
import 'package:platepal/features/recipes/domain/usecases/get_random_recipes.dart';
import 'package:platepal/features/recipes/domain/usecases/get_recipe_information.dart';
import 'package:platepal/features/recipes/domain/usecases/get_recipe_instructions.dart';
import 'package:platepal/features/recipes/domain/usecases/get_similar_recipes.dart';
import 'package:platepal/features/recipes/presentation/bloc/recipes/recipes_event.dart';
import 'package:platepal/features/recipes/presentation/bloc/recipes/recipes_state.dart';

class RecipesBloc extends Bloc<RecipesEvent, RecipesState> {
  final GetRandomRecipesUseCase _getRandomRecipesUseCase;
  final GetRecipeInstructionsUseCase _getRecipeInstructionsUseCase;
  final GetSimilarRecipesUseCase _getSimilarRecipesUseCase;
  final GetRecipeInformationUseCase _getRecipeInformationUseCase;

  RecipesBloc(this._getRandomRecipesUseCase, this._getRecipeInstructionsUseCase,
      this._getSimilarRecipesUseCase, this._getRecipeInformationUseCase)
      : super(const RecipesLoading()) {
    on<GetRandomRecipes>(onGetRandomRecipes);
    on<GetRecipeInstructions>(onGetRecipeInstructions);
    on<EmitRecipeInstructionsSuccess>(onEmitRecipeInstructionsSuccess);
    on<GetSimilarRecipes>(onGetSimilarRecipes);
    on<GetRecipeInformation>(onGetRecipeInformation);
  }

  Future<void> onGetRandomRecipes(
      GetRandomRecipes event, Emitter<RecipesState> emit) async {
    final dataState = await _getRandomRecipesUseCase();

    if (dataState is DataSuccess && dataState.data != null) {
      emit(RandomRecipesDone(randomRecipes: dataState.data!));
    } else if (dataState is DataFailed) {
      emit(RandomRecipesError(error: dataState.error!));
    }
  }

  Future<void> onGetRecipeInstructions(
      GetRecipeInstructions event, Emitter<RecipesState> emit) async {
    final dataState =
        await _getRecipeInstructionsUseCase(params: event.recipeId);

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RecipeInstructionsDone(recipeInstructions: dataState.data!));
    } else if (dataState is DataFailed) {
      emit(RecipeInstructionsError(error: dataState.error!));
    }
  }

  Future<void> onEmitRecipeInstructionsSuccess(
      EmitRecipeInstructionsSuccess event, Emitter<RecipesState> emit) async {
    emit(RecipeInstructionsDone(
        recipeInstructions: event.recipeInstructionsEntity));
  }

  Future<void> onGetSimilarRecipes(
      GetSimilarRecipes event, Emitter<RecipesState> emit) async {
    final dataState = await _getSimilarRecipesUseCase(params: event.recipeId);

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(SimilarRecipesDone(similarRecipes: dataState.data!));
    } else if (dataState is DataFailed) {
      emit(SimilarRecipesError(error: dataState.error!));
    }
  }

  Future<void> onGetRecipeInformation(
      GetRecipeInformation event, Emitter<RecipesState> emit) async {
    final dataState =
        await _getRecipeInformationUseCase(params: event.recipeId);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(RecipeInformationDone(recipe: dataState.data!));
    } else if (dataState is DataFailed) {
      emit(RecipeInformationError(error: dataState.error!));
    }
  }
}
