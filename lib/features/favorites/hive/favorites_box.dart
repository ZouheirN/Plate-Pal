import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:platepal/features/recipes/domain/entities/random_recipes.dart';
import 'package:platepal/features/recipes/domain/entities/recipe_instructions.dart';

class FavoritesBox {
  static final Box _box = Hive.box('favoritesBox');

  static void addFavorite(
      RecipeEntity recipe, List<RecipeInstructionsEntity> recipeInstructions) {
    _box.put(recipe.id, {
      'recipe': recipe,
      'instructions': recipeInstructions,
    });
  }

  static void removeFavorite(int recipeId) {
    _box.delete(recipeId);
  }

  static bool isFavorite(int recipeId) {
    return _box.containsKey(recipeId);
  }

  static List getFavorites() {
    return _box.values.toList();
  }

  static ValueListenable<Box> listenable() {
    return _box.listenable();
  }
}
