import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:platepal/features/home/models/random_recipe_model.dart';
import 'package:platepal/features/recipe/models/recipe_instructions_model.dart';

class FavoritesBox {
  static Box box = Hive.box('favoritesBox');

  static void addFavorite(Recipe recipe, List<RecipeInstructionsModel> recipeInstructions) {
    box.put(recipe.id, {
      'recipe': recipe,
      'instructions': recipeInstructions,
    });
  }

  static void removeFavorite(int recipeId) {
    box.delete(recipeId);
  }

  static bool isFavorite(Recipe recipe) {
    return box.containsKey(recipe.id);
  }

  static List getFavorites() {
    return box.values.toList();
  }

  static ValueListenable<Box> listenable() {
    return box.listenable();
  }
}
