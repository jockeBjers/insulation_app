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

    group('calculateArea', () {
      test('should calculate area correctly', () {
        // Arrange
        const double diameter = 0.1;
        const double thickness = 0.05;
        const double pipeLength = 10.0;
        const double layerMultiplier = 2.0;

        // Act
        final result = calculator.calculateArea(
            diameter, thickness, pipeLength, layerMultiplier);

        // Assert
        const layerArea = (diameter + (thickness * layerMultiplier)) * 3.1415;
        expect(result, equals(layerArea * pipeLength));
      });
    });

    group('calculateFirstLayerArea', () {
      test(
          'should calculate first layer area correctly with layerMultiplier = 2',
          () {
        // Arrange
        const double diameter = 0.1;
        const double thickness = 0.05;
        const double pipeLength = 10.0;

        // Act
        final result = calculator
            .calculateFirstLayerArea(diameter, thickness, pipeLength)
            .ceil();

        // Assert
        expect(result, equals(7));
      });
    });

    group('calculateSecondLayerArea', () {
      test(
          'should calculate second layer area correctly with layerMultiplier = 4',
          () {
        // Arrange
        const double diameter = 0.1;
        const double thickness = 0.05;
        const double pipeLength = 10;

        // Act
        final result = calculator
            .calculateSecondLayerArea(diameter, thickness, pipeLength)
            .ceil();

        // Assert
        expect(result, equals(10));
      });
    });

    group('calculateTotalArea', () {
      test('should calculate total area correctly', () {
        // Arrange
        const double firstLayerArea = 110;
        const double secondLayerArea = 141;

        // Act
        final result =
            calculator.calculateTotalArea(firstLayerArea, secondLayerArea);

        // Assert
        expect(result, equals(firstLayerArea + secondLayerArea));
        expect(result, equals(251));
      });
    });

    group('calculateRolls', () {
      test('should calculate rolls correctly', () {
        // Arrange
        const double area = 110;
        const double rollArea = 2.7;

        // Act
        final result = calculator.calculateRolls(area, rollArea).round();

        // Assert
        expect(result, equals(41));
      });
    });

    group('calculateTotalRolls', () {
      test('should calculate total rolls correctly', () {
        // Arrange
        const double rollsFirstLayer = 12;
        const double rollsSecondLayer = 16;

        // Act
        final result =
            calculator.calculateTotalRolls(rollsFirstLayer, rollsSecondLayer);

        // Assert
        expect(result, equals(rollsFirstLayer + rollsSecondLayer));
        expect(result, equals(28));
      });
    });

    group('calculateRectangularFirstLayerArea', () {
      test('should calculate first layer area', () {
        // arrange
        const double sideA = 0.8;
        const double sideB = 0.7;
        const double thickness = 0.05;
        const double pipeLength = 10;

        // act
        final result = calculator.calculateRectangularFirstLayerArea(
            sideA, sideB, thickness, pipeLength);

        // assert
        expect(result, closeTo(32, 0.01));
      });
    });

    group('calculateRectangularSecondLayerArea', () {
      test('should calculate second layer area', () {
        // arrange
        const double sideA = 0.7;
        const double sideB = 0.8;
        const double thicknessOne = 0.05;
        const double thicknessTwo = 0.05;
        const double pipeLength = 10;

        // act
        final result = calculator.calculateRectangularSecondLayerArea(
            sideA, sideB, thicknessOne, thicknessTwo, pipeLength);

        // assert
        expect(result, closeTo(34, 0.01));
      });
    });
  });
}
