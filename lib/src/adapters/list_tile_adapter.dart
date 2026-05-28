import 'package:flutter/material.dart';

import '../builders/widget_transformer.dart';
import '../core/enums/shimmer_node_kind.dart';
import '../core/extensions/widget_transform_extensions.dart';
import '../models/shimmer_node.dart';
import '../transformers/icon_transformer.dart';
import '../transformers/text_transformer.dart';

/// Adapts `ListTile` into a stable Material skeleton.
class ListTileAdapter implements WidgetTransformer {
  /// Creates a list tile adapter.
  const ListTileAdapter();

  @override
  ShimmerNodeKind get nodeKind => ShimmerNodeKind.adapter;

  @override
  bool canTransform(Widget widget) => widget is ListTile;

  @override
  Widget transform(BuildContext context, ShimmerNode node) {
    final tile = node.widget as ListTile;
    final transformContext = node.context;

    return ListTile(
      dense: tile.dense,
      visualDensity: tile.visualDensity,
      contentPadding: tile.contentPadding,
      enabled: false,
      leading: _leading(context, tile, transformContext),
      title: _title(context, tile, transformContext),
      subtitle: _optional(context, tile.subtitle, transformContext),
      trailing: _optional(context, tile.trailing, transformContext),
    );
  }

  Widget _leading(
    BuildContext context,
    ListTile tile,
    SkeletonTransformContext transformContext,
  ) {
    return tile.leading?.toAutoSkeleton(context, transformContext) ??
        IconSkeleton(context: transformContext, size: 40);
  }

  Widget _title(
    BuildContext context,
    ListTile tile,
    SkeletonTransformContext transformContext,
  ) {
    return tile.title?.toAutoSkeleton(context, transformContext) ??
        TextSkeleton(text: 'List tile title', context: transformContext);
  }

  Widget? _optional(
    BuildContext context,
    Widget? child,
    SkeletonTransformContext transformContext,
  ) {
    return child?.toAutoSkeleton(context, transformContext);
  }
}
