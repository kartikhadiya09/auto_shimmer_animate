import 'package:flutter/material.dart';

import '../builders/widget_transformer.dart';
import '../core/enums/shimmer_node_kind.dart';
import '../core/extensions/widget_transform_extensions.dart';
import '../models/shimmer_node.dart';

/// Adapts `Card` widgets while preserving Material layout semantics.
class CardAdapter implements WidgetTransformer {
  /// Creates a card adapter.
  const CardAdapter();

  @override
  ShimmerNodeKind get nodeKind => ShimmerNodeKind.adapter;

  @override
  bool canTransform(Widget widget) => widget is Card;

  @override
  Widget transform(BuildContext context, ShimmerNode node) {
    final card = node.widget as Card;
    final transformContext = node.context;
    final child = card.child?.toAutoSkeleton(
      context,
      transformContext.nextDepth(),
    );

    if (transformContext.ignoreContainers) {
      return Card(
        margin: card.margin,
        clipBehavior: card.clipBehavior ?? Clip.antiAlias,
        child: child,
      );
    }

    final shape = card.shape ??
        RoundedRectangleBorder(
          borderRadius: transformContext.config.borderRadius,
        );

    return Card(
      color: transformContext.surfaceColor,
      margin: card.margin,
      elevation: 0,
      shape: shape,
      clipBehavior: card.clipBehavior ?? Clip.antiAlias,
      child: child,
    );
  }
}
