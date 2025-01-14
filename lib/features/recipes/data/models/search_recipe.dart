import 'package:platepal/features/recipes/domain/entities/search_recipe.dart';

class SearchRecipeModel extends SearchRecipeEntity {
  const SearchRecipeModel({
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

  Map<String, dynamic> toJson() {
    final List<ResultModel>? results = this.results as List<ResultModel>?;

    return {
      "offset": offset,
      "number": number,
      "results": results == null
          ? []
          : List<dynamic>.from(results.map((x) => x.toJson())),
      "totalResults": totalResults,
    };
  }
}

class ResultModel extends ResultEntity {
  const ResultModel({
    super.id,
    super.image,
    super.title,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        id: json["id"],
        title: json["title"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
      };
}
