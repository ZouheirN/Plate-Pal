import 'package:equatable/equatable.dart';

class SimilarRecipesEntity extends Equatable {
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

  @override
  List<Object?> get props => [
    id,
    title,
    imageType,
    readyInMinutes,
    servings,
    sourceUrl,
  ];
}
