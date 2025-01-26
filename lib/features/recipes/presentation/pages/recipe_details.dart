import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:hive_ce/hive.dart';
import 'package:platepal/features/favorites/hive/favorites_box.dart';
import 'package:platepal/features/recipes/domain/entities/random_recipes.dart';
import 'package:platepal/features/recipes/domain/entities/recipe_instructions.dart';
import 'package:platepal/features/recipes/presentation/bloc/recipes/recipes_bloc.dart';
import 'package:platepal/features/recipes/presentation/bloc/recipes/recipes_state.dart';
import 'package:platepal/injection_container.dart';
import 'package:platepal/main.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tap_to_expand/tap_to_expand.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../bloc/recipes/recipes_event.dart';
import '../widgets/instructions_widget.dart';

class RecipeDetails extends StatefulWidget {
  final RecipeEntity recipeEntity;
  final List<RecipeInstructionsEntity>? recipeInstructionsEntity;

  const RecipeDetails({
    super.key,
    required this.recipeEntity,
    this.recipeInstructionsEntity,
  });

  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;

  late TabController _tabController;

  final _recipeBloc = sl<RecipesBloc>();
  final _similarRecipeBloc = sl<RecipesBloc>();
  final _similarRecipeBlocClick = sl<RecipesBloc>();

  @override
  void initState() {
    if (widget.recipeInstructionsEntity != null) {
      _recipeBloc.add(EmitRecipeInstructionsSuccess(
          recipeInstructionsEntity: widget.recipeInstructionsEntity!));
    } else {
      logger.d('Getting recipe instructions');
      _recipeBloc.add(GetRecipeInstructions(recipeId: widget.recipeEntity.id!));
    }

    _similarRecipeBloc
        .add(GetSimilarRecipes(recipeId: widget.recipeEntity.id!));

    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      alwaysShowLeadingAndAction: true,
      title: Text(
        widget.recipeEntity.title!,
        textAlign: TextAlign.center,
      ),
      actions: [
        if (widget.recipeEntity.sourceUrl != null)
          IconButton(
            onPressed: () {
              Share.share(
                'Check out this recipe I found on PlatePal: ${widget.recipeEntity.sourceUrl}',
              );
            },
            icon: const Icon(Icons.share),
          ),
        IconButton(
          onPressed: () {
            if (_recipeBloc.state is RecipesLoading) {
              return;
            }

            if (FavoritesBox.isFavorite(widget.recipeEntity.id!)) {
              FavoritesBox.removeFavorite(widget.recipeEntity.id!);
            } else {
              if (widget.recipeInstructionsEntity == null) {
                final instructions =
                    _recipeBloc.state as RecipeInstructionsDone;

                FavoritesBox.addFavorite(
                  widget.recipeEntity,
                  instructions.recipeInstructions!,
                );
              } else {
                FavoritesBox.addFavorite(
                  widget.recipeEntity,
                  widget.recipeInstructionsEntity!,
                );
              }
            }
          },
          icon: BlocBuilder<RecipesBloc, RecipesState>(
            bloc: _recipeBloc,
            builder: (context, state) {
              return ValueListenableBuilder(
                valueListenable: FavoritesBox.listenable(),
                builder: (context, Box box, child) {
                  double opacity = 1;

                  if (state is RecipesLoading) {
                    opacity = 0.5;
                  }

                  if (FavoritesBox.isFavorite(widget.recipeEntity.id!)) {
                    return Opacity(
                        opacity: opacity, child: const Icon(Icons.favorite));
                  } else {
                    return Opacity(
                        opacity: opacity,
                        child: const Icon(Icons.favorite_border));
                  }
                },
              );
            },
          ),
        ),
      ],
      headerWidget: CachedNetworkImage(
        imageUrl: widget.recipeEntity.image!,
        fit: BoxFit.cover,
        height: 200,
        width: double.infinity,
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
      body: [
        Text(
          widget.recipeEntity.title!,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: HtmlWidget(
            widget.recipeEntity.summary!,
            onTapUrl: (url) {
              launchUrlString(url);

              return true;
            },
          ),
        ),
        const Gap(16),
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              icon: Icon(Icons.info),
              text: 'Recipe Information',
            ),
            Tab(
              icon: Icon(Icons.brunch_dining),
              text: 'Dish Types',
            ),
          ],
        ),
        AutoScaleTabBarView(
          controller: _tabController,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.access_time),
                            title: const Text(
                              'Required Time',
                            ),
                            trailing: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '${widget.recipeEntity.readyInMinutes} minutes',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.monetization_on,
                            ),
                            title: const Text(
                              'Cheap',
                            ),
                            trailing: Icon(
                              widget.recipeEntity.cheap!
                                  ? Icons.check
                                  : Icons.close,
                              color: widget.recipeEntity.cheap!
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.local_drink,
                            ),
                            title: const Text(
                              'Dairy Free',
                            ),
                            trailing: Icon(
                              widget.recipeEntity.dairyFree!
                                  ? Icons.check
                                  : Icons.close,
                              color: widget.recipeEntity.dairyFree!
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.local_pizza,
                            ),
                            title: const Text(
                              'Gluten Free',
                            ),
                            trailing: Icon(
                              widget.recipeEntity.glutenFree!
                                  ? Icons.check
                                  : Icons.close,
                              color: widget.recipeEntity.glutenFree!
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.emoji_food_beverage,
                            ),
                            title: const Text(
                              'Vegan',
                            ),
                            trailing: Icon(
                              widget.recipeEntity.vegan!
                                  ? Icons.check
                                  : Icons.close,
                              color: widget.recipeEntity.vegan!
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.emoji_nature,
                            ),
                            title: const Text(
                              'Vegetarian',
                            ),
                            trailing: Icon(
                              widget.recipeEntity.vegetarian!
                                  ? Icons.check
                                  : Icons.close,
                              color: widget.recipeEntity.vegetarian!
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var dishType in widget.recipeEntity.dishTypes!)
                            ListTile(
                              title: Text(
                                "${dishType[0].toUpperCase()}${dishType.substring(1)}",
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const Gap(16),
        TapToExpand(
          duration: const Duration(milliseconds: 300),
          titlePadding: const EdgeInsets.only(left: 8, right: 8, bottom: 24),
          content: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.recipeEntity.extendedIngredients!.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.white.withValues(alpha: 0.8),
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: ListTile(
                  title: Text(
                    "${widget.recipeEntity.extendedIngredients![index].name![0].toUpperCase()}${widget.recipeEntity.extendedIngredients![index].name!.substring(1)}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "${widget.recipeEntity.extendedIngredients![index].original![0].toUpperCase()}${widget.recipeEntity.extendedIngredients![index].original!.substring(1)}",
                    style: const TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                ),
              );
            },
          ),
          title: Text(
            'Ingredients (${widget.recipeEntity.extendedIngredients!.length} items)',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Gap(16),
        BlocBuilder<RecipesBloc, RecipesState>(
          bloc: _recipeBloc,
          builder: (context, state) {
            if (state is RecipesLoading) {
              return const CircularProgressIndicator();
            } else if (state is RecipeInstructionsDone) {
              if (state.recipeInstructions!.isEmpty) {
                return const Text(
                  'No instructions found',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }

              return TapToExpand(
                duration: const Duration(milliseconds: 300),
                backgroundcolor: Colors.white,
                iconColor: Colors.black,
                titlePadding:
                    const EdgeInsets.only(left: 8, right: 8, bottom: 24),
                title: Text(
                  'Instructions (${state.recipeInstructions!.first.steps?.length} steps)',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                content: InstructionsWidget(
                    recipeInstructionsEntity: state.recipeInstructions!),
              );
            } else if (state is RecipeInstructionsError) {
              if (state.error != null) {
                return Text(state.error.toString());
              } else if (state.errorDescription != null) {
                return Text(state.errorDescription.toString());
              } else {
                return const SizedBox();
              }
            } else {
              return const SizedBox();
            }
          },
        ),
        const Gap(16),
        BlocBuilder<RecipesBloc, RecipesState>(
          bloc: _similarRecipeBloc,
          builder: (context, state) {
            if (state is SimilarRecipesDone) {
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
                  for (var recipes in state.similarRecipes!)
                    Card(
                      child: ListTile(
                        title: Text(recipes.title!),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.access_time),
                                const Gap(4),
                                Text('${recipes.readyInMinutes} minutes'),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.restaurant),
                                const Gap(4),
                                Text('${recipes.servings} servings'),
                              ],
                            ),
                          ],
                        ),
                        onTap: () {
                          if (isLoading) {
                            return;
                          }

                          isLoading = true;

                          _similarRecipeBlocClick
                              .add(GetRecipeInformation(recipeId: recipes.id!));
                        },
                      ),
                    ),
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
        BlocListener(
          bloc: _similarRecipeBlocClick,
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
    );
  }
}
