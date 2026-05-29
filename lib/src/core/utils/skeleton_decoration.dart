import 'package:flutter/material.dart';

import '../../config/auto_shimmer_config.dart';

/// Helpers for preserving container shape while replacing visual color.
abstract final class SkeletonDecoration {
  /// Converts a decoration into a skeleton decoration.
  static Decoration from(
    Decoration? decoration,
    AutoShimmerConfig config, {
    Color? color,
  }) {
    final skeletonColor = color ?? config.surfaceColor;

    if (decoration is BoxDecoration) {
      return BoxDecoration(
        color: skeletonColor,
        borderRadius: decoration.shape == BoxShape.circle
            ? null
            : decoration.borderRadius ?? config.borderRadius,
        shape: decoration.shape,
      );
    }

    return BoxDecoration(
      color: skeletonColor,
      borderRadius: config.borderRadius,
    );
  }

  /// Returns the radius that should be used to clip a skeleton surface.
  static BorderRadiusGeometry? radiusFrom(
    Decoration? decoration,
    AutoShimmerConfig config,
  ) {
    if (decoration is BoxDecoration) {
      if (decoration.shape == BoxShape.circle) {
        return null;
      }

      return decoration.borderRadius ?? config.borderRadius;
    }

    return config.borderRadius;
  }
}
