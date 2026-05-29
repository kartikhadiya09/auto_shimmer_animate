import 'package:flutter/widgets.dart';

import '../builders/widget_transformer.dart';
import '../core/enums/shimmer_node_kind.dart';
import '../core/utils/tinted_skeleton_fallback.dart';
import '../models/shimmer_node.dart';

/// Last-resort adapter for unsupported custom widgets.
class CommonWidgetAdapter implements WidgetTransformer {
  /// Creates a common widget adapter.
  const CommonWidgetAdapter();

  @override
  ShimmerNodeKind get nodeKind => ShimmerNodeKind.fallback;

  @override
  bool canTransform(Widget widget) => true;

  @override
  Widget transform(BuildContext context, ShimmerNode node) {
    return TintedSkeletonFallback(
      config: node.context.config,
      color: node.context.contentColor,
      child: node.widget,
    );
  }
}
