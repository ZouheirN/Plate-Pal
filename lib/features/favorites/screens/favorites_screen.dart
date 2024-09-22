import 'package:flutter/material.dart';
import 'package:platepal/features/recipe/screens/recipe_screen.dart';
import 'package:platepal/hive/favorites_box.dart';
import 'package:platepal/main.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: FavoritesBox.listenable(),
      builder: (context, value, child) {
        final favorites = FavoritesBox.getFavorites();

        logger.i(favorites);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Favorites'),
          ),
          body: ListView(
            children: [
              for (var favorite in favorites)
                Dismissible(
                  key: Key(favorite['recipe'].id.toString()),
                  onDismissed: (direction) {
                    FavoritesBox.removeFavorite(favorite['recipe'].id);
                  },
                  background: Container(
                    color: Colors.red,
                    child: const Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeScreen(
                            recipe: favorite['recipe'],
                          ),
                        ),
                      );
                    },
                    leading: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(favorite['recipe'].image),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ]),
                      height: 50,
                      width: 50,
                    ),
                    title: Text(favorite['recipe'].title),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}