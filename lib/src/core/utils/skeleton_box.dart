import 'package:flutter/material.dart';

import '../../config/auto_shimmer_config.dart';

/// Reusable generated skeleton shape.
class SkeletonBox extends StatelessWidget {
  /// Creates a skeleton box.
  const SkeletonBox({
    super.key,
    required this.config,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
  });

  /// Active shimmer configuration.
  final AutoShimmerConfig config;

  /// Radius for rectangular skeletons.
  final BorderRadiusGeometry? borderRadius;

  /// Shape of the generated skeleton.
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: config.baseColor,
        borderRadius: shape == BoxShape.circle
            ? null
            : borderRadius ?? config.borderRadius,
        shape: shape,
      ),
    );
  }
}
