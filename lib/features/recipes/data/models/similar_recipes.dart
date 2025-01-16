import 'package:platepal/features/recipes/domain/entities/similar_recipes.dart';

class SimilarRecipesModel extends SimilarRecipesEntity {
  SimilarRecipesModel({
    super.id,
    super.title,
    super.imageType,
    super.readyInMinutes,
    super.servings,
    super.sourceUrl,
  });

  factory SimilarRecipesModel.fromJson(Map<String, dynamic> json) =>
      SimilarRecipesModel(
        id: json["id"],
        title: json["title"],
        imageType: json["imageType"],
        readyInMinutes: json["readyInMinutes"],
        servings: json["servings"],
        sourceUrl: json["sourceUrl"],
      );
}
