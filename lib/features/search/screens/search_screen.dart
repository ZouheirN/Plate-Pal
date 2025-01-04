import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:platepal/features/recipe/bloc/recipe_bloc.dart';
import 'package:platepal/features/search/bloc/recipes_search_bloc.dart';
import 'package:platepal/widgets/search_widget.dart';

import '../../recipe/screens/recipe_screen.dart';

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
  final _recipesSearchBloc = RecipesSearchBloc();
  final _recipeBloc = RecipeBloc();

  @override
  void initState() {
    if (widget.searchController == null) {
      _recipesSearchBloc.add(RecipesSearchByCategoriesFetchEvent(
        widget.cuisines ?? [],
        widget.diets ?? [],
      ));
    } else {
      _recipesSearchBloc
          .add(RecipesSearchFetchEvent(widget.searchController!.text.trim()));
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
              Hero(
                tag: 'search',
                child: SearchWidget(
                  widget.searchController!,
                  pushReplace: true,
                ),
              ),
              const Gap(20),
            ],
            BlocBuilder<RecipesSearchBloc, RecipesSearchState>(
              bloc: _recipesSearchBloc,
              builder: (context, state) {
                if (state is RecipesSearchLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is RecipesSearchError) {
                  return Center(child: Text(state.message));
                } else if (state is RecipesSearchSuccess) {
                  if (state.searchRecipeModel.results?.isEmpty ?? true) {
                    return const Center(child: Text('No results found'));
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.searchRecipeModel.results?.length,
                      itemBuilder: (context, index) {
                        final recipe = state.searchRecipeModel.results?[index];

                        return ListTile(
                          leading: CachedNetworkImage(
                            imageUrl: recipe!.image!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(recipe.title!),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            _recipeBloc
                                .add(RecipeInformationFetchEvent(recipe.id!));
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
            BlocListener<RecipeBloc, RecipeState>(
              bloc: _recipeBloc,
              listener: (context, state) {
                if (state is RecipeInformationSuccess) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RecipeScreen(
                        recipe: state.recipe,
                      ),
                    ),
                  );
                }
              },
              child: const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
