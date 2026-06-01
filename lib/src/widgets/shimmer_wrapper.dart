import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../config/auto_shimmer_config.dart';
import '../core/extensions/shimmer_direction_extension.dart';

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
    if (!config.hasShimmerAnimationOverrides) {
      return Shimmer(
        color: config.highlightColor,
        colorOpacity: config.highlightOpacity,
        child: child,
      );
    }

    return Shimmer(
      color: config.highlightColor,
      colorOpacity: config.highlightOpacity,
      duration: config.duration,
      interval: config.effectiveRepeatDelay,
      direction: config.direction.toShimmerDirection(),
      enabled: config.enabled,
      child: child,
    );
  }
}

