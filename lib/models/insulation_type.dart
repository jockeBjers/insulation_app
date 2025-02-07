/// Material Model
class InsulationType {
  final String name;
  final double insulationThickness;
  final double insulationAreaPerMeter; 

  InsulationType(
      this.name, this.insulationThickness, this.insulationAreaPerMeter);
}

final List<InsulationType> materials = [
  InsulationType("30mm, 3.6m²", 0.03, 3.6),
  InsulationType("50mm, 2.7m²", 0.05, 2.7),
  InsulationType("80mm, 1.5m²", 0.08, 1.5),
];