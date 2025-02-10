import 'package:insulation_app/models/insulation_type.dart';
import 'package:insulation_app/models/pipe_size.dart';
import 'package:insulation_app/util/insulation_calculator.dart';

/// Pipe Model
class InsulatedPipe {
  final PipeSize size;
  final double length;
  final InsulationType firstLayerMaterial;
  final InsulationType? secondLayerMaterial;

  late final double insulationArea;

  InsulatedPipe({
      required this.size,
      required this.length,
      required this.firstLayerMaterial,
      this.secondLayerMaterial});

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
