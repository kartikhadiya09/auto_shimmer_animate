import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../config/auto_shimmer_config.dart';
import '../config/auto_shimmer_theme.dart';

/// Builds the effective shimmer config from theme values and local overrides.
class ShimmerConfigBuilder {
  /// Creates a config builder.
  const ShimmerConfigBuilder({
    this.baseColor,
    this.highlightColor,
    this.duration,
    this.interval,
    this.borderRadius,
    this.direction,
    this.enabled,
  });

  /// Optional base color override.
  final Color? baseColor;

  /// Optional highlight color override.
  final Color? highlightColor;

  /// Optional duration override.
  final Duration? duration;

  /// Optional interval override.
  final Duration? interval;

  /// Optional border radius override.
  final BorderRadius? borderRadius;

  /// Optional shimmer direction override.
  final ShimmerDirection? direction;

  /// Optional animation enabled override.
  final bool? enabled;

  /// Resolves the final config for [context].
  AutoShimmerConfig build(BuildContext context) {
    return AutoShimmerTheme.of(context).copyWith(
      baseColor: baseColor,
      highlightColor: highlightColor,
      duration: duration,
      interval: interval,
      borderRadius: borderRadius,
      direction: direction,
      enabled: enabled,
    );
  }
}
