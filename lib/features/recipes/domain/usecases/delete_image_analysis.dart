import 'dart:io';

import 'package:platepal/core/usecase/usecase.dart';
import 'package:platepal/features/recipes/domain/repository/recipes_repository.dart';

class DeleteImageAnalysisUseCase implements UseCase<void, File> {
  final RecipesRepository _recipesRepository;

  DeleteImageAnalysisUseCase(this._recipesRepository);

  @override
  Future<void> call({File? params}) {
    return _recipesRepository.deleteImageAnalysis(image: params!);
  }
}
