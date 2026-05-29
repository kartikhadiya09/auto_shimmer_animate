import 'package:flutter/material.dart';

import '../config/auto_shimmer_config.dart';
import '../config/auto_shimmer_theme.dart';
import '../core/enums/auto_shimmer_direction.dart';

/// Builds the effective shimmer config from theme values and local overrides.
class ShimmerConfigBuilder {
  /// Creates a config builder.
  const ShimmerConfigBuilder({
    this.baseColor,
    this.highlightColor,
    this.duration,
    this.repeatDelay,
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

  /// Optional repeat delay override.
  final Duration? repeatDelay;

  /// Optional interval override.
  @Deprecated('Use repeatDelay instead.')
  final Duration? interval;

  /// Optional border radius override.
  final BorderRadius? borderRadius;

  /// Optional shimmer direction override.
  final AutoShimmerDirection? direction;

  /// Optional animation enabled override.
  final bool? enabled;

  /// Resolves the final config for [context].
  AutoShimmerConfig build(BuildContext context) {
    return AutoShimmerTheme.of(context).copyWith(
      baseColor: baseColor,
      highlightColor: highlightColor,
      duration: duration,
      repeatDelay: repeatDelay,
      interval: interval,
      borderRadius: borderRadius,
      direction: direction,
      enabled: enabled,
    );
  }
}
