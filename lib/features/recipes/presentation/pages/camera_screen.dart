import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:platepal/features/recipes/domain/entities/image_analysis.dart';
import 'package:platepal/features/recipes/presentation/bloc/recipes/recipes_bloc.dart';
import 'package:platepal/features/recipes/presentation/bloc/recipes/recipes_event.dart';
import 'package:platepal/features/recipes/presentation/bloc/recipes/recipes_state.dart';
import 'package:platepal/features/recipes/presentation/widgets/select_image_sheet.dart';
import 'package:platepal/injection_container.dart';
import 'package:platepal/main.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final _recipeBloc = sl<RecipesBloc>();
  final _imagesRecipeBloc = sl<RecipesBloc>();

  @override
  void initState() {
    _recipeBloc.add(const GetRecipeAnalysis());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
        actions: [
          SelectImageSheet(
            onImageSelected: (img) {
              _imagesRecipeBloc.add(GetImageAnalysis(image: img));

              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          BlocBuilder(
            bloc: _recipeBloc,
            builder: (context, state) {
              if (state is RecipesLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is RecipeAnalysisDone) {
                final valueListenable = state.recipeAnalysis;

                return ValueListenableBuilder(
                  valueListenable: valueListenable!,
                  builder: (context, box, child) {
                    final List images = (box as Box).keys.toList();
                    final List<ImageAnalysisEntity?> recipesAnalyses =
                        List<ImageAnalysisEntity?>.from((box).values.toList());

                    if (recipesAnalyses.isEmpty) {
                      return const Center(
                        child: Text(
                            'Take pictures to get detailed food analysis!'),
                      );
                    }

                    return GridView.builder(
                      padding: const EdgeInsets.all(8),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: recipesAnalyses.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: FileImage(
                                        File(images[index] as String),
                                      ),
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
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 4,
                                  bottom: 4,
                                ),
                                child: Text(recipesAnalyses[index]!
                                    .category!
                                    .name
                                    .toString()),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              }

              if (state is RecipeAnalysisError) {
                return const Center(
                  child: Text('Error'),
                );
              }

              return const SizedBox.shrink();
            },
          ),
          BlocListener(
            bloc: _imagesRecipeBloc,
            listener: (context, state) {
              if (state is RecipesLoading) {
                ScaffoldMessenger.of(context)
                  ..clearSnackBars()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text('Uploading image...'),
                    ),
                  );
              }

              if (state is ImageAnalysisDone) {
                _imagesRecipeBloc.add(
                  StoreImageAnalysis(
                    image: state.image!,
                    imageAnalysisEntity: state.imageAnalysis!,
                  ),
                );

                ScaffoldMessenger.of(context)
                  ..clearSnackBars()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text('Image uploaded!'),
                    ),
                  );
              }

              if (state is ImageAnalysisError) {
                ScaffoldMessenger.of(context)
                  ..clearSnackBars()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text('Error uploading image!'),
                    ),
                  );
              }
            },
            child: const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
