import 'package:flutter/foundation.dart';
import 'package:platepal/core/resources/data_state.dart';
import 'package:platepal/core/usecase/usecase.dart';
import 'package:platepal/features/recipes/domain/repository/recipes_repository.dart';

class GetRecipeAnalysisUseCase
    implements UseCase<DataState<ValueListenable>, void> {
  final RecipesRepository _recipesRepository;

  GetRecipeAnalysisUseCase(this._recipesRepository);

  @override
  Future<DataState<ValueListenable>> call({void params}) {
    return _recipesRepository.getRecipeAnalysis();
  }
}
