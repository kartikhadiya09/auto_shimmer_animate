import 'package:flutter/material.dart';

import '../enums/auto_shimmer_direction.dart';

/// Default values used when no theme or widget overrides are provided.
abstract final class AutoShimmerDefaults {
  /// Default skeleton base color.
  static const baseColor = Color(0xFFEAEAEA);

  /// Default skeleton color for child content.
  static const childBaseColor = Color(0xFFDADADA);

  /// Default animated highlight color.
  static const highlightColor = Color(0xFFF7F7F7);

  /// Default shimmer sweep duration.
  static const duration = Duration(milliseconds: 1900);

  /// Default delay between shimmer sweeps.
  @Deprecated('Use repeatDelay instead.')
  static const interval = Duration.zero;

  /// Default delay between repeated shimmer sweeps.
  static const repeatDelay = Duration.zero;

  /// Default generated skeleton radius.
  static const borderRadius = BorderRadius.all(Radius.circular(8));

  /// Default shimmer sweep direction.
  static const direction = AutoShimmerDirection.leftToRight;

  /// Default shimmer animation state.
  static const enabled = true;

  /// Default layered skeleton rendering state.
  static const layeredSkeleton = true;
}
