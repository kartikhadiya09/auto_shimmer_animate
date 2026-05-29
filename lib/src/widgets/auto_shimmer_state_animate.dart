import 'package:flutter/material.dart';

import '../core/enums/auto_shimmer_direction.dart';
import '../core/typedefs/auto_shimmer_builder.dart';
import 'auto_shimmer_animate.dart';

/// State-driven variant of [AutoShimmerAnimate].
///
/// [T] can be an enum, string, object, or any other type with meaningful
/// equality. The skeleton is shown when [state] is contained in
/// [loadingStates].
class AutoShimmerStateAnimate<T> extends StatelessWidget {
  /// Creates a shimmer wrapper controlled by an arbitrary state value.
  const AutoShimmerStateAnimate({
    super.key,
    required this.state,
    required this.loadingStates,
    required this.child,
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
    this.ignoreContainers = false,
    this.ignoreImages = false,
    this.ignoreTexts = false,
    this.shimmerBuilder,
  });

  /// Current view or controller state.
  final T state;

  /// States that should render [child] as a loading skeleton.
  final Iterable<T> loadingStates;

  /// The normal UI that should be skeletonized while loading.
  final Widget child;

  /// Overrides the skeleton shape color.
  final Color? baseColor;

  /// Overrides the child content skeleton color.
  final Color? childBaseColor;

  /// Overrides the shimmer highlight color.
  final Color? highlightColor;

  /// Overrides the shimmer sweep duration.
  final Duration? duration;

  /// Overrides the delay between repeated shimmer sweeps.
  final Duration? repeatDelay;

  /// Overrides the delay between shimmer sweeps.
  @Deprecated('Use repeatDelay instead.')
  final Duration? interval;

  /// Overrides the default radius for generated skeleton boxes.
  final BorderRadius? borderRadius;

  /// Overrides the shimmer sweep direction.
  final AutoShimmerDirection? direction;

  /// Overrides whether the shimmer animation should run.
  final bool? enabled;

  /// Overrides whether parent and child skeleton layers use separate colors.
  final bool? layeredSkeleton;

  /// Leaves `Container`, `DecoratedBox`, and `Card` visuals unchanged.
  final bool ignoreContainers;

  /// Leaves `Image` widgets visible instead of replacing them with boxes.
  final bool ignoreImages;

  /// Leaves `Text` and `RichText` widgets visible instead of replacing them
  /// with bars.
  final bool ignoreTexts;

  /// Optional custom builder for applying shimmer to the generated skeleton.
  final AutoShimmerBuilder? shimmerBuilder;

  @override
  Widget build(BuildContext context) {
    return AutoShimmerAnimate(
      isLoading: loadingStates.contains(state),
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
      ignoreContainers: ignoreContainers,
      ignoreImages: ignoreImages,
      ignoreTexts: ignoreTexts,
      shimmerBuilder: shimmerBuilder,
      child: child,
    );
  }
}
