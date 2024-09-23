import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:platepal/features/home/bloc/recipes_home_bloc.dart';
import 'package:platepal/features/home/models/random_recipe_model.dart';
import 'package:platepal/features/recipe/screens/recipe_screen.dart';
import 'package:platepal/utilities/constants.dart';
import 'package:platepal/widgets/search_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    context.read<RecipesHomeBloc>().add(RecipesHomeFetchRandomEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Container(
                    color: Theme.of(context).colorScheme.primary,
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                ),
                SafeArea(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          'Welcome to PlatePal',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Anything you want to cook today?',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Gap(20),
                      SearchWidget(_searchController),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const ListTile(
                  title: Text(
                    'Random Recipes',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                BlocBuilder<RecipesHomeBloc, RecipesHomeState>(
                  builder: (context, state) {
                    if (state is RecipesHomeLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is RecipesHomeError) {
                      return Center(
                        child: Text(state.message),
                      );
                    }

                    if (state is RecipesHomeSuccess) {
                      return _buildRandomRecipe(
                          state.randomRecipeModel.recipes!);
                    }

                    return const SizedBox();
                  },
                ),
              ],
            ),
            _buildCategories(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return Column(
      children: [
        const ListTile(
          title: Text(
            'Categories',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListTile(
          title: const Text(
            'Cuisine',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Wrap(
            children: [
              for (final cuisine in cuisines)
                Chip(
                  label: Text(cuisine['name']!),
                ),
            ],
          ),
        ),
        ListTile(
          title: const Text(
            'Diet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Wrap(
            children: [
              for (final diet in diets)
                Chip(
                  label: Text(diet['name']!),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRandomRecipe(List<Recipe>? recipes) {
    List recipesWithImages =
        recipes!.where((element) => element.image != null).toList();

    return SizedBox(
      height: 320,
      child: CarouselView(
        onTap: (index) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => RecipeScreen(
                recipe: recipes[index],
              ),
            ),
          );
        },
        shrinkExtent: MediaQuery.of(context).size.width * 0.6,
        itemExtent: MediaQuery.of(context).size.width * 0.6,
        itemSnapping: false,
        elevation: 4,
        padding: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        children: [
          for (final recipe in recipesWithImages)
            Card(
              margin: const EdgeInsets.all(0),
              child: Column(
                children: [
                  Expanded(
                    child: CachedNetworkImage(
                      imageUrl: recipe.image!,
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
                                          recipe.cheap!
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
                                    recipe.title!,
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
                                Text('${recipe.readyInMinutes} minutes'),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.restaurant),
                                const Gap(4),
                                Text('${recipe.servings} servings'),
                              ],
                            ),
                          ],
                        ),
                        Wrap(
                          children: [
                            if (recipe.dairyFree!)
                              const Icon(
                                Icons.local_drink,
                                size: 16,
                              ),
                            if (recipe.glutenFree!)
                              const Icon(
                                Icons.local_pizza,
                                size: 16,
                              ),
                            if (recipe.vegan!)
                              const Icon(
                                Icons.emoji_food_beverage,
                                size: 16,
                              ),
                            if (recipe.vegetarian!)
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
            ),
        ],
      ),
    );
  }
}
