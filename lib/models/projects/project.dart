// ignore_for_file: invalid_annotation_target

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:insulation_app/models/insulated_pipes/insulated_pipe.dart';

part 'project.freezed.dart';
part 'project.g.dart';

@freezed
class Project with _$Project {
  const Project._();

  const factory Project({
    @JsonKey(includeIfNull: false) String? id,
    required String projectNumber,
    required String name,
    required DateTime date,
    @JsonKey(includeIfNull: false) String? organizationId,
    required List<InsulatedPipe> pipes,
    @JsonKey(includeIfNull: false) String? address,
    @JsonKey(includeIfNull: false) String? contactPerson,
    @JsonKey(includeIfNull: false) String? contactNumber,
  }) = _Project;

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  factory Project.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    // Convert Timestamp to DateTime if needed
    final dynamic dateValue = data['date'];
    final DateTime date = dateValue is Timestamp
        ? dateValue.toDate()
        : DateTime.tryParse(dateValue.toString()) ?? DateTime.now();

    // Handle pipes list conversion
    final List<dynamic> pipesData = data['pipes'] ?? [];
    final List<InsulatedPipe> pipes = pipesData.map((pipeData) {
      if (pipeData is DocumentReference) {
        // This will be a future implementation if you store references
        // You'll need to fetch each pipe document
        throw UnimplementedError('Document references not yet implemented');
      } else {
        // If pipes are stored as nested objects
        return InsulatedPipe.fromJson(
            {'id': pipeData['id'], ...pipeData as Map<String, dynamic>});
      }
    }).toList();

    return Project(
      id: doc.id,
      projectNumber: data['projectNumber'] ?? '',
      name: data['name'] ?? '',
      date: date,
      organizationId: data['organizationId'] ?? '',
      pipes: pipes,
      address: data['address'],
      contactPerson: data['contactPerson'],
      contactNumber: data['contactNumber'],
    );
  }

  Map<String, dynamic> toFirestore() {
    final Map<String, dynamic> data = {};

    // Add all required and non-null fields
    data['projectNumber'] = projectNumber;
    data['name'] = name;
    data['date'] = date;

    // Add optional fields only if they're not null
    if (organizationId != null) data['organizationId'] = organizationId;
    if (address != null) data['address'] = address;
    if (contactPerson != null) data['contactPerson'] = contactPerson;
    if (contactNumber != null) data['contactNumber'] = contactNumber;

    // Convert pipes to serializable format - using the pipe's toFirestore method
    data['pipes'] = pipes.map((pipe) => pipe.toFirestore()).toList();

    return data;
  }
}
