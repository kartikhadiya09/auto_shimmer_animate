import 'package:flutter/material.dart';

import '../../animation/auto_shimmer_effect.dart';
import '../../animation/auto_shimmer_scope.dart';
import '../../config/auto_shimmer_config.dart';

/// Reusable generated skeleton shape.
class SkeletonBox extends StatelessWidget {
  /// Creates a skeleton box.
  const SkeletonBox({
    super.key,
    required this.config,
    this.color,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
  });

  /// Active shimmer configuration.
  final AutoShimmerConfig config;

  /// Color used to paint this skeleton shape.
  final Color? color;

  /// Radius for rectangular skeletons.
  final BorderRadiusGeometry? borderRadius;

  /// Shape of the generated skeleton.
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    final scopedConfig = AutoShimmerScope.configOf(context);
    final effectiveConfig = scopedConfig ?? config;
    final resolvedColor = color ?? effectiveConfig.contentColor;
    final radius = shape == BoxShape.circle
        ? null
        : borderRadius ?? effectiveConfig.borderRadius;
    final decoration = BoxDecoration(
      color: resolvedColor,
      borderRadius: radius,
      shape: shape,
    );
    Widget box = DecoratedBox(decoration: decoration);

    if (effectiveConfig.layeredSkeleton && effectiveConfig.perElementShimmer) {
      box = AutoShimmerEffect(
        baseColor: resolvedColor,
        highlightColor: effectiveConfig.highlightColor,
        duration: effectiveConfig.duration,
        repeatDelay: effectiveConfig.effectiveRepeatDelay,
        direction: effectiveConfig.direction,
        enabled: effectiveConfig.enabled,
        borderRadius: radius is BorderRadius ? radius : null,
        animation: AutoShimmerScope.animationOf(context),
        highlightOpacity: effectiveConfig.highlightOpacity,
        highlightWidth: effectiveConfig.highlightWidth,
        child: box,
      );
    }

    if (shape == BoxShape.circle) {
      return ClipOval(child: box);
    }

    if (radius == null) {
      return box;
    }

    return ClipRRect(
      borderRadius: radius,
      child: box,
    );
  }
}
