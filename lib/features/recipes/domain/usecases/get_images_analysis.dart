import 'package:flutter/foundation.dart';
import 'package:platepal/core/resources/data_state.dart';
import 'package:platepal/core/usecase/usecase.dart';
import 'package:platepal/features/recipes/domain/repository/recipes_repository.dart';

class GetImagesAnalysisUseCase
    implements UseCase<DataState<ValueListenable>, void> {
  final RecipesRepository _recipesRepository;

  GetImagesAnalysisUseCase(this._recipesRepository);

  @override
  Future<DataState<ValueListenable>> call({void params}) {
    return _recipesRepository.getImagesAnalysis();
  }
}
