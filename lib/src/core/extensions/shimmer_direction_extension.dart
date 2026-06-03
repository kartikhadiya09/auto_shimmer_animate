import 'package:flutter/widgets.dart';

import '../enums/auto_shimmer_direction.dart';

/// Converts package directions to gradient alignments.
extension AutoShimmerDirectionAdapter on AutoShimmerDirection {
  /// Gradient start alignment for this direction.
  AlignmentGeometry get beginAlignment {
    return switch (this) {
      AutoShimmerDirection.leftTopToRightBottom => Alignment.topLeft,
      AutoShimmerDirection.leftToRight => AlignmentDirectional.centerStart,
      AutoShimmerDirection.rightToLeft => AlignmentDirectional.centerEnd,
      AutoShimmerDirection.topToBottom => Alignment.topCenter,
      AutoShimmerDirection.bottomToTop => Alignment.bottomCenter,
    };
  }

  /// Gradient end alignment for this direction.
  AlignmentGeometry get endAlignment {
    return switch (this) {
      AutoShimmerDirection.leftTopToRightBottom => Alignment.centerRight,
      AutoShimmerDirection.leftToRight => AlignmentDirectional.centerEnd,
      AutoShimmerDirection.rightToLeft => AlignmentDirectional.centerStart,
      AutoShimmerDirection.topToBottom => Alignment.bottomCenter,
      AutoShimmerDirection.bottomToTop => Alignment.topCenter,
    };
  }
}
