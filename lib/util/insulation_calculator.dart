class InsulationCalculator {
  double calculateLayerArea(
      double diameter, double thickness, double layerMultiplier) {
    return (diameter + (thickness * layerMultiplier)) * 3.1415;
  }

  double calculateArea(double diameter, double thickness, double pipeLength,
      double layerMultiplier) {
    double layer = calculateLayerArea(diameter, thickness, layerMultiplier);
    return pipeLength * layer;
  }

  double calculateFirstLayerArea(
      double diameter, double thickness, double pipeLength) {
    return calculateArea(diameter, thickness, pipeLength, 2);
  }

  double calculateSecondLayerArea(
      double diameter, double thickness, double pipeLength) {
    return calculateArea(diameter, thickness, pipeLength, 4);
  }

  double calculateRectangularPerimeter(
      double sideA, double sideB, double extraThickness) {
    return 2 * (sideA + extraThickness) + 2 * (sideB + extraThickness);
  }

  double calculateRectangularFirstLayerArea(
      double sideA, double sideB, double thickness, double pipeLength) {
    final perimeter = calculateRectangularPerimeter(sideA, sideB, thickness);
    return perimeter * pipeLength;
  }

  double calculateRectangularSecondLayerArea(double sideA, double sideB,
      double firstThickness, double secondThickness, double pipeLength) {
    final totalThickness = firstThickness + secondThickness;
    final perimeter =
        calculateRectangularPerimeter(sideA, sideB, totalThickness);
    return perimeter * pipeLength;
  }

  double calculateTotalArea(double firstLayerArea, double secondLayerArea) {
    return firstLayerArea + secondLayerArea;
  }

  double calculateRolls(double area, double rollArea) {
    return area / rollArea;
  }

  double calculateTotalRolls(double rollsFirstLayer, double rollsSecondLayer) {
    return rollsFirstLayer + rollsSecondLayer;
  }
}
