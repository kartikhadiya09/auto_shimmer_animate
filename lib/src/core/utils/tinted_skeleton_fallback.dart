import 'package:flutter/material.dart';

import '../../config/auto_shimmer_config.dart';

/// Graceful fallback for unsupported or intentionally ignored widgets.
class TintedSkeletonFallback extends StatelessWidget {
  /// Creates a tinted fallback skeleton.
  const TintedSkeletonFallback({
    super.key,
    required this.config,
    required this.child,
  });

  /// Active shimmer configuration.
  final AutoShimmerConfig config;

  /// Original widget to preserve layout.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(config.baseColor, BlendMode.srcATop),
      child: child,
    );
  }
}
