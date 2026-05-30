import 'package:flutter/material.dart';

import 'auto_shimmer_colors.dart';
import '../enums/auto_shimmer_direction.dart';

/// Default values used when no theme or widget overrides are provided.
abstract final class AutoShimmerDefaults {
  /// Default skeleton base color.
  static const baseColor = AutoShimmerColors.base;

  /// Default skeleton color for child content.
  static const childBaseColor = AutoShimmerColors.childBase;

  /// Default animated highlight color.
  static const highlightColor = AutoShimmerColors.highlight;

  /// Default shimmer sweep duration.
  static const duration = Duration(milliseconds: 1600);

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

  /// Default per-element shimmer rendering state.
  static const perElementShimmer = true;

  /// Default shimmer highlight opacity.
  static const highlightOpacity = 0.35;

  /// Default shimmer highlight width.
  static const highlightWidth = 0.12;
}
