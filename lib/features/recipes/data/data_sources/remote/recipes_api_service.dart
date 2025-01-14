import 'package:dio/dio.dart';
import 'package:platepal/core/constants/constants.dart';
import 'package:platepal/features/recipes/data/models/random_recipes.dart';
import 'package:platepal/features/recipes/data/models/recipe_instructions.dart';
import 'package:platepal/features/recipes/data/models/search_recipe.dart';
import 'package:platepal/features/recipes/data/models/similar_recipes.dart';
import 'package:retrofit/retrofit.dart';

part 'recipes_api_service.g.dart';

@RestApi(baseUrl: recipesAPIBaseURL)
abstract class RecipesApiService {
  factory RecipesApiService(Dio dio) = _RecipesApiService;

  @GET('/recipes/random')
  Future<HttpResponse<RandomRecipesModel>> getRandomRecipes({
    @Query('apiKey') String? apiKey,
    @Query('number') String? number,
    @Query('includeNutrition') String? includeNutrition,
  });

  @GET('/recipes/{id}/analyzedInstructions')
  Future<HttpResponse<List<RecipeInstructionsModel>>> getRecipeInstructions({
    @Path('id') int? id,
    @Query('apiKey') String? apiKey,
  });

  @GET('/recipes/{id}/similar')
  Future<HttpResponse<List<SimilarRecipesModel>>> getSimilarRecipes({
    @Path('id') int? id,
    @Query('apiKey') String? apiKey,
  });

  @GET('/recipes/{id}/information')
  Future<HttpResponse<RecipeModel>> getRecipeInformation({
    @Path('id') int? id,
    @Query('apiKey') String? apiKey,
  });

  @GET('/recipes/complexSearch')
  Future<HttpResponse<SearchRecipeModel>> searchRecipes({
    @Query('apiKey') String? apiKey,
    @Query('query') String? query,
    @Query('includeNutrition') String? includeNutrition,
  });

  @GET('/recipes/complexSearch')
  Future<HttpResponse<SearchRecipeModel>> searchRecipesByCategories({
    @Query('apiKey') String? apiKey,
    @Query('cuisine') String? cuisine,
    @Query('diet') String? diet,
    @Query('includeNutrition') String? includeNutrition,
  });
}
