import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platepal/core/resources/data_state.dart';
import 'package:platepal/features/recipes/domain/usecases/delete_image_analysis.dart';
import 'package:platepal/features/recipes/domain/usecases/get_image_analysis.dart';
import 'package:platepal/features/recipes/domain/usecases/get_random_recipes.dart';
import 'package:platepal/features/recipes/domain/usecases/get_images_analysis.dart';
import 'package:platepal/features/recipes/domain/usecases/get_recipe_information.dart';
import 'package:platepal/features/recipes/domain/usecases/get_recipe_instructions.dart';
import 'package:platepal/features/recipes/domain/usecases/get_similar_recipes.dart';
import 'package:platepal/features/recipes/domain/usecases/search_recipes.dart';
import 'package:platepal/features/recipes/domain/usecases/search_recipes_by_categories.dart';
import 'package:platepal/features/recipes/domain/usecases/store_image_analysis.dart';
import 'package:platepal/features/recipes/presentation/bloc/recipes/recipes_event.dart';
import 'package:platepal/features/recipes/presentation/bloc/recipes/recipes_state.dart';
import 'package:platepal/main.dart';

class RecipesBloc extends Bloc<RecipesEvent, RecipesState> {
  final GetRandomRecipesUseCase _getRandomRecipesUseCase;
  final GetRecipeInstructionsUseCase _getRecipeInstructionsUseCase;
  final GetSimilarRecipesUseCase _getSimilarRecipesUseCase;
  final GetRecipeInformationUseCase _getRecipeInformationUseCase;
  final SearchRecipesUseCase _searchRecipesUseCase;
  final SearchRecipesByCategoriesUseCase _searchRecipesByCategoriesUseCase;
  final GetImagesAnalysisUseCase _getImagesAnalysisUseCase;
  final GetImageAnalysisUseCase _getImageAnalysisUseCase;
  final StoreImageAnalysisUseCase _storeImageAnalysisUseCase;
  final DeleteImageAnalysisUseCase _deleteImageAnalysisUseCase;

  RecipesBloc(
    this._getRandomRecipesUseCase,
    this._getRecipeInstructionsUseCase,
    this._getSimilarRecipesUseCase,
    this._getRecipeInformationUseCase,
    this._searchRecipesUseCase,
    this._searchRecipesByCategoriesUseCase,
    this._getImagesAnalysisUseCase,
    this._getImageAnalysisUseCase,
    this._storeImageAnalysisUseCase,
    this._deleteImageAnalysisUseCase,
  ) : super(const RecipesLoading()) {
    on<GetRandomRecipes>(onGetRandomRecipes);
    on<GetRecipeInstructions>(onGetRecipeInstructions);
    on<EmitRecipeInstructionsSuccess>(onEmitRecipeInstructionsSuccess);
    on<GetSimilarRecipes>(onGetSimilarRecipes);
    on<GetRecipeInformation>(onGetRecipeInformation);
    on<SearchRecipes>(onSearchRecipes);
    on<SearchRecipesByCategories>(onSearchRecipesByCategories);
    on<GetImagesAnalysis>(onGetImagesAnalysis);
    on<GetImageAnalysis>(onGetImageAnalysis);
    on<StoreImageAnalysis>(onStoreImageAnalysis);
    on<DeleteImageAnalysis>(onDeleteImageAnalysis);
  }

  Future<void> onGetRandomRecipes(
    GetRandomRecipes event,
    Emitter<RecipesState> emit,
  ) async {
    emit(const RecipesLoading());

    final dataState = await _getRandomRecipesUseCase();

    if (dataState is DataSuccess && dataState.data != null) {
      emit(RandomRecipesDone(randomRecipes: dataState.data!));
    } else if (dataState is DataFailed) {
      emit(RandomRecipesError(error: dataState.error!));
    }
  }

  Future<void> onGetRecipeInstructions(
    GetRecipeInstructions event,
    Emitter<RecipesState> emit,
  ) async {
    emit(const RecipesLoading());

    final dataState =
        await _getRecipeInstructionsUseCase(params: event.recipeId);


    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RecipeInstructionsDone(recipeInstructions: dataState.data!));
    } else if (dataState is DataFailed) {
      emit(RecipeInstructionsError(error: dataState.error!));
    } else {
      if (dataState.data!.isEmpty) {
        emit(
          RecipeInstructionsError(
            errorDescription: ErrorDescription('No instructions found'),
          ),
        );
      }
    }
  }

  Future<void> onEmitRecipeInstructionsSuccess(
    EmitRecipeInstructionsSuccess event,
    Emitter<RecipesState> emit,
  ) async {
    emit(RecipeInstructionsDone(
        recipeInstructions: event.recipeInstructionsEntity));
  }

  Future<void> onGetSimilarRecipes(
    GetSimilarRecipes event,
    Emitter<RecipesState> emit,
  ) async {
    emit(const RecipesLoading());

    final dataState = await _getSimilarRecipesUseCase(params: event.recipeId);

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(SimilarRecipesDone(similarRecipes: dataState.data!));
    } else if (dataState is DataFailed) {
      emit(SimilarRecipesError(error: dataState.error!));
    }
  }

  Future<void> onGetRecipeInformation(
    GetRecipeInformation event,
    Emitter<RecipesState> emit,
  ) async {
    emit(const RecipesLoading());

    final dataState =
        await _getRecipeInformationUseCase(params: event.recipeId);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(RecipeInformationDone(recipe: dataState.data!));
    } else if (dataState is DataFailed) {
      emit(RecipeInformationError(error: dataState.error!));
    }
  }

  Future<void> onSearchRecipes(
    SearchRecipes event,
    Emitter<RecipesState> emit,
  ) async {
    emit(const RecipesLoading());

    final dataState = await _searchRecipesUseCase(params: event.query);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(SearchRecipesDone(searchRecipe: dataState.data!));
    } else if (dataState is DataFailed) {
      emit(SearchRecipesError(error: dataState.error!));
    }
  }

  Future<void> onSearchRecipesByCategories(
    SearchRecipesByCategories event,
    Emitter<RecipesState> emit,
  ) async {
    emit(const RecipesLoading());

    final cuisines = event.cuisines.isNotEmpty ? event.cuisines.join(',') : '';
    final diets = event.diets.isNotEmpty ? event.diets.join(',') : '';

    final dataState = await _searchRecipesByCategoriesUseCase(params: {
      'cuisines': cuisines,
      'diets': diets,
    });

    if (dataState is DataSuccess && dataState.data != null) {
      emit(SearchRecipesDone(searchRecipe: dataState.data!));
    } else if (dataState is DataFailed) {
      emit(SearchRecipesError(error: dataState.error!));
    }
  }

  Future<void> onGetImagesAnalysis(
    GetImagesAnalysis event,
    Emitter<RecipesState> emit,
  ) async {
    emit(const RecipesLoading());

    final dataState = await _getImagesAnalysisUseCase();

    if (dataState is DataSuccess && dataState.data != null) {
      emit(ImagesAnalysisDone(dataState.data!));
    } else if (dataState is DataFailed) {
      emit(ImagesAnalysisError(exception: dataState.exception!));
    }
  }

  Future<void> onGetImageAnalysis(
    GetImageAnalysis event,
    Emitter<RecipesState> emit,
  ) async {
    emit(const RecipesLoading());

    final dataState = await _getImageAnalysisUseCase(params: event.image);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(ImageAnalysisDone(dataState.data!, event.image));
    } else if (dataState is DataFailed) {
      emit(ImageAnalysisError(error: dataState.error!));
    }
  }

  Future<void> onStoreImageAnalysis(
    StoreImageAnalysis event,
    Emitter<RecipesState> emit,
  ) async {
    try {
      await _storeImageAnalysisUseCase(params: {
        'image': event.image,
        'imageAnalysisEntity': event.imageAnalysisEntity,
      });
      emit(const StoreImageAnalysisDone());
    } on Exception catch (e) {
      emit(StoreImageAnalysisError(exception: e));
    }
  }

  Future<void> onDeleteImageAnalysis(
    DeleteImageAnalysis event,
    Emitter<RecipesState> emit,
  ) async {
    try {
      await _deleteImageAnalysisUseCase(params: event.image);
      emit(const DeleteImageAnalysisDone());
    } on Exception catch (e) {
      emit(DeleteImageAnalysisError(exception: e));
    }
  }
}
