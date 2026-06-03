import 'package:flutter/material.dart';

import '../config/auto_shimmer_config.dart';
import '../config/auto_shimmer_theme.dart';
import '../core/enums/auto_shimmer_direction.dart';
import '../effects/auto_shimmer_effect.dart';

/// Builds the effective shimmer config from theme values and local overrides.
class ShimmerConfigBuilder {
  /// Creates a config builder.
  const ShimmerConfigBuilder({
    this.baseColor,
    this.childBaseColor,
    this.highlightColor,
    this.duration,
    this.repeatDelay,
    this.interval,
    this.borderRadius,
    this.direction,
    this.enabled,
    this.layeredSkeleton,
    this.blockChildShimmer,
    this.onlyChildShimmer,
    this.effect,
    this.highlightOpacity,
    this.highlightWidth,
  });

  /// Optional base color override.
  final Color? baseColor;

  /// Optional child content color override.
  final Color? childBaseColor;

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

  /// Optional layered rendering override.
  final bool? layeredSkeleton;

  /// Optional parent block rendering override.
  final bool? blockChildShimmer;

  /// Optional child-only rendering override.
  final bool? onlyChildShimmer;

  /// Optional custom shimmer painting effect.
  final AutoShimmerEffect? effect;

  /// Optional highlight opacity override.
  final double? highlightOpacity;

  /// Optional highlight width override.
  final double? highlightWidth;

  /// Resolves the final config for [context].
  AutoShimmerConfig build(BuildContext context) {
    return AutoShimmerTheme.of(context).copyWith(
      baseColor: baseColor,
      childBaseColor: childBaseColor,
      highlightColor: highlightColor,
      duration: duration,
      repeatDelay: repeatDelay,
      interval: interval,
      borderRadius: borderRadius,
      direction: direction,
      enabled: enabled,
      layeredSkeleton: layeredSkeleton,
      blockChildShimmer: blockChildShimmer,
      onlyChildShimmer: onlyChildShimmer,
      effect: effect,
      highlightOpacity: highlightOpacity,
      highlightWidth: highlightWidth,
    );
  }
}
