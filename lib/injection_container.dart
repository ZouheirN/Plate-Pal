import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:platepal/features/home/data/data_sources/remote/recipes_api_service.dart';
import 'package:platepal/features/home/data/repository/random_recipes_repository.dart';
import 'package:platepal/features/home/domain/repository/random_recipes_repository.dart';
import 'package:platepal/features/home/domain/usecases/get_random_recipes.dart';
import 'package:platepal/features/home/domain/usecases/get_recipe_instructions.dart';
import 'package:platepal/features/home/presentation/bloc/random_recipes/random_recipes_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Dependencies
  sl.registerSingleton<RecipesApiService>(RecipesApiService(sl()));

  sl.registerSingleton<RecipesRepository>(
    RecipesRepositoryImpl(sl()),
  );

  // UseCases
  sl.registerSingleton<GetRandomRecipesUseCase>(
    GetRandomRecipesUseCase(sl()),
  );
  sl.registerSingleton<GetRecipeInstructionsUseCase>(
    GetRecipeInstructionsUseCase(sl()),
  );

  // BLoCs
  sl.registerFactory<RandomRecipesBloc>(() => RandomRecipesBloc(sl()));
}
