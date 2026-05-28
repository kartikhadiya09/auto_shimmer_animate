import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../config/auto_shimmer_config.dart';

/// Default adapter between generated skeletons and `shimmer_animation`.
class ShimmerWrapper extends StatelessWidget {
  /// Creates the default shimmer wrapper.
  const ShimmerWrapper({
    super.key,
    required this.config,
    required this.child,
  });

  /// Active shimmer configuration.
  final AutoShimmerConfig config;

  /// Generated skeleton child.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      color: config.highlightColor,
      colorOpacity: 0.45,
      duration: config.duration,
      interval: config.interval,
      direction: config.direction,
      enabled: config.enabled,
      child: child,
    );
  }
}
