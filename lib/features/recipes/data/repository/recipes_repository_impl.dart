import 'dart:io';

import 'package:dio/dio.dart';
import 'package:platepal/core/constants/constants.dart';
import 'package:platepal/core/resources/data_state.dart';
import 'package:platepal/features/recipes/data/data_sources/remote/recipes_api_service.dart';
import 'package:platepal/features/recipes/data/models/random_recipes.dart';
import 'package:platepal/features/recipes/data/models/recipe_instructions.dart';
import 'package:platepal/features/recipes/domain/entities/random_recipes.dart';
import 'package:platepal/features/recipes/domain/entities/similar_recipes.dart';
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
  Future<DataState<List<RecipeInstructionsModel>>> getRecipeInstructions({
    required int recipeId,
  }) async {
    try {
      final httpResponse = await _recipesApiService.getRecipeInstructions(
        id: recipeId,
        apiKey: apiKey,
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
  Future<DataState<List<SimilarRecipesEntity>>> getSimilarRecipes({
    required int recipeId,
  }) async {
    try {
      final httpResponse = await _recipesApiService.getSimilarRecipes(
        id: recipeId,
        apiKey: apiKey,
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
  Future<DataState<RecipeEntity>> getRecipeInformation({
    required int recipeId,
  }) async {
    try {
      final httpResponse = await _recipesApiService.getRecipeInformation(
        id: recipeId,
        apiKey: apiKey,
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
}
