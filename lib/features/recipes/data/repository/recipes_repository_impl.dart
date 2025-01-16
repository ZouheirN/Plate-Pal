import 'dart:io';

import 'package:dio/dio.dart';
import 'package:platepal/core/cache/cache_box.dart';
import 'package:platepal/core/constants/constants.dart';
import 'package:platepal/core/resources/data_state.dart';
import 'package:platepal/features/recipes/data/data_sources/remote/recipes_api_service.dart';
import 'package:platepal/features/recipes/data/models/random_recipes.dart';
import 'package:platepal/features/recipes/data/models/recipe_instructions.dart';
import 'package:platepal/features/recipes/data/models/search_recipe.dart';
import 'package:platepal/features/recipes/data/models/similar_recipes.dart';
import 'package:platepal/features/recipes/domain/repository/recipes_repository.dart';

class RecipesRepositoryImpl implements RecipesRepository {
  final RecipesApiService _recipesApiService;

  RecipesRepositoryImpl(this._recipesApiService);

  @override
  Future<DataState<RandomRecipesModel>> getRandomRecipes() async {
    try {
      final httpResponse = await _recipesApiService.getRandomRecipes(
        apiKey: apiKey,
        includeNutrition: 'false',
        number: '10',
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        CacheBox.putCache('getRandomRecipes', httpResponse.data);

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
        final cache = CacheBox.getCache('getRandomRecipes');

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
        CacheBox.putCache('getRecipeInstructions+$recipeId', httpResponse.data);

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
        final cache = CacheBox.getCache('getRecipeInstructions+$recipeId');

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
        CacheBox.putCache('getSimilarRecipes+$recipeId', httpResponse.data);

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
        final cache = CacheBox.getCache('getSimilarRecipes+$recipeId');

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
        CacheBox.putCache('getRecipeInformation+$recipeId', httpResponse.data);

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
        final cache = CacheBox.getCache('getRecipeInformation+$recipeId');

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
        CacheBox.putCache('searchRecipes+$query', httpResponse.data);

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
        final cache = CacheBox.getCache('searchRecipes+$query');

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
        CacheBox.putCache(
            'searchRecipesByCategories+$cuisines+$diets', httpResponse.data);

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
        final cache =
            CacheBox.getCache('searchRecipesByCategories+$cuisines+$diets');

        if (cache == null) {
          return DataFailed(e);
        }

        return DataSuccess(cache);
      }

      return DataFailed(e);
    }
  }
}
