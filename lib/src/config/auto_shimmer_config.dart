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
    Color? baseColor,
    Color? childBaseColor,
    Color? highlightColor,
    Duration? duration,
    Duration? repeatDelay,
    @Deprecated('Use repeatDelay instead.') Duration? interval,
    BorderRadius? borderRadius,
    AutoShimmerDirection? direction,
    bool? enabled,
    bool? layeredSkeleton,
    bool? perElementShimmer,
    double? highlightOpacity,
    double? highlightWidth,
  })  : baseColor = baseColor ?? AutoShimmerDefaults.baseColor,
        childBaseColor = childBaseColor ?? AutoShimmerDefaults.childBaseColor,
        highlightColor = highlightColor ?? AutoShimmerDefaults.highlightColor,
        duration = duration ?? AutoShimmerDefaults.duration,
        _repeatDelay = repeatDelay,
        // ignore: deprecated_member_use_from_same_package
        interval = interval ?? AutoShimmerDefaults.interval,
        borderRadius = borderRadius ?? AutoShimmerDefaults.borderRadius,
        direction = direction ?? AutoShimmerDefaults.direction,
        enabled = enabled ?? AutoShimmerDefaults.enabled,
        layeredSkeleton =
            layeredSkeleton ?? AutoShimmerDefaults.layeredSkeleton,
        perElementShimmer =
            perElementShimmer ?? AutoShimmerDefaults.perElementShimmer,
        highlightOpacity =
            highlightOpacity ?? AutoShimmerDefaults.highlightOpacity,
        highlightWidth = highlightWidth ?? AutoShimmerDefaults.highlightWidth;

  /// Color used to paint generated skeleton shapes.
  final Color baseColor;

  /// Color used to paint child content skeleton shapes.
  final Color childBaseColor;

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

  /// Whether parent surfaces and child content use separate skeleton colors.
  final bool layeredSkeleton;

  /// Whether individual skeleton elements animate independently.
  final bool perElementShimmer;

  /// Opacity used for the moving shimmer highlight.
  final double highlightOpacity;

  /// Relative width used for the moving shimmer highlight.
  final double highlightWidth;

  /// Color used for parent surfaces such as cards and containers.
  Color get surfaceColor => baseColor;

  /// Color used for child content such as text, images and icons.
  Color get contentColor => layeredSkeleton ? childBaseColor : baseColor;

  /// Returns a copy of this config with the provided values replaced.
  AutoShimmerConfig copyWith({
    Color? baseColor,
    Color? childBaseColor,
    Color? highlightColor,
    Duration? duration,
    Duration? repeatDelay,
    Duration? interval,
    BorderRadius? borderRadius,
    AutoShimmerDirection? direction,
    bool? enabled,
    bool? layeredSkeleton,
    bool? perElementShimmer,
    double? highlightOpacity,
    double? highlightWidth,
  }) {
    return AutoShimmerConfig(
      baseColor: baseColor ?? this.baseColor,
      childBaseColor: childBaseColor ?? this.childBaseColor,
      highlightColor: highlightColor ?? this.highlightColor,
      duration: duration ?? this.duration,
      repeatDelay: repeatDelay ?? _repeatDelay,
      // ignore: deprecated_member_use_from_same_package
      interval: interval ?? this.interval,
      borderRadius: borderRadius ?? this.borderRadius,
      direction: direction ?? this.direction,
      enabled: enabled ?? this.enabled,
      layeredSkeleton: layeredSkeleton ?? this.layeredSkeleton,
      perElementShimmer: perElementShimmer ?? this.perElementShimmer,
      highlightOpacity: highlightOpacity ?? this.highlightOpacity,
      highlightWidth: highlightWidth ?? this.highlightWidth,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AutoShimmerConfig &&
            other.baseColor == baseColor &&
            other.childBaseColor == childBaseColor &&
            other.highlightColor == highlightColor &&
            other.duration == duration &&
            other.effectiveRepeatDelay == effectiveRepeatDelay &&
            other.borderRadius == borderRadius &&
            other.direction == direction &&
            other.enabled == enabled &&
            other.layeredSkeleton == layeredSkeleton &&
            other.perElementShimmer == perElementShimmer &&
            other.highlightOpacity == highlightOpacity &&
            other.highlightWidth == highlightWidth;
  }

  @override
  int get hashCode {
    return Object.hash(
      baseColor,
      childBaseColor,
      highlightColor,
      duration,
      effectiveRepeatDelay,
      borderRadius,
      direction,
      enabled,
      layeredSkeleton,
      perElementShimmer,
      highlightOpacity,
      highlightWidth,
    );
  }
}
