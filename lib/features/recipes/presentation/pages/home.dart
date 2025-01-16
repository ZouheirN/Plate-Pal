import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:platepal/features/recipes/domain/entities/random_recipes.dart';
import 'package:platepal/features/recipes/presentation/pages/recipe_details.dart';
import 'package:platepal/features/recipes/presentation/widgets/random_recipe_card.dart';
import 'package:platepal/features/recipes/presentation/pages/search_screen.dart';
import 'package:platepal/core/constants/constants.dart';
import 'package:platepal/features/recipes/presentation/widgets/search_widget.dart';

import '../bloc/recipes/recipes_bloc.dart';
import '../bloc/recipes/recipes_event.dart';
import '../bloc/recipes/recipes_state.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();

  final List<bool> _selectedCuisines =
      List.generate(cuisines.length, (index) => false);
  final List<bool> _selectedDiets =
      List.generate(diets.length, (index) => false);

  @override
  void initState() {
    context.read<RecipesBloc>().add(const GetRandomRecipes());
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
                _buildBody(),
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
            'Search by categories',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  _buildBody() {
    return BlocBuilder<RecipesBloc, RecipesState>(
      bloc: context.read<RecipesBloc>(),
      builder: (context, state) {
        if (state is RecipesLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is RandomRecipesError) {
          return Center(
            child: IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                context.read<RecipesBloc>().add(const GetRandomRecipes());
              },
            ),
          );
        }

        if (state is RandomRecipesDone) {
          List<RecipeEntity> recipesWithImages = state.randomRecipes!.recipes!
              .where((element) => element.image != null)
              .toList();

          return SizedBox(
            height: 320,
            child: CarouselView(
              onTap: (index) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RecipeDetails(
                      recipeEntity: recipesWithImages[index],
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
                  RandomRecipeCard(recipeEntity: recipe),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
