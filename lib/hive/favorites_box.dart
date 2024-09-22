import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:platepal/features/home/models/random_recipe_model.dart';

class FavoritesBox {
  static Box box = Hive.box('favoritesBox');

  static void addFavorite(Recipe recipe) {
    box.put(recipe.id, recipe);
  }

  static void removeFavorite(Recipe recipe) {
    box.delete(recipe.id);
  }

  static bool isFavorite(Recipe recipe) {
    return box.containsKey(recipe.id);
  }

  static List<Recipe>? getFavorites() {
    return box.values.toList() as List<Recipe>?;
  }

  static ValueListenable<Box> listenable() {
    return box.listenable();
  }
}
