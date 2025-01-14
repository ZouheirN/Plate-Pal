import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../home/data/models/random_recipes.dart';
import '../../home/data/models/recipe_instructions.dart';

class FavoritesBox {
  static final Box _box = Hive.box('favoritesBox');

  static void addFavorite(
      RecipeModel recipe, List<RecipeInstructionsModel> recipeInstructions) {
    _box.put(recipe.id, {
      'recipe': recipe.toJson(),
      'instructions': recipeInstructionsModelToJson(recipeInstructions),
    });
  }

  static void removeFavorite(int recipeId) {
    _box.delete(recipeId);
  }

  static bool isFavorite(int recipeId) {
    return _box.containsKey(recipeId);
  }

  static List getFavorites() {
    List<Map> favorites = [];

    for (var key in _box.keys) {
      favorites.add({
        'recipe': RecipeModel.fromJson(
            Map<String, dynamic>.from(_box.get(key)['recipe'])),
        'instructions': recipeInstructionsModelFromJson(
            jsonDecode(_box.get(key)['instructions'])),
      });
    }

    return favorites;
  }

  static ValueListenable<Box> listenable() {
    return _box.listenable();
  }
}
