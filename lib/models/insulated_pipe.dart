import 'package:hive/hive.dart';
import 'package:insulation_app/models/insulation_type.dart';
import 'package:insulation_app/models/pipe_size.dart';
import 'package:insulation_app/util/insulation_calculator.dart';

part 'insulated_pipe.g.dart';

@HiveType(typeId: 1)
class InsulatedPipe extends HiveObject {
  @HiveField(0)
  PipeSize size;

  @HiveField(1)
  double length;

  @HiveField(2)
  InsulationType firstLayerMaterial;

  @HiveField(3)
  InsulationType? secondLayerMaterial;
  InsulatedPipe({
    required this.size,
    required this.length,
    required this.firstLayerMaterial,
    this.secondLayerMaterial,
  });

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
