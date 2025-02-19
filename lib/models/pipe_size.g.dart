// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pipe_size.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PipeSizeAdapter extends TypeAdapter<PipeSize> {
  @override
  final int typeId = 3;

  @override
  PipeSize read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PipeSize(
      fields[0] as String,
      fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, PipeSize obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.label)
      ..writeByte(1)
      ..write(obj.diameter);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PipeSizeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
