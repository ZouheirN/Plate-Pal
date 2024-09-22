// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'random_recipe_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeAdapter extends TypeAdapter<Recipe> {
  @override
  final int typeId = 0;

  @override
  Recipe read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Recipe(
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
      extendedIngredients: (fields[13] as List?)?.cast<ExtendedIngredients>(),
      summary: fields[14] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Recipe obj) {
    writer
      ..writeByte(15)
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
      ..write(obj.summary);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ExtendedIngredientsAdapter extends TypeAdapter<ExtendedIngredients> {
  @override
  final int typeId = 1;

  @override
  ExtendedIngredients read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExtendedIngredients(
      aisle: fields[0] as String?,
      amount: fields[1] as double?,
      consistency: fields[2] as String?,
      image: fields[3] as String?,
      measures: fields[4] as Measures?,
      meta: (fields[5] as List?)?.cast<String>(),
      name: fields[6] as String?,
      original: fields[7] as String?,
      originalName: fields[8] as String?,
      unit: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ExtendedIngredients obj) {
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
      other is ExtendedIngredientsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MeasuresAdapter extends TypeAdapter<Measures> {
  @override
  final int typeId = 2;

  @override
  Measures read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Measures(
      metric: fields[0] as Metric?,
      us: fields[1] as Us?,
    );
  }

  @override
  void write(BinaryWriter writer, Measures obj) {
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
      other is MeasuresAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MetricAdapter extends TypeAdapter<Metric> {
  @override
  final int typeId = 3;

  @override
  Metric read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Metric(
      amount: fields[0] as double?,
      unitShort: fields[1] as String?,
      unitLong: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Metric obj) {
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
      other is MetricAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UsAdapter extends TypeAdapter<Us> {
  @override
  final int typeId = 4;

  @override
  Us read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Us(
      amount: fields[0] as double?,
      unitShort: fields[1] as String?,
      unitLong: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Us obj) {
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
      other is UsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
