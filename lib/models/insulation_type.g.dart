// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insulation_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InsulationTypeAdapter extends TypeAdapter<InsulationType> {
  @override
  final int typeId = 2;

  @override
  InsulationType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InsulationType(
      fields[0] as String,
      fields[1] as double,
      fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, InsulationType obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.insulationThickness)
      ..writeByte(2)
      ..write(obj.insulationAreaPerMeter);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InsulationTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
