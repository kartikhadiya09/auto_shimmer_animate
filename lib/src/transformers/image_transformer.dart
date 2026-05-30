import 'package:flutter/material.dart';

import '../builders/widget_transformer.dart';
import '../core/enums/shimmer_node_kind.dart';
import '../core/utils/skeleton_box.dart';
import '../core/utils/tinted_skeleton_fallback.dart';
import '../models/shimmer_node.dart';

/// Converts `Image` widgets into rectangular skeletons.
class ImageTransformer implements WidgetTransformer {
  /// Creates an image transformer.
  const ImageTransformer();

  @override
  ShimmerNodeKind get nodeKind => ShimmerNodeKind.image;

  @override
  bool canTransform(Widget widget) => widget is Image;

  @override
  Widget transform(BuildContext context, ShimmerNode node) {
    final image = node.widget as Image;
    final transformContext = node.context;

    if (transformContext.ignoreImages) {
      return TintedSkeletonFallback(
        config: transformContext.config,
        color: transformContext.contentColor,
        child: image,
      );
    }

    return ImageSkeleton(
      context: transformContext,
      width: image.width,
      height: image.height,
    );
  }
}

/// Skeleton representation of an image.
class ImageSkeleton extends StatelessWidget {
  /// Creates an image skeleton.
  const ImageSkeleton({
    super.key,
    required this.context,
    this.width,
    this.height,
  });

  /// Active transformation context.
  final SkeletonTransformContext context;

  /// Source image width.
  final double? width;

  /// Source image height.
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: width ?? 48,
        minHeight: height ?? 48,
      ),
      child: SizedBox(
        width: width,
        height: height,
        child: SkeletonBox(
          config: this.context.config,
          color: this.context.contentColor,
        ),
      ),
    );
  }
}
