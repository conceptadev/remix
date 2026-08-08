library radix_colors; // moved to radix/colors/

import 'package:flutter/painting.dart';

part 'colors_generated.dart';

class RadixColor {
  final RadixColorScale scale;
  final Color surface;
  final Color indicator;
  final Color track;
  final Color contrast;

  const RadixColor(
    this.scale,
    this.surface,
    this.indicator,
    this.track,
    this.contrast,
  );
}

class RadixColorTheme {
  final RadixColor light;
  final RadixColor dark;

  const RadixColorTheme(this.light, this.dark);
}

class RadixColorScale {
  final ColorSwatch<int> solid;
  final ColorSwatch<int> alpha;

  const RadixColorScale(this.solid, this.alpha);

  // Semantic color accessors for better code readability

  /// The most subtle background color (step 1).
  Color get appBackground => step(1);

  /// Subtle background with slightly more presence (step 2).
  Color get subtleBackground => step(2);

  /// Default background for interactive components (step 3).
  Color get componentBackground => step(3);

  /// Background color for components on hover (step 4).
  Color get componentBackgroundHover => step(4);

  /// Background color for active/pressed components (step 5).
  Color get componentBackgroundActive => step(5);

  /// Subtle border color for gentle separation (step 6).
  Color get subtleBorder => step(6);

  /// Standard border color for components (step 7).
  Color get componentBorder => step(7);

  /// Border color for hover and focus states (step 8).
  Color get componentBorderHover => step(8);

  /// Primary solid background color (step 9).
  Color get solidBackground => step(9);

  /// Solid background color on hover (step 10).
  Color get solidBackgroundHover => step(10);

  /// Low contrast text color (step 11).
  Color get lowContrastText => step(11);

  /// High contrast text color (step 12).
  Color get highContrastText => step(12);

  /// Gets a solid color from the 12-step scale.
  ///
  /// Steps must be between 1 and 12. Falls back to step 9 if unavailable.
  Color step(int n) {
    assert(n >= 1 && n <= 12, 'Step must be between 1 and 12');

    return solid[n] ?? solid[9]!;
  }

  /// Gets a translucent color from the 12-step alpha scale.
  ///
  /// Alpha variants maintain saturation when composited.
  /// Falls back to alpha step 9 if unavailable.
  Color alphaStep(int n) {
    assert(n >= 1 && n <= 12, 'Step must be between 1 and 12');

    return alpha[n] ?? alpha[9]!;
  }
}
