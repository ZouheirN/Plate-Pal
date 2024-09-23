import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'package:platepal/features/favorites/hive/favorites_box.dart';
import 'package:platepal/features/home/models/random_recipe_model.dart';
import 'package:platepal/features/recipe/bloc/recipe_bloc.dart';
import 'package:platepal/features/recipe/models/recipe_instructions_model.dart';
import 'package:platepal/widgets/instructions_widget.dart';
import 'package:tap_to_expand/tap_to_expand.dart';

class RecipeScreen extends StatefulWidget {
  final Recipe recipe;
  final List<RecipeInstructionsModel>? recipeInstructionsModel;

  const RecipeScreen(
      {super.key, required this.recipe, this.recipeInstructionsModel});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  final _recipeBloc = RecipeBloc();
  final _similarRecipeBloc = RecipeBloc();

  @override
  void initState() {
    if (widget.recipeInstructionsModel != null) {
      _recipeBloc
          .add(RecipeInstructionSuccessEvent(widget.recipeInstructionsModel!));
    } else {
      _recipeBloc.add(RecipeInstructionFetchEvent(widget.recipe.id!));
    }
    _similarRecipeBloc.add(SimilarRecipesFetchEvent(widget.recipe.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      alwaysShowLeadingAndAction: true,
      title: Text(
        widget.recipe.title!,
      ),
      actions: [
        IconButton(
          onPressed: () {
            if (FavoritesBox.isFavorite(widget.recipe.id!)) {
              FavoritesBox.removeFavorite(widget.recipe.id!);
            } else {
              if (widget.recipeInstructionsModel == null) {
                final instructions =
                    _recipeBloc.state as RecipeInstructionSuccess;

                FavoritesBox.addFavorite(
                  widget.recipe,
                  instructions.recipeInstructionModel,
                );
              } else {
                FavoritesBox.addFavorite(
                  widget.recipe,
                  widget.recipeInstructionsModel!,
                );
              }
            }
          },
          icon: ValueListenableBuilder(
            valueListenable: FavoritesBox.listenable(),
            builder: (context, Box box, child) {
              if (FavoritesBox.isFavorite(widget.recipe.id!)) {
                return const Icon(Icons.favorite);
              } else {
                return const Icon(Icons.favorite_border);
              }
            },
          ),
        ),
      ],
      headerWidget: Image.network(
        widget.recipe.image!,
        fit: BoxFit.cover,
        height: 200,
        width: double.infinity,
      ),
      body: [
        Text(
          widget.recipe.title!,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: HtmlWidget(
            widget.recipe.summary!,
          ),
        ),
        TapToExpand(
          duration: const Duration(milliseconds: 300),
          outerClosedPadding: 8,
          titlePadding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          content: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.recipe.extendedIngredients!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  widget.recipe.extendedIngredients![index].name!,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  widget.recipe.extendedIngredients![index].original!,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              );
            },
          ),
          title: const Text(
            'Ingredients',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        const Gap(16),
        BlocBuilder<RecipeBloc, RecipeState>(
          bloc: _recipeBloc,
          builder: (context, state) {
            if (state is RecipeInstructionLoading) {
              return const CircularProgressIndicator();
            } else if (state is RecipeInstructionSuccess) {
              return TapToExpand(
                duration: const Duration(milliseconds: 300),
                backgroundcolor: Colors.white,
                iconColor: Colors.black,
                outerClosedPadding: 8,
                titlePadding:
                    const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                title: const Text(
                  'Instructions',
                  style: TextStyle(
                    // color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                content: InstructionsWidget(
                    recipeInstructionsModel: state.recipeInstructionModel),
              );
            } else if (state is RecipeInstructionError) {
              return Text(state.message.toString());
            } else {
              return const SizedBox();
            }
          },
        ),
        const Gap(16),
        BlocBuilder<RecipeBloc, RecipeState>(
          bloc: _similarRecipeBloc,
          builder: (context, state) {
            if (state is SimilarRecipesSuccess) {
              return ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8),
                children: [
                  const Text(
                    'Also check out these recipes',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(8),
                  for (var recipe in state.similarRecipes)
                    Card(
                      child: ListTile(
                        title: Text(recipe.title!),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      ),
                    ),
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}
