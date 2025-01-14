// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_instructions.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeInstructionsEntityAdapter
    extends TypeAdapter<RecipeInstructionsEntity> {
  @override
  final int typeId = 1;

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
  final int typeId = 2;

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
  final int typeId = 3;

  @override
  EntEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EntEntity(
      id: fields[0] as int?,
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
  final int typeId = 4;

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
