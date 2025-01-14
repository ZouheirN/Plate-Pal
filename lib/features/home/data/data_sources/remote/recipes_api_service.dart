import 'package:dio/dio.dart';
import 'package:platepal/core/constants/constants.dart';
import 'package:platepal/features/home/data/models/random_recipes.dart';
import 'package:platepal/features/home/data/models/recipe_instructions.dart';
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
  Future<HttpResponse<RecipeInstructionsModel>> getRecipeInstructions({
    @Path('id') String? id,
    @Query('apiKey') String? apiKey,
  });
}
