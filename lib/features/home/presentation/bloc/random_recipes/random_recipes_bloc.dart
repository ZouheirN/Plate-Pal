import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platepal/core/resources/data_state.dart';
import 'package:platepal/features/home/domain/usecases/get_random_recipes.dart';
import 'package:platepal/features/home/presentation/bloc/random_recipes/random_recipes_event.dart';
import 'package:platepal/features/home/presentation/bloc/random_recipes/random_recipes_state.dart';

class RandomRecipesBloc extends Bloc<RandomRecipesEvent, RandomRecipesState> {
  final GetRandomRecipesUseCase _getRandomRecipesUseCase;

  RandomRecipesBloc(this._getRandomRecipesUseCase)
      : super(const RandomRecipesLoading()) {
    on<GetRandomRecipes>(onGetRandomRecipes);
  }

  Future<void> onGetRandomRecipes(
      GetRandomRecipes event, Emitter<RandomRecipesState> emit) async {
    final dataState = await _getRandomRecipesUseCase();

    if (dataState is DataSuccess && dataState.data != null) {
      emit(RandomRecipesDone(randomRecipes: dataState.data!));
    } else if (dataState is DataFailed) {
      emit(RandomRecipesError(error: dataState.error!));
    }
  }
}
