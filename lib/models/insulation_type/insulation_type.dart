// ignore_for_file: invalid_annotation_target

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'insulation_type.freezed.dart';
part 'insulation_type.g.dart';

@freezed
class InsulationType with _$InsulationType {
  const InsulationType._();

  const factory InsulationType({
    @JsonKey(includeIfNull: false) String? id,
    required String name,
    required double insulationThickness,
    required double insulationAreaPerMeter,
  }) = _InsulationType;

  factory InsulationType.fromJson(Map<String, dynamic> json) =>
      _$InsulationTypeFromJson(json);

  factory InsulationType.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return InsulationType.fromJson({
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
}

final List<InsulationType> materials = [
  const InsulationType(
      id: '1',
      name: "30mm, 3.6m²",
      insulationThickness: 0.03,
      insulationAreaPerMeter: 3.6),
  const InsulationType(
      id: '2',
      name: "50mm, 2.7m²",
      insulationThickness: 0.05,
      insulationAreaPerMeter: 2.7),
  const InsulationType(
      id: '3',
      name: "80mm, 1.5m²",
      insulationThickness: 0.08,
      insulationAreaPerMeter: 1.5),
];
