import 'package:platepal/core/resources/data_state.dart';
import 'package:platepal/core/usecase/usecase.dart';
import 'package:platepal/features/recipes/domain/entities/search_recipe.dart';
import 'package:platepal/features/recipes/domain/repository/recipes_repository.dart';

class SearchRecipesUseCase
    implements UseCase<DataState<SearchRecipeEntity>, String> {
  final RecipesRepository _recipesRepository;

  SearchRecipesUseCase(this._recipesRepository);

  @override
  Future<DataState<SearchRecipeEntity>> call({String? params}) {
    return _recipesRepository.searchRecipes(query: params!);
  }
}
