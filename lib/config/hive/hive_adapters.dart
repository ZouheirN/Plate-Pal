import 'package:hive_ce/hive.dart';
import 'package:platepal/features/recipes/domain/entities/random_recipes.dart';
import 'package:platepal/features/recipes/domain/entities/recipe_instructions.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<RecipeEntity>(),
  AdapterSpec<ExtendedIngredientsEntity>(),
  AdapterSpec<MeasuresEntity>(),
  AdapterSpec<MetricEntity>(),
  AdapterSpec<UsEntity>(),
  AdapterSpec<RecipeInstructionsEntity>(),
  AdapterSpec<StepEntity>(),
  AdapterSpec<EntEntity>(),
  AdapterSpec<LengthEntity>(),
])
// Annotations must be on some element
// ignore: unused_element
void _() {}