// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class RecipeEntityAdapter extends TypeAdapter<RecipeEntity> {
  @override
  final int typeId = 0;

  @override
  RecipeEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecipeEntity(
      id: (fields[0] as num?)?.toInt(),
      title: fields[1] as String?,
      image: fields[2] as String?,
      servings: (fields[3] as num?)?.toInt(),
      readyInMinutes: (fields[4] as num?)?.toInt(),
      cookingMinutes: (fields[5] as num?)?.toInt(),
      preparationMinutes: (fields[6] as num?)?.toInt(),
      cheap: fields[7] as bool?,
      dairyFree: fields[8] as bool?,
      glutenFree: fields[9] as bool?,
      vegan: fields[10] as bool?,
      vegetarian: fields[11] as bool?,
      dishTypes: (fields[12] as List?)?.cast<String>(),
      extendedIngredients:
          (fields[13] as List?)?.cast<ExtendedIngredientsEntity>(),
      summary: fields[14] as String?,
      sourceUrl: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, RecipeEntity obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.servings)
      ..writeByte(4)
      ..write(obj.readyInMinutes)
      ..writeByte(5)
      ..write(obj.cookingMinutes)
      ..writeByte(6)
      ..write(obj.preparationMinutes)
      ..writeByte(7)
      ..write(obj.cheap)
      ..writeByte(8)
      ..write(obj.dairyFree)
      ..writeByte(9)
      ..write(obj.glutenFree)
      ..writeByte(10)
      ..write(obj.vegan)
      ..writeByte(11)
      ..write(obj.vegetarian)
      ..writeByte(12)
      ..write(obj.dishTypes)
      ..writeByte(13)
      ..write(obj.extendedIngredients)
      ..writeByte(14)
      ..write(obj.summary)
      ..writeByte(15)
      ..write(obj.sourceUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ExtendedIngredientsEntityAdapter
    extends TypeAdapter<ExtendedIngredientsEntity> {
  @override
  final int typeId = 1;

  @override
  ExtendedIngredientsEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExtendedIngredientsEntity(
      aisle: fields[0] as String?,
      amount: (fields[1] as num?)?.toDouble(),
      consistency: fields[2] as String?,
      image: fields[3] as String?,
      measures: fields[4] as MeasuresEntity?,
      meta: (fields[5] as List?)?.cast<String>(),
      name: fields[6] as String?,
      original: fields[7] as String?,
      originalName: fields[8] as String?,
      unit: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ExtendedIngredientsEntity obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.aisle)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.consistency)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.measures)
      ..writeByte(5)
      ..write(obj.meta)
      ..writeByte(6)
      ..write(obj.name)
      ..writeByte(7)
      ..write(obj.original)
      ..writeByte(8)
      ..write(obj.originalName)
      ..writeByte(9)
      ..write(obj.unit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExtendedIngredientsEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MeasuresEntityAdapter extends TypeAdapter<MeasuresEntity> {
  @override
  final int typeId = 2;

  @override
  MeasuresEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MeasuresEntity(
      metric: fields[0] as MetricEntity?,
      us: fields[1] as UsEntity?,
    );
  }

  @override
  void write(BinaryWriter writer, MeasuresEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.metric)
      ..writeByte(1)
      ..write(obj.us);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MeasuresEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MetricEntityAdapter extends TypeAdapter<MetricEntity> {
  @override
  final int typeId = 3;

  @override
  MetricEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MetricEntity(
      amount: (fields[0] as num?)?.toDouble(),
      unitShort: fields[1] as String?,
      unitLong: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MetricEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.amount)
      ..writeByte(1)
      ..write(obj.unitShort)
      ..writeByte(2)
      ..write(obj.unitLong);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MetricEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UsEntityAdapter extends TypeAdapter<UsEntity> {
  @override
  final int typeId = 4;

  @override
  UsEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UsEntity(
      amount: (fields[0] as num?)?.toDouble(),
      unitShort: fields[1] as String?,
      unitLong: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UsEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.amount)
      ..writeByte(1)
      ..write(obj.unitShort)
      ..writeByte(2)
      ..write(obj.unitLong);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RecipeInstructionsEntityAdapter
    extends TypeAdapter<RecipeInstructionsEntity> {
  @override
  final int typeId = 5;

  @override
  RecipeInstructionsEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecipeInstructionsEntity(
      name: fields[0] as String?,
      steps: (fields[1] as List?)?.cast<StepEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, RecipeInstructionsEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.steps);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeInstructionsEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StepEntityAdapter extends TypeAdapter<StepEntity> {
  @override
  final int typeId = 6;

  @override
  StepEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StepEntity(
      equipment: (fields[0] as List?)?.cast<EntEntity>(),
      ingredients: (fields[1] as List?)?.cast<EntEntity>(),
      number: fields[2] as num?,
      step: fields[3] as String?,
      length: fields[4] as LengthEntity?,
    );
  }

  @override
  void write(BinaryWriter writer, StepEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.equipment)
      ..writeByte(1)
      ..write(obj.ingredients)
      ..writeByte(2)
      ..write(obj.number)
      ..writeByte(3)
      ..write(obj.step)
      ..writeByte(4)
      ..write(obj.length);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StepEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EntEntityAdapter extends TypeAdapter<EntEntity> {
  @override
  final int typeId = 7;

  @override
  EntEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EntEntity(
      id: (fields[0] as num?)?.toInt(),
      image: fields[1] as String?,
      name: fields[2] as String?,
      temperature: fields[3] as LengthEntity?,
    );
  }

  @override
  void write(BinaryWriter writer, EntEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.temperature);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EntEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LengthEntityAdapter extends TypeAdapter<LengthEntity> {
  @override
  final int typeId = 8;

  @override
  LengthEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LengthEntity(
      number: fields[0] as num?,
      unit: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LengthEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.number)
      ..writeByte(1)
      ..write(obj.unit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LengthEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RandomRecipesEntityAdapter extends TypeAdapter<RandomRecipesEntity> {
  @override
  final int typeId = 9;

  @override
  RandomRecipesEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RandomRecipesEntity(
      recipes: (fields[0] as List?)?.cast<RecipeEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, RandomRecipesEntity obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.recipes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RandomRecipesEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SearchRecipeEntityAdapter extends TypeAdapter<SearchRecipeEntity> {
  @override
  final int typeId = 10;

  @override
  SearchRecipeEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SearchRecipeEntity(
      offset: (fields[0] as num?)?.toInt(),
      number: (fields[1] as num?)?.toInt(),
      results: (fields[2] as List?)?.cast<ResultEntity>(),
      totalResults: (fields[3] as num?)?.toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, SearchRecipeEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.offset)
      ..writeByte(1)
      ..write(obj.number)
      ..writeByte(2)
      ..write(obj.results)
      ..writeByte(3)
      ..write(obj.totalResults);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchRecipeEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ResultEntityAdapter extends TypeAdapter<ResultEntity> {
  @override
  final int typeId = 11;

  @override
  ResultEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ResultEntity(
      id: (fields[0] as num?)?.toInt(),
      title: fields[1] as String?,
      image: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ResultEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResultEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SimilarRecipesEntityAdapter extends TypeAdapter<SimilarRecipesEntity> {
  @override
  final int typeId = 12;

  @override
  SimilarRecipesEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SimilarRecipesEntity(
      id: (fields[0] as num?)?.toInt(),
      title: fields[1] as String?,
      imageType: fields[2] as String?,
      readyInMinutes: (fields[3] as num?)?.toInt(),
      servings: (fields[4] as num?)?.toInt(),
      sourceUrl: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SimilarRecipesEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.imageType)
      ..writeByte(3)
      ..write(obj.readyInMinutes)
      ..writeByte(4)
      ..write(obj.servings)
      ..writeByte(5)
      ..write(obj.sourceUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SimilarRecipesEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ImageAnalysisEntityAdapter extends TypeAdapter<ImageAnalysisEntity> {
  @override
  final int typeId = 13;

  @override
  ImageAnalysisEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImageAnalysisEntity(
      nutrition: fields[0] as NutritionEntity?,
      category: fields[1] as CategoryEntity?,
      recipes: (fields[2] as List?)?.cast<RecipeIAEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, ImageAnalysisEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.nutrition)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.recipes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageAnalysisEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CategoryEntityAdapter extends TypeAdapter<CategoryEntity> {
  @override
  final int typeId = 14;

  @override
  CategoryEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryEntity(
      name: fields[0] as String?,
      probability: (fields[1] as num?)?.toDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, CategoryEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.probability);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NutritionEntityAdapter extends TypeAdapter<NutritionEntity> {
  @override
  final int typeId = 15;

  @override
  NutritionEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NutritionEntity(
      recipesUsed: (fields[0] as num?)?.toInt(),
      calories: fields[1] as CaloriesEntity?,
      fat: fields[2] as CaloriesEntity?,
      protein: fields[3] as CaloriesEntity?,
      carbs: fields[4] as CaloriesEntity?,
    );
  }

  @override
  void write(BinaryWriter writer, NutritionEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.recipesUsed)
      ..writeByte(1)
      ..write(obj.calories)
      ..writeByte(2)
      ..write(obj.fat)
      ..writeByte(3)
      ..write(obj.protein)
      ..writeByte(4)
      ..write(obj.carbs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NutritionEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CaloriesEntityAdapter extends TypeAdapter<CaloriesEntity> {
  @override
  final int typeId = 16;

  @override
  CaloriesEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CaloriesEntity(
      value: (fields[0] as num?)?.toInt(),
      unit: fields[1] as String?,
      confidenceRange95Percent: fields[2] as ConfidenceRange95PercentEntity?,
      standardDeviation: (fields[3] as num?)?.toDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, CaloriesEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.value)
      ..writeByte(1)
      ..write(obj.unit)
      ..writeByte(2)
      ..write(obj.confidenceRange95Percent)
      ..writeByte(3)
      ..write(obj.standardDeviation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CaloriesEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ConfidenceRange95PercentEntityAdapter
    extends TypeAdapter<ConfidenceRange95PercentEntity> {
  @override
  final int typeId = 17;

  @override
  ConfidenceRange95PercentEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConfidenceRange95PercentEntity(
      min: (fields[0] as num?)?.toDouble(),
      max: (fields[1] as num?)?.toDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, ConfidenceRange95PercentEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.min)
      ..writeByte(1)
      ..write(obj.max);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConfidenceRange95PercentEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RecipeIAEntityAdapter extends TypeAdapter<RecipeIAEntity> {
  @override
  final int typeId = 18;

  @override
  RecipeIAEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecipeIAEntity(
      id: (fields[0] as num?)?.toInt(),
      title: fields[1] as String?,
      imageType: fields[2] as String?,
      sourceUrl: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, RecipeIAEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.imageType)
      ..writeByte(3)
      ..write(obj.sourceUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeIAEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
