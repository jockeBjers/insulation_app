import 'package:flutter_test/flutter_test.dart';
import 'package:insulation_app/util/insulation_calculator.dart';

void main() {
  late InsulationCalculator calculator;

  setUp(() {
    calculator = InsulationCalculator();
  });

  group('InsulationCalculator', () {
    group('calculateLayerArea', () {
      test('should calculate layer area correctly', () {
        // Arrange
        const double diameter = 0.1;
        const double thickness = 0.05;
        const double layerMultiplier = 2.0;

        // Act
        final result =
            calculator.calculateLayerArea(diameter, thickness, layerMultiplier);

        // Assert
        expect(result, closeTo(0.62, 0.01));
      });
    });
  });
}
