import 'package:flutter/foundation.dart';
import 'package:platepal/core/resources/data_state.dart';
import 'package:platepal/core/usecase/usecase.dart';
import 'package:platepal/features/recipes/data/models/image_analysis.dart';
import 'package:platepal/features/recipes/domain/entities/image_analysis.dart';
import 'package:platepal/features/recipes/domain/repository/recipes_repository.dart';

class StoreImageAnalysisUseCase implements UseCase<void, Map<String, dynamic>> {
  final RecipesRepository _recipesRepository;

  StoreImageAnalysisUseCase(this._recipesRepository);

  @override
  Future<void> call({Map<String, dynamic>? params}) {
    return _recipesRepository.storeImageAnalysis(
      image: params!['image'],
      imageAnalysisEntity: params['imageAnalysisEntity'],
    );
  }
}
