import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:platepal/features/home/bloc/recipes_home_bloc.dart';
import 'package:platepal/features/home/models/random_recipe_model.dart';
import 'package:platepal/features/recipe/models/recipe_instructions_model.dart';
import 'package:platepal/main_wrapper.dart';

final logger = Logger();

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  await Hive.initFlutter();

  Hive.registerAdapter(RecipeAdapter());
  Hive.registerAdapter(ExtendedIngredientsAdapter());
  Hive.registerAdapter(MeasuresAdapter());
  Hive.registerAdapter(MetricAdapter());
  Hive.registerAdapter(UsAdapter());
  Hive.registerAdapter(RecipeInstructionsModelAdapter());
  Hive.registerAdapter(StepModelAdapter());
  Hive.registerAdapter(EntAdapter());
  Hive.registerAdapter(LengthAdapter());

  await Hive.openBox('favoritesBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecipesHomeBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        ),
        home: const MainWrapper(),
      ),
    );
  }
}
