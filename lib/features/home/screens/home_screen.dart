import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:platepal/features/home/bloc/recipes_home_bloc.dart';
import 'package:platepal/features/home/models/random_recipe_model.dart';
import 'package:platepal/features/recipe/screens/recipe_screen.dart';
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
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Here are some random recipes for you',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
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
          ],
        ),
      ),
    );
  }

  Widget _buildRandomRecipe(List<Recipe>? recipes) {
    return SizedBox(
      height: 240,
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
        itemExtent: MediaQuery.of(context).size.width * 0.6,
        itemSnapping: false,
        elevation: 4,
        padding: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        children: [
          for (final recipe in recipes!)
            if (recipe.image != null)
              CachedNetworkImage(
                imageUrl: recipe.image!,
                imageBuilder: (context, imageProvider) {
                  return Container(
                    width: 150,
                    height: 250,
                    decoration: BoxDecoration(
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
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
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
        ],
      ),
    );
  }
}
