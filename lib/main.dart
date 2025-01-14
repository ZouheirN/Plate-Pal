import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:platepal/features/recipes/domain/entities/random_recipes.dart';
import 'package:platepal/features/recipes/domain/entities/recipe_instructions.dart';
import 'package:platepal/features/settings/hive/settings_box.dart';
import 'package:platepal/injection_container.dart';
import 'package:platepal/main_wrapper.dart';
import 'features/recipes/presentation/bloc/recipes/recipes_bloc.dart';

final logger = Logger();

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  await initializeDependencies();

  await Hive.initFlutter();

  Hive.registerAdapter<RecipeInstructionsEntity>(
      RecipeInstructionsEntityAdapter());
  Hive.registerAdapter<ExtendedIngredientsEntity>(
      ExtendedIngredientsEntityAdapter());
  Hive.registerAdapter<MeasuresEntity>(MeasuresEntityAdapter());
  Hive.registerAdapter<MetricEntity>(MetricEntityAdapter());
  Hive.registerAdapter<UsEntity>(UsEntityAdapter());
  Hive.registerAdapter<StepEntity>(StepEntityAdapter());
  Hive.registerAdapter<EntEntity>(EntEntityAdapter());
  Hive.registerAdapter<LengthEntity>(LengthEntityAdapter());
  Hive.registerAdapter<RecipeEntity>(RecipeEntityAdapter());

  await Hive.openBox('favoritesBox');
  await Hive.openBox('settingsBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RecipesBloc>(
          create: (context) => sl(),
        ),
      ],
      child: ValueListenableBuilder(
        valueListenable: SettingsBox.listenable(),
        builder: (context, box, child) {
          return DynamicColorBuilder(
            builder: (lightDynamic, darkDynamic) {
              ColorScheme lightColorScheme;
              ColorScheme darkColorScheme;
              if (lightDynamic != null &&
                  darkDynamic != null &&
                  SettingsBox.useMaterialYou) {
                lightColorScheme = lightDynamic.harmonized();
                darkColorScheme = darkDynamic.harmonized();
              } else {
                lightColorScheme =
                    ColorScheme.fromSeed(seedColor: SettingsBox.themeColor);
                darkColorScheme = ColorScheme.fromSeed(
                    seedColor: SettingsBox.themeColor,
                    brightness: Brightness.dark);
              }

              // set the background and surface colors to pure black in the amoled theme
              if (SettingsBox.useAmoledBlack) {
                darkColorScheme = darkColorScheme
                    .copyWith(surface: Colors.black)
                    .harmonized();
              }

              return MaterialApp(
                title: 'PlatePal',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  useMaterial3: true,
                  colorScheme: lightColorScheme,
                ),
                darkTheme: ThemeData(
                  useMaterial3: true,
                  colorScheme: darkColorScheme,
                ),
                themeMode:
                    SettingsBox.darkMode ? ThemeMode.dark : ThemeMode.light,
                home: const MainWrapper(),
              );
            },
          );
        },
      ),
    );
  }
}
