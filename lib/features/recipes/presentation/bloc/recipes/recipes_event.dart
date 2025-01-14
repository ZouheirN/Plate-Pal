import 'package:platepal/features/recipes/domain/entities/recipe_instructions.dart';

abstract class RecipesEvent {
  const RecipesEvent();
}

class GetRandomRecipes extends RecipesEvent {
  const GetRandomRecipes();
}

class GetRecipeInstructions extends RecipesEvent {
  final int recipeId;

  const GetRecipeInstructions({required this.recipeId});
}

class EmitRecipeInstructionsSuccess extends RecipesEvent {
  final List<RecipeInstructionsEntity> recipeInstructionsEntity;

  EmitRecipeInstructionsSuccess({required this.recipeInstructionsEntity});
}

class GetSimilarRecipes extends RecipesEvent {
  final int recipeId;

  const GetSimilarRecipes({required this.recipeId});
}

class GetRecipeInformation extends RecipesEvent {
  final int recipeId;

  const GetRecipeInformation({required this.recipeId});
}
