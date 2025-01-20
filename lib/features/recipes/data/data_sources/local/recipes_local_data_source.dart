import 'package:hive_ce/hive.dart';
import 'package:platepal/features/recipes/data/models/random_recipes.dart';
import 'package:platepal/features/recipes/data/models/recipe_instructions.dart';
import 'package:platepal/features/recipes/data/models/search_recipe.dart';
import 'package:platepal/features/recipes/data/models/similar_recipes.dart';

abstract interface class RecipesLocalDataSource {
  Future<void> storeRandomRecipes({
    required RandomRecipesModel recipes,
  });

  RandomRecipesModel? loadRandomRecipes();

  Future<void> storeRecipeInstructions({
    required List<RecipeInstructionsModel> instructions,
    required int recipeId,
  });

  List<RecipeInstructionsModel>? loadRecipeInstructions({
    required int recipeId,
  });

  Future<void> storeSimilarRecipes({
    required List<SimilarRecipesModel> similarRecipes,
    required int recipeId,
  });

  List<SimilarRecipesModel>? loadSimilarRecipes({
    required int recipeId,
  });

  Future<void> storeRecipeInformation({
    required RecipeModel recipe,
    required int recipeId,
  });

  RecipeModel? loadRecipeInformation({
    required int recipeId,
  });

  Future<void> storeSearchRecipes({
    required SearchRecipeModel recipes,
    required String query,
  });

  SearchRecipeModel? loadSearchRecipes({
    required String query,
  });

  Future<void> storeSearchRecipesByCategories({
    required SearchRecipeModel recipes,
    required String cuisines,
    required String diets,
  });

  SearchRecipeModel? loadSearchRecipesByCategories({
    required String cuisines,
    required String diets,
  });
}

class RecipesLocalDataSourceImpl implements RecipesLocalDataSource {
  final Box box;

  RecipesLocalDataSourceImpl({required this.box});

  @override
  Future<void> storeRandomRecipes({required RandomRecipesModel recipes}) async {
    await box.clear();
    await box.put('randomRecipes', recipes);
  }

  @override
  RandomRecipesModel? loadRandomRecipes() {
    return box.get('randomRecipes');
  }

  @override
  Future<void> storeRecipeInstructions({
    required List<RecipeInstructionsModel> instructions,
    required int recipeId,
  }) async {
    await box.clear();
    await box.put('recipeInstructions+$recipeId', instructions);
  }

  @override
  List<RecipeInstructionsModel>? loadRecipeInstructions({
    required int recipeId,
  }) {
    return box.get('recipeInstructions+$recipeId');
  }

  @override
  Future<void> storeSimilarRecipes({
    required List<SimilarRecipesModel> similarRecipes,
    required int recipeId,
  }) async {
    await box.clear();
    await box.put('similarRecipes+$recipeId', similarRecipes);
  }

  @override
  List<SimilarRecipesModel>? loadSimilarRecipes({
    required int recipeId,
  }) {
    return box.get('similarRecipes+$recipeId');
  }

  @override
  Future<void> storeRecipeInformation({
    required RecipeModel recipe,
    required int recipeId,
  }) async {
    await box.clear();
    await box.put('recipeInformation+$recipeId', recipe);
  }

  @override
  RecipeModel? loadRecipeInformation({
    required int recipeId,
  }) {
    return box.get('recipeInformation+$recipeId');
  }

  @override
  Future<void> storeSearchRecipes({
    required SearchRecipeModel recipes,
    required String query,
  }) async {
    await box.clear();
    await box.put('searchRecipes+$query', recipes);
  }

  @override
  SearchRecipeModel? loadSearchRecipes({
    required String query,
  }) {
    return box.get('searchRecipes+$query');
  }

  @override
  Future<void> storeSearchRecipesByCategories({
    required SearchRecipeModel recipes,
    required String cuisines,
    required String diets,
  }) async {
    await box.clear();
    await box.put('searchRecipesByCategories+$cuisines+$diets', recipes);
  }

  @override
  SearchRecipeModel? loadSearchRecipesByCategories({
    required String cuisines,
    required String diets,
  }) {
    return box.get('searchRecipesByCategories+$cuisines+$diets');
  }
}
