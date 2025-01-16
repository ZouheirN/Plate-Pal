import 'package:hive_ce/hive.dart';

class SimilarRecipesEntity extends HiveObject {
  final int? id;
  final String? title;
  final String? imageType;
  final int? readyInMinutes;
  final int? servings;
  final String? sourceUrl;

  SimilarRecipesEntity({
    this.id,
    this.title,
    this.imageType,
    this.readyInMinutes,
    this.servings,
    this.sourceUrl,
  });
}
