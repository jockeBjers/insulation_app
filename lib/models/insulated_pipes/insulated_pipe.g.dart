// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insulated_pipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InsulatedPipeImpl _$$InsulatedPipeImplFromJson(Map<String, dynamic> json) =>
    _$InsulatedPipeImpl(
      id: json['id'] as String?,
      size: PipeSize.fromJson(json['size'] as Map<String, dynamic>),
      length: (json['length'] as num).toDouble(),
      firstLayerMaterial: InsulationType.fromJson(
          json['firstLayerMaterial'] as Map<String, dynamic>),
      secondLayerMaterial: json['secondLayerMaterial'] == null
          ? null
          : InsulationType.fromJson(
              json['secondLayerMaterial'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$InsulatedPipeImplToJson(_$InsulatedPipeImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['size'] = instance.size;
  val['length'] = instance.length;
  val['firstLayerMaterial'] = instance.firstLayerMaterial;
  writeNotNull('secondLayerMaterial', instance.secondLayerMaterial);
  return val;
}
