import 'package:flutter/widgets.dart';

import '../builders/widget_transformer.dart';
import '../core/enums/shimmer_node_kind.dart';
import '../core/extensions/widget_transform_extensions.dart';
import '../core/utils/tinted_skeleton_fallback.dart';
import '../models/shimmer_node.dart';

/// Expands unsupported stateless widgets before falling back to tinting.
class StatelessWidgetAdapter implements WidgetTransformer {
  /// Creates a stateless widget adapter.
  const StatelessWidgetAdapter();

  @override
  ShimmerNodeKind get nodeKind => ShimmerNodeKind.adapter;

  @override
  bool canTransform(Widget widget) => widget is StatelessWidget;

  @override
  Widget transform(BuildContext context, ShimmerNode node) {
    final widget = node.widget as StatelessWidget;
    // ignore: invalid_use_of_protected_member
    final built = widget.build(context);

    if (identical(built, widget)) {
      return TintedSkeletonFallback(
        config: node.context.config,
        color: node.context.contentColor,
        child: widget,
      );
    }

    return built.toAutoSkeleton(context, node.context.nextDepth());
  }
}
