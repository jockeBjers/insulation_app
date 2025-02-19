import 'package:hive/hive.dart';

part 'insulation_type.g.dart';

@HiveType(typeId: 2)
class InsulationType extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final double insulationThickness;
  @HiveField(2)
  final double insulationAreaPerMeter;

  InsulationType(
      this.name, this.insulationThickness, this.insulationAreaPerMeter);
}

final List<InsulationType> materials = [
  InsulationType("30mm, 3.6m²", 0.03, 3.6),
  InsulationType("50mm, 2.7m²", 0.05, 2.7),
  InsulationType("80mm, 1.5m²", 0.08, 1.5),
];
