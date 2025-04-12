// ignore_for_file: invalid_annotation_target

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'organization.freezed.dart';
part 'organization.g.dart';

@freezed
class Organization with _$Organization {
  const Organization._();

  const factory Organization({
    @JsonKey(includeIfNull: false) String? id,
    required String name,
    @JsonKey(includeIfNull: false) String? address,
    @JsonKey(includeIfNull: false) String? phone,
    @JsonKey(includeIfNull: false) String? email,
    @JsonKey(includeIfNull: false) String? website,
    @JsonKey(includeIfNull: false) Map<String, dynamic>? metadata,
  }) = _Organization;

  factory Organization.fromJson(Map<String, dynamic> json) =>
      _$OrganizationFromJson(json);

  factory Organization.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Organization.fromJson({
      'id': doc.id,
      ...data,
    });
  }

  Map<String, dynamic> toFirestore() {
    final data = toJson();
    // Remove id as Firestore manages document IDs
    if (data.containsKey('id')) {
      data.remove('id');
    }
    return data;
  }
}
