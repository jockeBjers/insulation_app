// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pipe_size.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PipeSizeImpl _$$PipeSizeImplFromJson(Map<String, dynamic> json) =>
    _$PipeSizeImpl(
      id: json['id'] as String?,
      label: json['label'] as String,
      diameter: (json['diameter'] as num).toDouble(),
    );

Map<String, dynamic> _$$PipeSizeImplToJson(_$PipeSizeImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['label'] = instance.label;
  val['diameter'] = instance.diameter;
  return val;
}
