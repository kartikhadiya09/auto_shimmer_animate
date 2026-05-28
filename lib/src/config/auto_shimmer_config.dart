import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../core/constants/auto_shimmer_defaults.dart';

/// Visual and animation settings used by `AutoShimmerAnimate`.
///
/// Pass an instance to `AutoShimmerTheme` to configure a whole subtree, or pass
/// individual values to `AutoShimmerAnimate` for a single loading placeholder.
@immutable
class AutoShimmerConfig {
  /// Creates immutable shimmer configuration.
  const AutoShimmerConfig({
    this.baseColor = AutoShimmerDefaults.baseColor,
    this.highlightColor = AutoShimmerDefaults.highlightColor,
    this.duration = AutoShimmerDefaults.duration,
    this.interval = AutoShimmerDefaults.interval,
    this.borderRadius = AutoShimmerDefaults.borderRadius,
    this.direction = AutoShimmerDefaults.direction,
    this.enabled = AutoShimmerDefaults.enabled,
  });

  /// Color used to paint generated skeleton shapes.
  final Color baseColor;

  /// Color used by the shimmer highlight animation.
  final Color highlightColor;

  /// Time taken by one shimmer sweep.
  final Duration duration;

  /// Delay between repeated shimmer sweeps.
  final Duration interval;

  /// Default radius for generated skeleton boxes.
  final BorderRadius borderRadius;

  /// Direction of the shimmer sweep.
  final ShimmerDirection direction;

  /// Whether the shimmer animation should run.
  final bool enabled;

  /// Returns a copy of this config with the provided values replaced.
  AutoShimmerConfig copyWith({
    Color? baseColor,
    Color? highlightColor,
    Duration? duration,
    Duration? interval,
    BorderRadius? borderRadius,
    ShimmerDirection? direction,
    bool? enabled,
  }) {
    return AutoShimmerConfig(
      baseColor: baseColor ?? this.baseColor,
      highlightColor: highlightColor ?? this.highlightColor,
      duration: duration ?? this.duration,
      interval: interval ?? this.interval,
      borderRadius: borderRadius ?? this.borderRadius,
      direction: direction ?? this.direction,
      enabled: enabled ?? this.enabled,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AutoShimmerConfig &&
            other.baseColor == baseColor &&
            other.highlightColor == highlightColor &&
            other.duration == duration &&
            other.interval == interval &&
            other.borderRadius == borderRadius &&
            other.direction == direction &&
            other.enabled == enabled;
  }

  @override
  int get hashCode {
    return Object.hash(
      baseColor,
      highlightColor,
      duration,
      interval,
      borderRadius,
      direction,
      enabled,
    );
  }
}
