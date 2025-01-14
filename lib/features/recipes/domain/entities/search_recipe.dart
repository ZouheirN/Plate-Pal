import 'package:equatable/equatable.dart';

class SearchRecipeEntity extends Equatable {
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

  @override
  List<Object?> get props => [offset, number, results, totalResults];
}

class ResultEntity extends Equatable {
  final int? id;
  final String? title;
  final String? image;

  const ResultEntity({
    this.id,
    this.title,
    this.image,
  });

  @override
  List<Object?> get props => [id, title, image];
}
