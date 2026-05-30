import 'package:flutter/material.dart';

import '../animation/auto_shimmer_scope.dart';
import '../builders/shimmer_builder.dart';
import '../builders/skeleton_builder.dart';
import '../core/enums/auto_shimmer_direction.dart';
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
    this.childBaseColor,
    this.highlightColor,
    this.duration,
    this.repeatDelay,
    this.interval,
    this.borderRadius,
    this.direction,
    this.enabled,
    this.layeredSkeleton,
    this.highlightOpacity,
    this.highlightWidth,
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

  /// Overrides the opacity of the moving shimmer highlight.
  final double? highlightOpacity;

  /// Overrides the relative width of the moving shimmer highlight.
  final double? highlightWidth;

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
      childBaseColor: childBaseColor,
      highlightColor: highlightColor,
      duration: duration,
      repeatDelay: repeatDelay,
      interval: interval,
      borderRadius: borderRadius,
      direction: direction,
      enabled: enabled,
      layeredSkeleton: layeredSkeleton,
      highlightOpacity: highlightOpacity,
      highlightWidth: highlightWidth,
    ).build(context);
    final skeletonConfig = shimmerBuilder == null
        ? config
        : config.copyWith(perElementShimmer: false);

    final skeleton = SkeletonBuilder(
      config: skeletonConfig,
      ignoreContainers: ignoreContainers,
      ignoreImages: ignoreImages,
      ignoreTexts: ignoreTexts,
      child: child,
    );

    final shimmer = shimmerBuilder?.call(context, skeleton, config) ??
        ShimmerWrapper(
          config: config,
          child: AutoShimmerScope(config: skeletonConfig, child: skeleton),
        );

    return ExcludeSemantics(child: IgnorePointer(child: shimmer));
  }
}
