import 'package:flutter/material.dart';

import '../../config/auto_shimmer_config.dart';

/// Graceful fallback for unsupported or intentionally ignored widgets.
class TintedSkeletonFallback extends StatelessWidget {
  /// Creates a tinted fallback skeleton.
  const TintedSkeletonFallback({
    super.key,
    required this.config,
    required this.child,
    this.color,
  });

  /// Active shimmer configuration.
  final AutoShimmerConfig config;

  /// Original widget to preserve layout.
  final Widget child;

  /// Tint color override.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        color ?? config.contentColor,
        BlendMode.srcATop,
      ),
      child: child,
    );
  }
}
