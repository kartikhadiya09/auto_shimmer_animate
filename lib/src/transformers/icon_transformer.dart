import 'package:flutter/material.dart';

import '../builders/widget_transformer.dart';
import '../core/enums/shimmer_node_kind.dart';
import '../core/utils/skeleton_box.dart';
import '../models/shimmer_node.dart';

/// Converts `Icon` widgets into circular skeletons.
class IconTransformer implements WidgetTransformer {
  /// Creates an icon transformer.
  const IconTransformer();

  @override
  ShimmerNodeKind get nodeKind => ShimmerNodeKind.icon;

  @override
  bool canTransform(Widget widget) => widget is Icon;

  @override
  Widget transform(BuildContext context, ShimmerNode node) {
    final icon = node.widget as Icon;
    return IconSkeleton(context: node.context, size: icon.size);
  }
}

/// Skeleton representation of an icon.
class IconSkeleton extends StatelessWidget {
  /// Creates an icon skeleton.
  const IconSkeleton({
    super.key,
    required this.context,
    this.size,
  });

  /// Active transformation context.
  final SkeletonTransformContext context;

  /// Source icon size.
  final double? size;

  @override
  Widget build(BuildContext context) {
    final resolvedSize = size ?? IconTheme.of(context).size ?? 24;

    return SizedBox.square(
      dimension: resolvedSize,
      child: SkeletonBox(
        config: this.context.config,
        color: this.context.contentColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
