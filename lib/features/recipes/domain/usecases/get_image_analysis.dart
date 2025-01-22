import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:platepal/core/resources/data_state.dart';
import 'package:platepal/core/usecase/usecase.dart';
import 'package:platepal/features/recipes/domain/entities/image_analysis.dart';
import 'package:platepal/features/recipes/domain/repository/recipes_repository.dart';

class GetImageAnalysisUseCase
    implements UseCase<DataState<ImageAnalysisEntity>, File> {
  final RecipesRepository _recipesRepository;

  GetImageAnalysisUseCase(this._recipesRepository);

  @override
  Future<DataState<ImageAnalysisEntity>> call({File? params}) {
    return _recipesRepository.getImageAnalysis(image: params!);
  }
}
