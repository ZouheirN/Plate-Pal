import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:platepal/features/home/bloc/recipes_home_bloc.dart';
import 'package:platepal/features/home/models/random_recipe_model.dart';
import 'package:platepal/features/recipe/screens/recipe_screen.dart';
import 'package:platepal/features/search/screens/search_screen.dart';
import 'package:platepal/utilities/constants.dart';
import 'package:platepal/widgets/search_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<bool> _selectedCuisines =
      List.generate(cuisines.length, (index) => false);
  final List<bool> _selectedDiets =
      List.generate(diets.length, (index) => false);

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
                      Hero(
                        tag: 'search',
                        child:
                            SearchWidget(_searchController, pushReplace: false),
                      ),
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
            const Gap(20),
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
            runAlignment: WrapAlignment.start,
            runSpacing: 8,
            spacing: 8,
            alignment: WrapAlignment.spaceEvenly,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              for (final cuisine in cuisines)
                ChoiceChip(
                  label: Text(cuisine['name']!),
                  selected: _selectedCuisines[cuisines.indexOf(cuisine)],
                  onSelected: (value) {
                    setState(() {
                      _selectedCuisines[cuisines.indexOf(cuisine)] = value;
                    });
                  },
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
            runAlignment: WrapAlignment.start,
            runSpacing: 8,
            spacing: 8,
            alignment: WrapAlignment.spaceEvenly,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              for (final diet in diets)
                ChoiceChip(
                  label: Text(diet['name']!),
                  selected: _selectedDiets[diets.indexOf(diet)],
                  onSelected: (value) {
                    setState(() {
                      _selectedDiets[diets.indexOf(diet)] = value;
                    });
                  },
                ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            List<String> selectedCuisines = [];
            List<String> selectedDiets = [];

            if (_selectedCuisines.every((element) => element == false) &&
                _selectedDiets.every((element) => element == false)) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Error'),
                    content: const Text('Please select at least one category.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );

              return;
            }

            for (int i = 0; i < _selectedCuisines.length; i++) {
              if (_selectedCuisines[i]) {
                selectedCuisines.add(cuisines[i]['name']!);
              }
            }

            for (int i = 0; i < _selectedDiets.length; i++) {
              if (_selectedDiets[i]) {
                selectedDiets.add(diets[i]['name']!);
              }
            }

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchScreen(
                  cuisines: selectedCuisines,
                  diets: selectedDiets,
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          child: const Text(
            'Search with categories',
            style: TextStyle(color: Colors.white),
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
                recipe: recipesWithImages[index],
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
