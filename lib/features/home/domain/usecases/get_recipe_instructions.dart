import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/recipe_instructions.dart';
import '../repository/random_recipes_repository.dart';

class GetRecipeInstructionsUseCase
    implements UseCase<DataState<RecipeInstructionsEntity>, String> {
  final RecipesRepository _recipesRepository;

  GetRecipeInstructionsUseCase(this._recipesRepository);

  @override
  Future<DataState<RecipeInstructionsEntity>> call({String? params}) {
    return _recipesRepository.getRecipeInstructions(recipeId: params!);
  }
}
