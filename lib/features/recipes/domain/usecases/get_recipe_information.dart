import 'package:platepal/core/resources/data_state.dart';
import 'package:platepal/core/usecase/usecase.dart';
import 'package:platepal/features/recipes/domain/entities/random_recipes.dart';
import 'package:platepal/features/recipes/domain/repository/recipes_repository.dart';


class GetRecipeInformationUseCase
    implements UseCase<DataState<RecipeEntity>, int> {
  final RecipesRepository _recipesRepository;

  GetRecipeInformationUseCase(this._recipesRepository);

  @override
  Future<DataState<RecipeEntity>> call({int? params}) {
    return _recipesRepository.getRecipeInformation(recipeId: params!);
  }
}
