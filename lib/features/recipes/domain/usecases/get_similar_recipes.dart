import 'package:platepal/core/resources/data_state.dart';
import 'package:platepal/core/usecase/usecase.dart';
import 'package:platepal/features/recipes/domain/entities/similar_recipes.dart';
import 'package:platepal/features/recipes/domain/repository/recipes_repository.dart';

class GetSimilarRecipesUseCase
    implements UseCase<DataState<List<SimilarRecipesEntity>>, int> {
  final RecipesRepository _recipesRepository;

  GetSimilarRecipesUseCase(this._recipesRepository);

  @override
  Future<DataState<List<SimilarRecipesEntity>>> call({int? params}) {
    return _recipesRepository.getSimilarRecipes(recipeId: params!);
  }
}
