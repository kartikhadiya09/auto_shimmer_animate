import 'package:flutter/widgets.dart';

import '../../models/shimmer_node.dart';

/// Internal helpers for recursively transforming child widgets.
extension AutoShimmerWidgetTransform on Widget {
  /// Converts this widget using the active skeleton transformation context.
  Widget toAutoSkeleton(
    BuildContext context,
    SkeletonTransformContext transformContext,
  ) {
    return transformContext.transformChild(context, this);
  }
}
