import 'package:hive_ce/hive.dart';
import 'package:platepal/features/recipes/domain/entities/image_analysis.dart';
import 'package:platepal/features/recipes/domain/entities/random_recipes.dart';
import 'package:platepal/features/recipes/domain/entities/recipe_instructions.dart';
import 'package:platepal/features/recipes/domain/entities/search_recipe.dart';
import 'package:platepal/features/recipes/domain/entities/similar_recipes.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<RandomRecipesEntity>(),
  AdapterSpec<RecipeEntity>(),
  AdapterSpec<ExtendedIngredientsEntity>(),
  AdapterSpec<MeasuresEntity>(),
  AdapterSpec<MetricEntity>(),
  AdapterSpec<UsEntity>(),
  AdapterSpec<RecipeInstructionsEntity>(),
  AdapterSpec<StepEntity>(),
  AdapterSpec<EntEntity>(),
  AdapterSpec<LengthEntity>(),
  AdapterSpec<SearchRecipeEntity>(),
  AdapterSpec<ResultEntity>(),
  AdapterSpec<SimilarRecipesEntity>(),
  AdapterSpec<ImageAnalysisEntity>(),
  AdapterSpec<CategoryEntity>(),
  AdapterSpec<NutritionEntity>(),
  AdapterSpec<CaloriesEntity>(),
  AdapterSpec<ConfidenceRange95PercentEntity>(),
  AdapterSpec<RecipeIAEntity>(),
])
void _() {}
