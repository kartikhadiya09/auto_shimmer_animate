import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

/// Default values used when no theme or widget overrides are provided.
abstract final class AutoShimmerDefaults {
  /// Default skeleton base color.
  static const baseColor = Color(0xFFE0E0E0);

  /// Default animated highlight color.
  static const highlightColor = Color(0xFFF5F5F5);

  /// Default shimmer sweep duration.
  static const duration = Duration(milliseconds: 1500);

  /// Default delay between shimmer sweeps.
  static const interval = Duration.zero;

  /// Default generated skeleton radius.
  static const borderRadius = BorderRadius.all(Radius.circular(8));

  /// Default shimmer sweep direction.
  static const direction = ShimmerDirection.fromLTRB();

  /// Default shimmer animation state.
  static const enabled = true;
}
