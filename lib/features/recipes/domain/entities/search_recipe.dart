class SearchRecipeEntity {
  final int? offset;
  final int? number;
  final List<ResultEntity>? results;
  final int? totalResults;

  const SearchRecipeEntity({
    this.offset,
    this.number,
    this.results,
    this.totalResults,
  });
}

class ResultEntity {
  final int? id;
  final String? title;
  final String? image;

  const ResultEntity({
    this.id,
    this.title,
    this.image,
  });
}
