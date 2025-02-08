import 'package:insulation_app/models/insulation_type.dart';
import 'package:insulation_app/models/pipe_size.dart';
import 'package:insulation_app/util/insulation_calculator';

/// Pipe Model
class InsulatedPipe {
  final PipeSize size;
  final double length;
  final InsulationType material;

  InsulatedPipe({
    required this.size,
    required this.length,
    required this.material,
  });

  double getFirstLayerArea() {
    return InsulationCalculator().calculateFirstLayerArea(size.diameter, material.insulationThickness, length);
  }

  double getSecondLayerArea() {
    return InsulationCalculator().calculateSecondLayerArea(size.diameter, material.insulationThickness, length);
  }

  double getTotalArea() {
    return getFirstLayerArea() + getSecondLayerArea();
  }

  double getFirstLayerRolls() {
    return InsulationCalculator().calculateRolls(getFirstLayerArea(), material.insulationAreaPerMeter);
  }

  double getSecondLayerRolls() {
    return InsulationCalculator().calculateRolls(getSecondLayerArea(), material.insulationAreaPerMeter);
  }

  double getTotalRolls() {
    return getFirstLayerRolls() + getSecondLayerRolls();
  }
}
