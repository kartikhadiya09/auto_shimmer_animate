import 'package:flutter/material.dart';

import '../core/constants/auto_shimmer_defaults.dart';
import '../core/enums/auto_shimmer_direction.dart';

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
    Duration? repeatDelay,
    this.interval = AutoShimmerDefaults.interval,
    this.borderRadius = AutoShimmerDefaults.borderRadius,
    this.direction = AutoShimmerDefaults.direction,
    this.enabled = AutoShimmerDefaults.enabled,
  }) : _repeatDelay = repeatDelay;

  /// Color used to paint generated skeleton shapes.
  final Color baseColor;

  /// Color used by the shimmer highlight animation.
  final Color highlightColor;

  /// Time taken by one shimmer sweep.
  final Duration duration;

  final Duration? _repeatDelay;

  /// Delay between repeated shimmer sweeps.
  Duration get repeatDelay => _repeatDelay ?? interval;

  /// Delay between repeated shimmer sweeps.
  @Deprecated('Use repeatDelay instead.')
  final Duration interval;

  /// Delay used by the internal shimmer engine.
  Duration get effectiveRepeatDelay => _repeatDelay ?? interval;

  /// Default radius for generated skeleton boxes.
  final BorderRadius borderRadius;

  /// Direction of the shimmer sweep.
  final AutoShimmerDirection direction;

  /// Whether the shimmer animation should run.
  final bool enabled;

  /// Returns a copy of this config with the provided values replaced.
  AutoShimmerConfig copyWith({
    Color? baseColor,
    Color? highlightColor,
    Duration? duration,
    Duration? repeatDelay,
    Duration? interval,
    BorderRadius? borderRadius,
    AutoShimmerDirection? direction,
    bool? enabled,
  }) {
    return AutoShimmerConfig(
      baseColor: baseColor ?? this.baseColor,
      highlightColor: highlightColor ?? this.highlightColor,
      duration: duration ?? this.duration,
      repeatDelay: repeatDelay ?? _repeatDelay,
      // ignore: deprecated_member_use_from_same_package
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
            other.effectiveRepeatDelay == effectiveRepeatDelay &&
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
      effectiveRepeatDelay,
      borderRadius,
      direction,
      enabled,
    );
  }
}
