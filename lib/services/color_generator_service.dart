import 'dart:math';

import 'package:flutter/material.dart';

/// Class to work with colors.
class ColorGeneratorService {
  /// Highest color value in RGB system.
  static const maxLightForColor = 255;

  /// Singleton for [ColorGeneratorService].
  static final instance = ColorGeneratorService._();

  final _random = Random();

  ColorGeneratorService._();

  /// Generate a random color.
  Color getRandomColor() {
    return Color.fromRGBO(
      _random.nextInt(maxLightForColor + 1),
      _random.nextInt(maxLightForColor + 1),
      _random.nextInt(maxLightForColor + 1),
      1,
    );
  }

  /// Returns the color that would be readable on the passed [backgroundColor].
  Color getReadableTextColor({required Color backgroundColor}) {
    final whiteContrast = _getContrast(backgroundColor, Colors.white);
    final blackContrast = _getContrast(backgroundColor, Colors.black);

    return whiteContrast > blackContrast ? Colors.white : Colors.black;
  }

  /// Get the contrast of two colors based on relative luminance.
  double _getContrast(Color color1, Color color2) {
    const contrastFormulaValue = 0.05;

    final luminance1 = _getLuminance(color1);
    final luminance2 = _getLuminance(color2);

    return (max(luminance1, luminance2) + contrastFormulaValue) /
        (min(luminance1, luminance2) + contrastFormulaValue);
  }

  /// Get luminance of the color.
  double _getLuminance(Color color) {
    const redLinearCoefficient = 0.2126;
    const greenLinearCoefficient = 0.7152;
    const blueLinearCoefficient = 0.0722;

    return redLinearCoefficient * _getSRGB(color.red) +
        greenLinearCoefficient * _getSRGB(color.green) +
        blueLinearCoefficient * _getSRGB(color.blue);
  }

  /// Get sRGB.
  /// Source of formula [https://www.w3.org/WAI/GL/wiki/Relative_luminance]
  double _getSRGB(int value) {
    // ignore: no-magic-number
    return value / maxLightForColor <= 0.03928
        // ignore: no-magic-number
        ? value / maxLightForColor / 12.92
        // ignore: no-magic-number
        : pow((value / maxLightForColor + 0.055) / 1.055, 2.4) as double;
  }
}
