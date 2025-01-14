import 'package:platepal/core/resources/data_state.dart';
import 'package:platepal/features/home/domain/entities/random_recipes.dart';
import 'package:platepal/features/home/domain/entities/recipe_instructions.dart';

abstract class RecipesRepository {
  // Gets a list of random recipes
  Future<DataState<RandomRecipesEntity>> getRandomRecipes();

  // Gets the instructions for a recipe
  Future<DataState<RecipeInstructionsEntity>> getRecipeInstructions({required String recipeId});
}
