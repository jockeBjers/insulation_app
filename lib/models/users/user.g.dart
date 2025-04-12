// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String?,
      email: json['email'] as String,
      name: json['name'] as String,
      organizationId: json['organizationId'] as String,
      phone: json['phone'] as String?,
      preferences: json['preferences'] as Map<String, dynamic>?,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['email'] = instance.email;
  val['name'] = instance.name;
  val['organizationId'] = instance.organizationId;
  writeNotNull('phone', instance.phone);
  writeNotNull('preferences', instance.preferences);
  writeNotNull('role', instance.role);
  return val;
}
