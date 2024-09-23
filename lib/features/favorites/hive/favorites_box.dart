import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:platepal/features/home/models/random_recipe_model.dart';
import 'package:platepal/features/recipe/models/recipe_instructions_model.dart';

class FavoritesBox {
  static final Box _box = Hive.box('favoritesBox');

  static void addFavorite(Recipe recipe, List<RecipeInstructionsModel> recipeInstructions) {
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
