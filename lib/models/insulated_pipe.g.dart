// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insulated_pipe.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InsulatedPipeAdapter extends TypeAdapter<InsulatedPipe> {
  @override
  final int typeId = 1;

  @override
  InsulatedPipe read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InsulatedPipe(
      size: fields[0] as PipeSize,
      length: fields[1] as double,
      firstLayerMaterial: fields[2] as InsulationType,
      secondLayerMaterial: fields[3] as InsulationType?,
    );
  }

  @override
  void write(BinaryWriter writer, InsulatedPipe obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.size)
      ..writeByte(1)
      ..write(obj.length)
      ..writeByte(2)
      ..write(obj.firstLayerMaterial)
      ..writeByte(3)
      ..write(obj.secondLayerMaterial);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InsulatedPipeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
