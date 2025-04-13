// ignore_for_file: invalid_annotation_target

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pipe_size.freezed.dart';
part 'pipe_size.g.dart';

@freezed
class PipeSize with _$PipeSize {
  const PipeSize._();

  const factory PipeSize({
    @JsonKey(includeIfNull: false) String? id,
    required String label,
    required double diameter,
  }) = _PipeSize;

  factory PipeSize.fromJson(Map<String, dynamic> json) =>
      _$PipeSizeFromJson(json);

  factory PipeSize.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PipeSize.fromJson({
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

final List<PipeSize> pipeSizes = [
  const PipeSize(id: '1', label: "100 mm", diameter: 0.1),
  const PipeSize(id: '2', label: "125 mm", diameter: 0.125),
  const PipeSize(id: '3', label: "165 mm", diameter: 0.165),
  const PipeSize(id: '4', label: "200 mm", diameter: 0.2),
  const PipeSize(id: '5', label: "250 mm", diameter: 0.25),
  const PipeSize(id: '6', label: "315 mm", diameter: 0.315),
  const PipeSize(id: '7', label: "400 mm", diameter: 0.4),
  const PipeSize(id: '8', label: "500 mm", diameter: 0.5),
  const PipeSize(id: '9', label: "630 mm", diameter: 0.63),
  const PipeSize(id: '10', label: "800 mm", diameter: 0.8),
];
