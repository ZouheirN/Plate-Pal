import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:platepal/features/home/bloc/recipes_home_bloc.dart';
import 'package:platepal/features/home/models/random_recipe_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                    height: 250,
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
                      ListTile(
                        title: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const TextField(
                            decoration: InputDecoration(
                              hintText: 'Search for recipes',
                              border: InputBorder.none,
                              icon: Icon(Icons.search),
                            ),
                          ),
                        ),
                      )
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
                  bloc: BlocProvider.of<RecipesHomeBloc>(context)
                    ..add(RecipesHomeFetchRandomEvent()),
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
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: recipes!.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];

        // skip if image is null
        if (recipe.image == null) {
          return const SizedBox();
        }

        return ListTile(
          title: CachedNetworkImage(
            imageUrl: recipe.image!,
            imageBuilder: (context, imageProvider) {
              return Container(
                width: 150,
                height: 250,
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        recipe.title!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
