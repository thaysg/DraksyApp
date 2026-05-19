// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_progress_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LessonProgressModelAdapter extends TypeAdapter<LessonProgressModel> {
  @override
  final typeId = 0;

  @override
  LessonProgressModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LessonProgressModel(
      unitId: fields[0] as String,
      nodeId: fields[1] as String,
      isCompleted: fields[2] as bool,
      xpEarned: (fields[3] as num).toInt(),
      completedAt: fields[4] as String?,
      accuracy: fields[5] == null ? 0.0 : (fields[5] as num).toDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, LessonProgressModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.unitId)
      ..writeByte(1)
      ..write(obj.nodeId)
      ..writeByte(2)
      ..write(obj.isCompleted)
      ..writeByte(3)
      ..write(obj.xpEarned)
      ..writeByte(4)
      ..write(obj.completedAt)
      ..writeByte(5)
      ..write(obj.accuracy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonProgressModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
