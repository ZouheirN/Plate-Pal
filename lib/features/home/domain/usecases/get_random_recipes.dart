import 'package:platepal/core/resources/data_state.dart';
import 'package:platepal/core/usecase/usecase.dart';
import 'package:platepal/features/home/domain/entities/random_recipes.dart';
import 'package:platepal/features/home/domain/repository/random_recipes_repository.dart';

class GetRandomRecipesUseCase
    implements UseCase<DataState<RandomRecipesEntity>, void> {
  final RecipesRepository _recipesRepository;

  GetRandomRecipesUseCase(this._recipesRepository);

  @override
  Future<DataState<RandomRecipesEntity>> call({void params}) {
    return _recipesRepository.getRandomRecipes();
  }
}
