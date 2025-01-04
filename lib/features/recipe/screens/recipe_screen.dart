import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
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
import 'package:share_plus/share_plus.dart';
import 'package:tap_to_expand/tap_to_expand.dart';

class RecipeScreen extends StatefulWidget {
  final Recipe recipe;
  final List<RecipeInstructionsModel>? recipeInstructionsModel;

  const RecipeScreen({
    super.key,
    required this.recipe,
    this.recipeInstructionsModel,
  });

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen>
    with SingleTickerProviderStateMixin {
  final _recipeBloc = RecipeBloc();
  final _similarRecipeBloc = RecipeBloc();

  late TabController _tabController;

  @override
  void initState() {
    if (widget.recipeInstructionsModel != null) {
      _recipeBloc
          .add(RecipeInstructionSuccessEvent(widget.recipeInstructionsModel!));
    } else {
      _recipeBloc.add(RecipeInstructionFetchEvent(widget.recipe.id!));
    }

    _similarRecipeBloc.add(SimilarRecipesFetchEvent(widget.recipe.id!));

    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      alwaysShowLeadingAndAction: true,
      title: Text(
        widget.recipe.title!,
        textAlign: TextAlign.center,
      ),
      actions: [
        if (widget.recipe.sourceUrl != null)
          IconButton(
            onPressed: () {
              Share.share(widget.recipe.sourceUrl!);
            },
            icon: const Icon(Icons.share),
          ),
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
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: HtmlWidget(
            widget.recipe.summary!,
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
                                '${widget.recipe.readyInMinutes} minutes',
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
                              widget.recipe.cheap! ? Icons.check : Icons.close,
                              color: widget.recipe.cheap!
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
                              widget.recipe.dairyFree!
                                  ? Icons.check
                                  : Icons.close,
                              color: widget.recipe.dairyFree!
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
                              widget.recipe.glutenFree!
                                  ? Icons.check
                                  : Icons.close,
                              color: widget.recipe.glutenFree!
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
                              widget.recipe.vegan! ? Icons.check : Icons.close,
                              color: widget.recipe.vegan!
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
                              widget.recipe.vegetarian!
                                  ? Icons.check
                                  : Icons.close,
                              color: widget.recipe.vegetarian!
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
                          for (var dishType in widget.recipe.dishTypes!)
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
            itemCount: widget.recipe.extendedIngredients!.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.white.withOpacity(0.8),
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: ListTile(
                  title: Text(
                    "${widget.recipe.extendedIngredients![index].name![0].toUpperCase()}${widget.recipe.extendedIngredients![index].name!.substring(1)}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "${widget.recipe.extendedIngredients![index].original![0].toUpperCase()}${widget.recipe.extendedIngredients![index].original!.substring(1)}",
                    style: const TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                ),
              );
            },
          ),
          title: Text(
            'Ingredients (${widget.recipe.extendedIngredients!.length} items)',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
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
                // spaceBetweenBodyTitle: ,
                duration: const Duration(milliseconds: 300),
                backgroundcolor: Colors.white,
                iconColor: Colors.black,
                titlePadding:
                    const EdgeInsets.only(left: 8, right: 8, bottom: 24),
                title: Text(
                  'Instructions (${state.recipeInstructionModel.first.steps?.length} steps)',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
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
