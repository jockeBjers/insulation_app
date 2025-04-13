// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectImpl _$$ProjectImplFromJson(Map<String, dynamic> json) =>
    _$ProjectImpl(
      id: json['id'] as String?,
      projectNumber: json['projectNumber'] as String,
      name: json['name'] as String,
      date: DateTime.parse(json['date'] as String),
      organizationId: json['organizationId'] as String?,
      pipes: (json['pipes'] as List<dynamic>)
          .map((e) => InsulatedPipe.fromJson(e as Map<String, dynamic>))
          .toList(),
      address: json['address'] as String?,
      contactPerson: json['contactPerson'] as String?,
      contactNumber: json['contactNumber'] as String?,
    );

Map<String, dynamic> _$$ProjectImplToJson(_$ProjectImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['projectNumber'] = instance.projectNumber;
  val['name'] = instance.name;
  val['date'] = instance.date.toIso8601String();
  writeNotNull('organizationId', instance.organizationId);
  val['pipes'] = instance.pipes;
  writeNotNull('address', instance.address);
  writeNotNull('contactPerson', instance.contactPerson);
  writeNotNull('contactNumber', instance.contactNumber);
  return val;
}
