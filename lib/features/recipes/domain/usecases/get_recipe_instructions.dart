import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/recipe_instructions.dart';
import '../repository/recipes_repository.dart';

class GetRecipeInstructionsUseCase
    implements UseCase<DataState<List<RecipeInstructionsEntity>>, int> {
  final RecipesRepository _recipesRepository;

  GetRecipeInstructionsUseCase(this._recipesRepository);

  @override
  Future<DataState<List<RecipeInstructionsEntity>>> call({int? params}) {
    return _recipesRepository.getRecipeInstructions(recipeId: params!);
  }
}
