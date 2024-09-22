import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:platepal/features/home/models/random_recipe_model.dart';
import 'package:platepal/features/recipe/bloc/recipe_bloc.dart';
import 'package:platepal/hive/favorites_box.dart';
import 'package:platepal/widgets/instructions_widget.dart';

class RecipeScreen extends StatefulWidget {
  final Recipe recipe;

  const RecipeScreen({super.key, required this.recipe});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  final _recipeBloc = RecipeBloc();

  @override
  void initState() {
    _recipeBloc.add(RecipeInstructionFetchEvent(widget.recipe.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.recipe.title!,
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (FavoritesBox.isFavorite(widget.recipe)) {
                FavoritesBox.removeFavorite(widget.recipe.id!);
              } else {
                final instructions =
                    _recipeBloc.state is RecipeInstructionSuccess
                        ? (_recipeBloc.state as RecipeInstructionSuccess)
                            .recipeInstructionModel
                        : null;

                if (instructions != null) {
                  FavoritesBox.addFavorite(widget.recipe, instructions);
                }
              }
            },
            icon: ValueListenableBuilder(
                valueListenable: FavoritesBox.listenable(),
                builder: (context, Box box, child) {
                  if (FavoritesBox.isFavorite(widget.recipe)) {
                    return const Icon(Icons.favorite);
                  } else {
                    return const Icon(Icons.favorite_border);
                  }
                }),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.recipe.image!,
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.recipe.title!,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: HtmlWidget(
                widget.recipe.summary!,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpansionTile(
                title: const Text('Ingredients'),
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.recipe.extendedIngredients!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          widget.recipe.extendedIngredients![index].name!,
                        ),
                        subtitle: Text(
                          widget.recipe.extendedIngredients![index].original!,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<RecipeBloc, RecipeState>(
                bloc: _recipeBloc,
                builder: (context, state) {
                  if (state is RecipeInstructionLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is RecipeInstructionSuccess) {
                    return ExpansionTile(
                      title: const Text('Instructions'),
                      children: [
                        InstructionsWidget(
                            recipeInstructionsModel:
                                state.recipeInstructionModel),
                      ],
                    );
                  } else if (state is RecipeInstructionError) {
                    return Text(state.message.toString());
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
