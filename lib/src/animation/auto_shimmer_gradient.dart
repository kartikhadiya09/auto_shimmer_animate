import 'package:flutter/material.dart';

import '../core/enums/auto_shimmer_direction.dart';

/// Helpers for building subtle shimmer gradients.
abstract final class AutoShimmerGradient {
  static const _center = 0.5;

  /// Returns a safe highlight width for gradient stops.
  static double clampedWidth(double width) {
    return width.clamp(0.02, 1.0).toDouble();
  }

  /// Returns a safe highlight opacity.
  static double clampedOpacity(double opacity) {
    return opacity.clamp(0.0, 1.0).toDouble();
  }

  /// Blends [highlightColor] into [baseColor] using [highlightOpacity].
  static Color effectiveHighlight(
    Color baseColor,
    Color highlightColor,
    double highlightOpacity,
  ) {
    return Color.lerp(
      baseColor,
      highlightColor,
      clampedOpacity(highlightOpacity),
    )!;
  }

  /// Returns narrow shimmer stops centered in the gradient.
  static List<double> stops(double highlightWidth) {
    final half = clampedWidth(highlightWidth) / 2;

    return [
      0.0,
      (_center - half).clamp(0.0, 1.0).toDouble(),
      _center,
      (_center + half).clamp(0.0, 1.0).toDouble(),
      1.0,
    ];
  }

  /// Returns slide offset from outside start to outside end.
  static double slide(double progress, AutoShimmerDirection direction) {
    final value = progress.clamp(0.0, 1.0).toDouble();

    return switch (direction) {
      AutoShimmerDirection.leftToRight ||
      AutoShimmerDirection.topToBottom =>
        -1.0 + (value * 3.0),
      AutoShimmerDirection.rightToLeft ||
      AutoShimmerDirection.bottomToTop =>
        2.0 - (value * 3.0),
    };
  }
}
