import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:platepal/config/hive/hive_registrar.g.dart';
import 'package:platepal/features/recipes/data/data_sources/local/recipes_local_data_source.dart';
import 'package:platepal/features/recipes/data/data_sources/remote/recipes_api_service.dart';
import 'package:platepal/features/recipes/data/repository/recipes_repository_impl.dart';
import 'package:platepal/features/recipes/domain/repository/recipes_repository.dart';
import 'package:platepal/features/recipes/domain/usecases/get_random_recipes.dart';
import 'package:platepal/features/recipes/domain/usecases/get_recipe_information.dart';
import 'package:platepal/features/recipes/domain/usecases/get_recipe_instructions.dart';
import 'package:platepal/features/recipes/domain/usecases/get_similar_recipes.dart';
import 'package:platepal/features/recipes/domain/usecases/search_recipes.dart';
import 'package:platepal/features/recipes/domain/usecases/search_recipes_by_categories.dart';
import 'features/recipes/presentation/bloc/recipes/recipes_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Hive
  await Hive.initFlutter();
  Hive.registerAdapters();
  await Hive.openBox('favoritesBox');
  await Hive.openBox('settingsBox');
  await Hive.openBox('cacheBox');

  sl.registerSingleton<Box>(Hive.box('cacheBox'));

  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Dependencies
  sl.registerSingleton<RecipesApiService>(RecipesApiService(sl()));

  sl.registerSingleton<RecipesLocalDataSource>(
    RecipesLocalDataSourceImpl(box: sl()),
  );

  sl.registerSingleton<RecipesRepository>(
    RecipesRepositoryImpl(
      sl(),
      sl(),
    ),
  );

  // UseCases
  sl.registerSingleton<GetRandomRecipesUseCase>(
    GetRandomRecipesUseCase(sl()),
  );
  sl.registerSingleton<GetRecipeInstructionsUseCase>(
    GetRecipeInstructionsUseCase(sl()),
  );
  sl.registerSingleton<GetSimilarRecipesUseCase>(
    GetSimilarRecipesUseCase(sl()),
  );
  sl.registerSingleton(
    GetRecipeInformationUseCase(sl()),
  );
  sl.registerSingleton(
    SearchRecipesUseCase(sl()),
  );
  sl.registerSingleton(
    SearchRecipesByCategoriesUseCase(sl()),
  );

  // BLoCs
  sl.registerFactory<RecipesBloc>(
    () => RecipesBloc(
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
    ),
  );
}
