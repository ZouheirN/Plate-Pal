import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:platepal/features/recipes/presentation/bloc/recipes/recipes_event.dart';
import 'package:platepal/features/recipes/presentation/bloc/recipes/recipes_state.dart';
import 'package:platepal/features/recipes/presentation/pages/recipe_details.dart';
import 'package:platepal/features/recipes/presentation/widgets/search_widget.dart';

import '../../../../injection_container.dart';
import '../bloc/recipes/recipes_bloc.dart';

class SearchScreen extends StatefulWidget {
  final TextEditingController? searchController;
  final List<String>? cuisines;
  final List<String>? diets;

  const SearchScreen({
    super.key,
    this.searchController,
    this.cuisines,
    this.diets,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _recipesSearchBloc = sl<RecipesBloc>();
  final _recipeBloc = sl<RecipesBloc>();

  bool isLoading = false;

  @override
  void initState() {
    if (widget.searchController == null) {
      _recipesSearchBloc.add(SearchRecipesByCategories(
        widget.cuisines ?? [],
        widget.diets ?? [],
      ));
    } else {
      _recipesSearchBloc
          .add(SearchRecipes(query: widget.searchController!.text.trim()));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.searchController == null
          ? AppBar(
              title: const Text('Search by categories'),
            )
          : null,
      body: SafeArea(
        child: Column(
          children: [
            if (widget.searchController != null) ...[
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Expanded(
                    child: Hero(
                      tag: 'search',
                      child: SearchWidget(
                        widget.searchController!,
                        pushReplace: true,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(20),
            ],
            BlocBuilder<RecipesBloc, RecipesState>(
              bloc: _recipesSearchBloc,
              builder: (context, state) {
                if (state is RecipesLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SearchRecipesError) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.error),
                        Gap(8),
                        Text('Error loading recipes'),
                      ],
                    ),
                  );
                } else if (state is SearchRecipesDone) {
                  if (state.searchRecipe!.results?.isEmpty ?? true) {
                    return const Center(child: Text('No results found'));
                  }

                  return Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: state.searchRecipe!.results!.length,
                      separatorBuilder: (context, index) {
                        return const Gap(8);
                      },
                      itemBuilder: (context, index) {
                        final recipe = state.searchRecipe!.results?[index];

                        return ListTile(
                          leading: CachedNetworkImage(
                            imageUrl: recipe!.image!,
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              );
                            },
                            errorWidget: (context, url, error) {
                              return const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.error),
                                  Gap(8),
                                  Text('Error loading image'),
                                ],
                              );
                            },
                            progressIndicatorBuilder: (context, url, progress) {
                              return Center(
                                child: CircularProgressIndicator(
                                  value: progress.progress,
                                ),
                              );
                            },
                          ),
                          title: Text(recipe.title!),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            if (isLoading) {
                              return;
                            }

                            isLoading = true;

                            _recipeBloc.add(
                                GetRecipeInformation(recipeId: recipe.id!));
                          },
                        );
                      },
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            BlocListener<RecipesBloc, RecipesState>(
              bloc: _recipeBloc,
              listener: (context, state) {
                if (state is RecipeInformationDone) {
                  isLoading = false;

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RecipeDetails(
                        recipeEntity: state.recipe!,
                      ),
                    ),
                  );
                }
              },
              child: const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
