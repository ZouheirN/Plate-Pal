class SearchRecipeModel {
  int? offset;
  int? number;
  List<Result>? results;
  int? totalResults;

  SearchRecipeModel({
    this.offset,
    this.number,
    this.results,
    this.totalResults,
  });

  factory SearchRecipeModel.fromJson(Map<String, dynamic> json) => SearchRecipeModel(
    offset: json["offset"],
    number: json["number"],
    results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
    totalResults: json["totalResults"],
  );

  Map<String, dynamic> toJson() => {
    "offset": offset,
    "number": number,
    "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
    "totalResults": totalResults,
  };
}

class Result {
  int? id;
  String? title;
  String? image;

  Result({
    this.id,
    this.title,
    this.image,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
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
