import 'package:flutter/material.dart';

import '../animation/auto_shimmer_effect.dart';
import '../config/auto_shimmer_config.dart';

/// Default adapter between generated skeletons and the built-in shimmer engine.
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
    if (config.layeredSkeleton && config.perElementShimmer) {
      return child;
    }

    return AutoShimmerEffect(
      baseColor: config.baseColor,
      highlightColor: config.highlightColor,
      duration: config.duration,
      repeatDelay: config.effectiveRepeatDelay,
      direction: config.direction,
      enabled: config.enabled,
      borderRadius: config.borderRadius,
      highlightOpacity: config.highlightOpacity,
      highlightWidth: config.highlightWidth,
      child: child,
    );
  }
}
