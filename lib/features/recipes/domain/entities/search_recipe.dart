import 'package:hive_ce/hive.dart';
import 'package:platepal/features/recipes/data/models/search_recipe.dart';

 class SearchRecipeEntity extends HiveObject{
  final int? offset;
  final int? number;
  final List<ResultEntity>? results;
  final int? totalResults;

   SearchRecipeEntity({
    this.offset,
    this.number,
    this.results,
    this.totalResults,
  });

}

 class ResultEntity extends HiveObject{
  final int? id;
  final String? title;
  final String? image;

   ResultEntity({
    this.id,
    this.title,
    this.image,
  });

}
