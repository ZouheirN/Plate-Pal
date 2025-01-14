// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'random_recipes.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeEntityAdapter extends TypeAdapter<RecipeEntity> {
  @override
  final int typeId = 5;

  @override
  RecipeEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecipeEntity(
      id: fields[0] as int?,
      title: fields[1] as String?,
      image: fields[2] as String?,
      servings: fields[3] as int?,
      readyInMinutes: fields[4] as int?,
      cookingMinutes: fields[5] as int?,
      preparationMinutes: fields[6] as int?,
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
  final int typeId = 6;

  @override
  ExtendedIngredientsEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExtendedIngredientsEntity(
      aisle: fields[0] as String?,
      amount: fields[1] as double?,
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
  final int typeId = 7;

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
  final int typeId = 8;

  @override
  MetricEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MetricEntity(
      amount: fields[0] as double?,
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
  final int typeId = 9;

  @override
  UsEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UsEntity(
      amount: fields[0] as double?,
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
