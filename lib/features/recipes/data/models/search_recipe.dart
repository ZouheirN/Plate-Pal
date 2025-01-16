import 'package:platepal/features/recipes/domain/entities/search_recipe.dart';

class SearchRecipeModel extends SearchRecipeEntity {
   SearchRecipeModel({
    super.number,
    super.offset,
    super.results,
    super.totalResults,
  });

  factory SearchRecipeModel.fromJson(Map<String, dynamic> json) =>
      SearchRecipeModel(
        offset: json["offset"],
        number: json["number"],
        results: json["results"] == null
            ? []
            : List<ResultEntity>.from(
                json["results"]!.map((x) => ResultModel.fromJson(x))),
        totalResults: json["totalResults"],
      );
}

class ResultModel extends ResultEntity {
   ResultModel({
    super.id,
    super.image,
    super.title,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        id: json["id"],
        title: json["title"],
        image: json["image"],
      );

}
