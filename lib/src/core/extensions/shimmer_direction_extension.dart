import 'package:shimmer_animation/shimmer_animation.dart';

import '../enums/auto_shimmer_direction.dart';

/// Converts package directions to the direction type used by
/// `shimmer_animation`.
extension AutoShimmerDirectionAdapter on AutoShimmerDirection {
  /// Returns the matching `shimmer_animation` direction.
  ShimmerDirection toShimmerDirection() {
    return switch (this) {
      AutoShimmerDirection.leftTopToRightBottom =>
        const ShimmerDirection.fromLTRB(),
      AutoShimmerDirection.leftToRight =>
        const ShimmerDirection.fromLeftToRight(),
      AutoShimmerDirection.rightToLeft =>
        const ShimmerDirection.fromRightToLeft(),
      AutoShimmerDirection.topToBottom => const ShimmerDirection.fromLTRB(),
      AutoShimmerDirection.bottomToTop => const ShimmerDirection.fromLBRT(),
    };
  }
}
