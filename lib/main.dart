import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:platepal/features/home/bloc/recipes_home_bloc.dart';
import 'package:platepal/features/home/models/random_recipe_model.dart';
import 'package:platepal/features/recipe/models/recipe_instructions_model.dart';
import 'package:platepal/features/settings/hive/settings_box.dart';
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
  await Hive.openBox('settingsBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MaterialColor _primarySwatch = Colors.red;

    return BlocProvider(
      create: (context) => RecipesHomeBloc(),
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
                darkColorScheme =
                    darkColorScheme.copyWith(surface: Colors.black).harmonized();
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
                // theme: ThemeData(
                //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
                // ),
                // darkTheme: ThemeData.dark().copyWith(
                //   brightness: Brightness.dark,
                //   colorScheme: ColorScheme.fromSeed(
                //     brightness: Brightness.dark,
                //     seedColor: Colors.red,
                //   ),
                // ),
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
