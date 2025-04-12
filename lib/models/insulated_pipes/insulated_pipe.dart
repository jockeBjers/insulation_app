// ignore_for_file: invalid_annotation_target

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:insulation_app/models/insulation_type/insulation_type.dart';
import 'package:insulation_app/models/pipe_size/pipe_size.dart';
import 'package:insulation_app/util/insulation_calculator.dart';

part 'insulated_pipe.freezed.dart';
part 'insulated_pipe.g.dart';

@freezed
class InsulatedPipe with _$InsulatedPipe {
  const InsulatedPipe._();

  const factory InsulatedPipe({
    @JsonKey(includeIfNull: false) String? id,
    required PipeSize size,
    required double length,
    required InsulationType firstLayerMaterial,
    @JsonKey(includeIfNull: false) InsulationType? secondLayerMaterial,
  }) = _InsulatedPipe;

  factory InsulatedPipe.fromJson(Map<String, dynamic> json) =>
      _$InsulatedPipeFromJson(json);

  factory InsulatedPipe.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return InsulatedPipe.fromJson({
      'id': doc.id,
      ...data,
    });
  }

  Map<String, dynamic> toFirestore() {
    final Map<String, dynamic> data = {};

    // Only include non-null fields
    if (id != null) data['id'] = id;
    data['length'] = length;

    // Manually serialize nested objects to plain maps
    data['size'] = {
      'id': size.id,
      'label': size.label,
      'diameter': size.diameter,
    };

    data['firstLayerMaterial'] = {
      'id': firstLayerMaterial.id,
      'name': firstLayerMaterial.name,
      'insulationThickness': firstLayerMaterial.insulationThickness,
      'insulationAreaPerMeter': firstLayerMaterial.insulationAreaPerMeter,
    };

    if (secondLayerMaterial != null) {
      data['secondLayerMaterial'] = {
        'id': secondLayerMaterial!.id,
        'name': secondLayerMaterial!.name,
        'insulationThickness': secondLayerMaterial!.insulationThickness,
        'insulationAreaPerMeter': secondLayerMaterial!.insulationAreaPerMeter,
      };
    }

    return data;
  }

  double getFirstLayerArea() {
    return InsulationCalculator().calculateFirstLayerArea(
        size.diameter, firstLayerMaterial.insulationThickness, length);
  }

  double getSecondLayerArea() {
    if (secondLayerMaterial == null) return 0;
    return InsulationCalculator().calculateSecondLayerArea(
      size.diameter,
      secondLayerMaterial!.insulationThickness,
      length,
    );
  }

  double getTotalArea() {
    return getFirstLayerArea() + getSecondLayerArea();
  }

  double getFirstLayerRolls() {
    return InsulationCalculator().calculateRolls(
        getFirstLayerArea(), firstLayerMaterial.insulationAreaPerMeter);
  }

  double getSecondLayerRolls() {
    if (secondLayerMaterial == null) return 0;
    return InsulationCalculator().calculateRolls(
      getSecondLayerArea(),
      secondLayerMaterial!.insulationAreaPerMeter,
    );
  }

  double getTotalRolls() {
    return getFirstLayerRolls() + getSecondLayerRolls();
  }
}
