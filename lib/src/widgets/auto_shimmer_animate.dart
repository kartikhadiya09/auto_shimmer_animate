import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../builders/shimmer_builder.dart';
import '../builders/skeleton_builder.dart';
import '../core/typedefs/auto_shimmer_builder.dart';
import 'shimmer_wrapper.dart';

/// Automatically converts an existing widget tree into a shimmer skeleton while
/// [isLoading] is true.
class AutoShimmerAnimate extends StatelessWidget {
  /// Creates a widget that swaps between [child] and its shimmer skeleton.
  const AutoShimmerAnimate({
    super.key,
    required this.isLoading,
    required this.child,
    this.baseColor,
    this.highlightColor,
    this.duration,
    this.interval,
    this.borderRadius,
    this.direction,
    this.enabled,
    this.ignoreContainers = false,
    this.ignoreImages = false,
    this.ignoreTexts = false,
    this.shimmerBuilder,
  });

  /// Whether to show the shimmer skeleton instead of [child].
  final bool isLoading;

  /// The normal UI that should be skeletonized while loading.
  final Widget child;

  /// Overrides the skeleton shape color.
  final Color? baseColor;

  /// Overrides the shimmer highlight color.
  final Color? highlightColor;

  /// Overrides the shimmer sweep duration.
  final Duration? duration;

  /// Overrides the delay between shimmer sweeps.
  final Duration? interval;

  /// Overrides the default radius for generated skeleton boxes.
  final BorderRadius? borderRadius;

  /// Overrides the shimmer sweep direction.
  final ShimmerDirection? direction;

  /// Overrides whether the shimmer animation should run.
  final bool? enabled;

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
    if (!isLoading) {
      return child;
    }

    final config = ShimmerConfigBuilder(
      baseColor: baseColor,
      highlightColor: highlightColor,
      duration: duration,
      interval: interval,
      borderRadius: borderRadius,
      direction: direction,
      enabled: enabled,
    ).build(context);

    final skeleton = SkeletonBuilder(
      config: config,
      ignoreContainers: ignoreContainers,
      ignoreImages: ignoreImages,
      ignoreTexts: ignoreTexts,
      child: child,
    );

    final shimmer = shimmerBuilder?.call(context, skeleton, config) ??
        ShimmerWrapper(config: config, child: skeleton);

    return ExcludeSemantics(child: IgnorePointer(child: shimmer));
  }
}
