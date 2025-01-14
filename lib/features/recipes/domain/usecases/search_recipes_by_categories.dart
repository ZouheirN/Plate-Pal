import 'package:platepal/core/resources/data_state.dart';
import 'package:platepal/core/usecase/usecase.dart';
import 'package:platepal/features/recipes/domain/entities/search_recipe.dart';
import 'package:platepal/features/recipes/domain/repository/recipes_repository.dart';

class SearchRecipesByCategoriesUseCase
    implements UseCase<DataState<SearchRecipeEntity>, Map<String, String>> {
  final RecipesRepository _recipesRepository;

  SearchRecipesByCategoriesUseCase(this._recipesRepository);

  @override
  Future<DataState<SearchRecipeEntity>> call({Map<String, String>? params}) {
    return _recipesRepository.searchRecipesByCategories(
      cuisines: params!['cuisines'] ?? '',
      diets: params['diets'] ?? '',
    );
  }
}
