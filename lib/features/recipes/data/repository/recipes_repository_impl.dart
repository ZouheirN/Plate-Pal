import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:platepal/core/constants/constants.dart';
import 'package:platepal/core/resources/data_state.dart';
import 'package:platepal/features/recipes/data/data_sources/local/recipes_local_data_source.dart';
import 'package:platepal/features/recipes/data/data_sources/remote/recipes_api_service.dart';
import 'package:platepal/features/recipes/data/models/image_analysis.dart';
import 'package:platepal/features/recipes/data/models/random_recipes.dart';
import 'package:platepal/features/recipes/data/models/recipe_instructions.dart';
import 'package:platepal/features/recipes/data/models/search_recipe.dart';
import 'package:platepal/features/recipes/data/models/similar_recipes.dart';
import 'package:platepal/features/recipes/domain/entities/image_analysis.dart';
import 'package:platepal/features/recipes/domain/repository/recipes_repository.dart';

class RecipesRepositoryImpl implements RecipesRepository {
  final RecipesApiService _recipesApiService;
  final RecipesLocalDataSource _recipesLocalDataSource;

  RecipesRepositoryImpl(this._recipesApiService, this._recipesLocalDataSource);

  @override
  Future<DataState<RandomRecipesModel>> getRandomRecipes() async {
    try {
      final httpResponse = await _recipesApiService.getRandomRecipes(
        apiKey: apiKey,
        includeNutrition: 'false',
        number: '10',
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        _recipesLocalDataSource.storeRandomRecipes(recipes: httpResponse.data);

        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      if (e.error.runtimeType == SocketException) {
        final cache = _recipesLocalDataSource.loadRandomRecipes();

        if (cache == null) {
          return DataFailed(e);
        }

        return DataSuccess(cache);
      }

      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<RecipeInstructionsModel>>> getRecipeInstructions({
    required int recipeId,
  }) async {
    try {
      final httpResponse = await _recipesApiService.getRecipeInstructions(
        id: recipeId,
        apiKey: apiKey,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        _recipesLocalDataSource.storeRecipeInstructions(
          recipeId: recipeId,
          instructions: httpResponse.data,
        );

        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      if (e.error.runtimeType == SocketException) {
        final cache = _recipesLocalDataSource.loadRecipeInstructions(
          recipeId: recipeId,
        );

        if (cache == null) {
          return DataFailed(e);
        }

        return DataSuccess(cache);
      }

      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<SimilarRecipesModel>>> getSimilarRecipes({
    required int recipeId,
  }) async {
    try {
      final httpResponse = await _recipesApiService.getSimilarRecipes(
        id: recipeId,
        apiKey: apiKey,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        _recipesLocalDataSource.storeSimilarRecipes(
          recipeId: recipeId,
          similarRecipes: httpResponse.data,
        );

        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      if (e.error.runtimeType == SocketException) {
        final cache = _recipesLocalDataSource.loadSimilarRecipes(
          recipeId: recipeId,
        );

        if (cache == null) {
          return DataFailed(e);
        }

        return DataSuccess(cache);
      }

      return DataFailed(e);
    }
  }

  @override
  Future<DataState<RecipeModel>> getRecipeInformation({
    required int recipeId,
  }) async {
    try {
      final httpResponse = await _recipesApiService.getRecipeInformation(
        id: recipeId,
        apiKey: apiKey,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        _recipesLocalDataSource.storeRecipeInformation(
          recipe: httpResponse.data,
          recipeId: recipeId,
        );

        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      if (e.error.runtimeType == SocketException) {
        final cache = _recipesLocalDataSource.loadRecipeInformation(
          recipeId: recipeId,
        );

        if (cache == null) {
          return DataFailed(e);
        }

        return DataSuccess(cache);
      }

      return DataFailed(e);
    }
  }

  @override
  Future<DataState<SearchRecipeModel>> searchRecipes({
    required String query,
  }) async {
    try {
      final httpResponse = await _recipesApiService.searchRecipes(
        apiKey: apiKey,
        query: query,
        includeNutrition: 'false',
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        _recipesLocalDataSource.storeSearchRecipes(
          query: query,
          recipes: httpResponse.data,
        );

        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      if (e.error.runtimeType == SocketException) {
        final cache = _recipesLocalDataSource.loadSearchRecipes(
          query: query,
        );

        if (cache == null) {
          return DataFailed(e);
        }

        return DataSuccess(cache);
      }

      return DataFailed(e);
    }
  }

  @override
  Future<DataState<SearchRecipeModel>> searchRecipesByCategories({
    required String cuisines,
    required String diets,
  }) async {
    try {
      final httpResponse = await _recipesApiService.searchRecipesByCategories(
        apiKey: apiKey,
        includeNutrition: 'false',
        cuisine: cuisines,
        diet: diets,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        _recipesLocalDataSource.storeSearchRecipesByCategories(
          cuisines: cuisines,
          diets: diets,
          recipes: httpResponse.data,
        );

        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      if (e.error.runtimeType == SocketException) {
        final cache = _recipesLocalDataSource.loadSearchRecipesByCategories(
          cuisines: cuisines,
          diets: diets,
        );

        if (cache == null) {
          return DataFailed(e);
        }

        return DataSuccess(cache);
      }

      return DataFailed(e);
    }
  }

  @override
  Future<DataState<ValueListenable>> getRecipeAnalysis() async {
    final valueListenable = _recipesLocalDataSource.getRecipeAnalysis();

    if (valueListenable != null) {
      return DataSuccess(valueListenable);
    } else {
      return DataFailed(
        null,
        exception: Exception('Value listenable is null'),
      );
    }
  }

  @override
  Future<DataState<ImageAnalysisEntity>> getImageAnalysis({
    required File image,
  }) async {
    try {
      final httpResponse = await _recipesApiService.getImageAnalysis(
        apiKey: apiKey,
        file: image,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<void> storeImageAnalysis({
    required File image,
    required ImageAnalysisEntity imageAnalysisEntity,
  }) {
    final imageAnalysisModel = ImageAnalysisModel(
      recipes: imageAnalysisEntity.recipes,
      category: imageAnalysisEntity.category,
      nutrition: imageAnalysisEntity.nutrition,
    );

    return _recipesLocalDataSource.storeImageAnalysis(
      image: image,
      imageAnalysis: imageAnalysisModel,
    );
  }
}
