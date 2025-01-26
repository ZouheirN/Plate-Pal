import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:platepal/features/recipes/domain/entities/image_analysis.dart';
import 'package:platepal/features/recipes/presentation/bloc/recipes/recipes_bloc.dart';
import 'package:platepal/features/recipes/presentation/bloc/recipes/recipes_event.dart';
import 'package:platepal/features/recipes/presentation/bloc/recipes/recipes_state.dart';
import 'package:platepal/features/recipes/presentation/pages/recipe_details.dart';
import 'package:platepal/injection_container.dart';
import 'package:platepal/main.dart';

class ImageAnalysisCard extends StatefulWidget {
  final File image;
  final ImageAnalysisEntity? recipeAnalysis;

  const ImageAnalysisCard({
    super.key,
    required this.image,
    this.recipeAnalysis,
  });

  @override
  State<ImageAnalysisCard> createState() => _ImageAnalysisCardState();
}

class _ImageAnalysisCardState extends State<ImageAnalysisCard> {
  final _recipeBloc = sl<RecipesBloc>();
  bool isLoading = false;
  late Future<void> imageFuture;

  void _onTap() {
    showModalBottomSheet(
      showDragHandle: true,
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                title: const Text(
                  'Predicted Category',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Row(
                  children: [
                    Text(
                      widget.recipeAnalysis!.category!.name!
                              .substring(0, 1)
                              .toUpperCase() +
                          widget.recipeAnalysis!.category!.name!
                              .substring(1)
                              .toString(),
                    ),
                    const Text(' ● '),
                    Text(
                      '${(widget.recipeAnalysis!.category!.probability! * 100).toStringAsFixed(2)}%',
                    ),
                  ],
                ),
              ),
              ListTile(
                title: const Text(
                  'Nutrition',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: const Text(
                              'Calories',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '${widget.recipeAnalysis!.nutrition!.calories!.value} ${widget.recipeAnalysis!.nutrition!.calories!.unit}',
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: const Text(
                              'Fat',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '${widget.recipeAnalysis!.nutrition!.fat!.value}${widget.recipeAnalysis!.nutrition!.fat!.unit}',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: const Text(
                              'Protein',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '${widget.recipeAnalysis!.nutrition!.protein!.value}${widget.recipeAnalysis!.nutrition!.protein!.unit}',
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: const Text(
                              'Carbs',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '${widget.recipeAnalysis!.nutrition!.carbs!.value}${widget.recipeAnalysis!.nutrition!.carbs!.unit}',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ListTile(
                title: const Text(
                  'Recipes',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: BlocListener<RecipesBloc, RecipesState>(
                  bloc: _recipeBloc,
                  listener: (context, state) {
                    if (state is RecipeInformationDone) {
                      isLoading = false;

                      logger.i(state.recipe!.id);

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => RecipeDetails(
                            recipeEntity: state.recipe!,
                          ),
                        ),
                      );
                    }
                  },
                  child: Column(
                    children: [
                      for (var recipes in widget.recipeAnalysis!.recipes!)
                        Card(
                          child: ListTile(
                            trailing: const Icon(Icons.arrow_forward_ios),
                            title: Text(recipes.title!),
                            onTap: () {
                              if (isLoading) {
                                return;
                              }

                              isLoading = true;

                              _recipeBloc.add(
                                GetRecipeInformation(
                                  recipeId: int.parse(
                                    recipes.id!.toString(),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onLongPress() {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: const Text('Delete Image'),
          content: const Text('Are you sure you want to delete this image?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            BlocListener<RecipesBloc, RecipesState>(
              bloc: _recipeBloc,
              listener: (context, state) {
                if (state is DeleteImageAnalysisDone) {
                  ScaffoldMessenger.of(context)
                    ..clearSnackBars()
                    ..showSnackBar(
                      const SnackBar(
                        content: Text('Image deleted'),
                      ),
                    );
                }

                if (state is DeleteImageAnalysisError) {
                  ScaffoldMessenger.of(context)
                    ..clearSnackBars()
                    ..showSnackBar(
                      const SnackBar(
                        content: Text('Error deleting image'),
                      ),
                    );
                }
              },
              child: TextButton(
                onPressed: () {
                  _recipeBloc.add(
                    DeleteImageAnalysis(
                      image: widget.image,
                    ),
                  );

                  Navigator.of(context).pop();
                },
                child: const Text('Delete'),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> loadImage() async {
    try {
      await precacheImage(FileImage(widget.image), context);
    } catch (e) {
      logger.e(e);
      throw Exception('Error loading image');
    }
  }

  @override
  void didChangeDependencies() {
    imageFuture = loadImage();
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      onLongPress: _onLongPress,
      child: Card(
        child: FutureBuilder(
          future: imageFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.error),
                  Gap(8),
                  Text('Error loading image'),
                ],
              );
            }

            return Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: FileImage(widget.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 4,
                    bottom: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(widget.recipeAnalysis!.category!.name!
                              .substring(0, 1)
                              .toUpperCase() +
                          widget.recipeAnalysis!.category!.name!
                              .substring(1)
                              .toString()),
                      Text(
                        '${(widget.recipeAnalysis!.category!.probability! * 100).toStringAsFixed(2)}%',
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
