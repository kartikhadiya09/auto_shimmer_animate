import 'package:flutter/material.dart';

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
    final decoration = BoxDecoration(
      color: color ?? config.contentColor,
      borderRadius:
          shape == BoxShape.circle ? null : borderRadius ?? config.borderRadius,
      shape: shape,
    );
    final box = DecoratedBox(
      decoration: decoration,
    );

    if (shape == BoxShape.circle) {
      return ClipOval(child: box);
    }

    final radius = decoration.borderRadius;
    if (radius == null) {
      return box;
    }

    return ClipRRect(
      borderRadius: radius,
      child: box,
    );
  }
}
