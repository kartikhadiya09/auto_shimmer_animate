import 'package:flutter/material.dart';

import '../../config/auto_shimmer_config.dart';

/// Helpers for preserving container shape while replacing visual color.
abstract final class SkeletonDecoration {
  /// Converts a decoration into a skeleton decoration.
  static Decoration from(Decoration? decoration, AutoShimmerConfig config) {
    if (decoration is BoxDecoration) {
      return BoxDecoration(
        color: config.baseColor,
        borderRadius: decoration.shape == BoxShape.circle
            ? null
            : decoration.borderRadius ?? config.borderRadius,
        shape: decoration.shape,
      );
    }

    return BoxDecoration(
      color: config.baseColor,
      borderRadius: config.borderRadius,
    );
  }
}
