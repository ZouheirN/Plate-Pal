import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:platepal/features/recipes/domain/entities/random_recipes.dart';

class RandomRecipeCard extends StatelessWidget {
  final RecipeEntity recipeEntity;

  const RandomRecipeCard({super.key, required this.recipeEntity});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      child: Column(
        children: [
          Expanded(
            child: CachedNetworkImage(
              imageUrl: recipeEntity.image!,
              imageBuilder: (context, imageProvider) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black,
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Spacer(),
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 14,
                                child: Icon(
                                  recipeEntity.cheap!
                                      ? Icons.monetization_on
                                      : Icons.money_off,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8, left: 8, right: 8),
                          child: Text(
                            recipeEntity.title!,
                            style: const TextStyle(
                              color: Colors.white,
                              // fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.access_time),
                        const Gap(4),
                        Text('${recipeEntity.readyInMinutes} minutes'),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.restaurant),
                        const Gap(4),
                        Text('${recipeEntity.servings} servings'),
                      ],
                    ),
                  ],
                ),
                Wrap(
                  children: [
                    if (recipeEntity.dairyFree!)
                      const Icon(
                        Icons.local_drink,
                        size: 16,
                      ),
                    if (recipeEntity.glutenFree!)
                      const Icon(
                        Icons.local_pizza,
                        size: 16,
                      ),
                    if (recipeEntity.vegan!)
                      const Icon(
                        Icons.emoji_food_beverage,
                        size: 16,
                      ),
                    if (recipeEntity.vegetarian!)
                      const Icon(
                        Icons.emoji_nature,
                        size: 16,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
