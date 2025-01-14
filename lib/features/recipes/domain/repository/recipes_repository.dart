import 'package:platepal/core/resources/data_state.dart';
import 'package:platepal/features/recipes/domain/entities/random_recipes.dart';
import 'package:platepal/features/recipes/domain/entities/recipe_instructions.dart';
import 'package:platepal/features/recipes/domain/entities/search_recipe.dart';
import 'package:platepal/features/recipes/domain/entities/similar_recipes.dart';

abstract class RecipesRepository {
  // Gets a list of random recipes
  Future<DataState<RandomRecipesEntity>> getRandomRecipes();

  // Gets the instructions for a recipes
  Future<DataState<List<RecipeInstructionsEntity>>> getRecipeInstructions({
    required int recipeId,
  });

  // Gets similar recipes
  Future<DataState<List<SimilarRecipesEntity>>> getSimilarRecipes({
    required int recipeId,
  });

  // Get recipe information
  Future<DataState<RecipeEntity>> getRecipeInformation({
    required int recipeId,
  });

  // Search recipe
  Future<DataState<SearchRecipeEntity>> searchRecipes({
    required String query,
  });

  // Search recipes by categories
  Future<DataState<SearchRecipeEntity>> searchRecipesByCategories({
    required String cuisines,
    required String diets,
  });
}
