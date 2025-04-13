// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insulation_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InsulationTypeImpl _$$InsulationTypeImplFromJson(Map<String, dynamic> json) =>
    _$InsulationTypeImpl(
      id: json['id'] as String?,
      name: json['name'] as String,
      insulationThickness: (json['insulationThickness'] as num).toDouble(),
      insulationAreaPerMeter:
          (json['insulationAreaPerMeter'] as num).toDouble(),
    );

Map<String, dynamic> _$$InsulationTypeImplToJson(
    _$InsulationTypeImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['name'] = instance.name;
  val['insulationThickness'] = instance.insulationThickness;
  val['insulationAreaPerMeter'] = instance.insulationAreaPerMeter;
  return val;
}
