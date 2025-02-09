class InsulationCalculator {
  double calculateLayerArea(double diameter, double thickness, double layerMultiplier) {
    return (diameter + (thickness * layerMultiplier)) * 3.1415; // Approx. Pi
  }

  double calculateArea(double diameter, double thickness, double pipeLength, double layerMultiplier) {
    double layer = calculateLayerArea(diameter, thickness, layerMultiplier);
    return pipeLength * layer ; // Area in square meters
  }

  double calculateFirstLayerArea(double diameter, double thickness, double pipeLength) {
    return calculateArea(diameter, thickness, pipeLength, 2);
  }

  double calculateSecondLayerArea(double diameter, double thickness, double pipeLength) {
    return calculateArea(diameter, thickness, pipeLength, 4);
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
