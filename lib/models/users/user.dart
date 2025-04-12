// ignore_for_file: invalid_annotation_target

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const User._();

  const factory User({
    @JsonKey(includeIfNull: false) String? id,
    required String email,
    required String name,
    required String organizationId,
    @JsonKey(includeIfNull: false) String? phone,
    @JsonKey(includeIfNull: false) Map<String, dynamic>? preferences,
    @JsonKey(includeIfNull: false) String? role,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    // Convert role to string if it's a list
    var roleData = data['role'];
    if (roleData is List && roleData.isNotEmpty) {
      // Take first item from the list
      data['role'] = roleData[0].toString();
    }

    return User.fromJson({
      'id': doc.id,
      ...data,
    });
  }

  Map<String, dynamic> toFirestore() {
    final data = toJson();
    if (data.containsKey('id')) {
      data.remove('id');
    }
    return data;
  }

  bool hasRole(String roleToCheck) {
    // Simple string comparison now that role is a string
    return role == roleToCheck;
  }
}
