import 'dart:convert';

List<SimilarRecipesModel> similarRecipesModelFromJson(List<dynamic> data) =>
    List<SimilarRecipesModel>.from(
        data.map((x) => SimilarRecipesModel.fromJson(x)));

String similarRecipesModelToJson(List<SimilarRecipesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SimilarRecipesModel {
  int? id;
  String? title;
  String? imageType;
  int? readyInMinutes;
  int? servings;
  String? sourceUrl;

  SimilarRecipesModel({
    this.id,
    this.title,
    this.imageType,
    this.readyInMinutes,
    this.servings,
    this.sourceUrl,
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

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "imageType": imageType,
        "readyInMinutes": readyInMinutes,
        "servings": servings,
        "sourceUrl": sourceUrl,
      };
}
