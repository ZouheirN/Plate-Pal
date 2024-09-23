// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_instructions_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeInstructionsModelAdapter
    extends TypeAdapter<RecipeInstructionsModel> {
  @override
  final int typeId = 5;

  @override
  RecipeInstructionsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecipeInstructionsModel(
      name: fields[0] as String?,
      steps: (fields[1] as List?)?.cast<StepModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, RecipeInstructionsModel obj) {
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
      other is RecipeInstructionsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StepModelAdapter extends TypeAdapter<StepModel> {
  @override
  final int typeId = 6;

  @override
  StepModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StepModel(
      equipment: (fields[0] as List?)?.cast<Ent>(),
      ingredients: (fields[1] as List?)?.cast<Ent>(),
      number: fields[2] as num?,
      step: fields[3] as String?,
      length: fields[4] as Length?,
    );
  }

  @override
  void write(BinaryWriter writer, StepModel obj) {
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
      other is StepModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EntAdapter extends TypeAdapter<Ent> {
  @override
  final int typeId = 7;

  @override
  Ent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ent(
      id: fields[0] as int?,
      image: fields[1] as String?,
      name: fields[2] as String?,
      temperature: fields[3] as Length?,
    );
  }

  @override
  void write(BinaryWriter writer, Ent obj) {
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
      other is EntAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LengthAdapter extends TypeAdapter<Length> {
  @override
  final int typeId = 8;

  @override
  Length read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Length(
      number: fields[0] as num?,
      unit: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Length obj) {
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
      other is LengthAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
