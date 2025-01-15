class SimilarRecipesEntity {
  final int? id;
  final String? title;
  final String? imageType;
  final int? readyInMinutes;
  final int? servings;
  final String? sourceUrl;

  const SimilarRecipesEntity({
    this.id,
    this.title,
    this.imageType,
    this.readyInMinutes,
    this.servings,
    this.sourceUrl,
  });
}
