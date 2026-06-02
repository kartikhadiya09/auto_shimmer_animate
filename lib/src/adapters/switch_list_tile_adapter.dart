import 'package:flutter/material.dart';

import '../builders/widget_transformer.dart';
import '../core/enums/shimmer_node_kind.dart';
import '../core/extensions/widget_transform_extensions.dart';
import '../core/utils/skeleton_box.dart';
import '../models/shimmer_node.dart';
import '../transformers/text_transformer.dart';

/// Adapts `SwitchListTile` into a stable skeleton tile.
class SwitchListTileAdapter implements WidgetTransformer {
  /// Creates a switch list tile adapter.
  const SwitchListTileAdapter();

  @override
  ShimmerNodeKind get nodeKind => ShimmerNodeKind.adapter;

  @override
  bool canTransform(Widget widget) => widget is SwitchListTile;

  @override
  Widget transform(BuildContext context, ShimmerNode node) {
    final tile = node.widget as SwitchListTile;
    final transformContext = node.context;

    return Material(
      color: Colors.transparent,
      child: SwitchListTile(
        value: false,
        onChanged: null,
        dense: tile.dense,
        visualDensity: tile.visualDensity,
        contentPadding: tile.contentPadding,
        controlAffinity: tile.controlAffinity,
        title: tile.title?.toAutoSkeleton(context, transformContext) ??
            TextSkeleton(text: 'Switch title', context: transformContext),
        subtitle: tile.subtitle?.toAutoSkeleton(context, transformContext),
        secondary: tile.secondary?.toAutoSkeleton(context, transformContext),
        selected: false,
        autofocus: false,
      ),
    );
  }
}

/// Compact switch control placeholder.
class SwitchControlSkeleton extends StatelessWidget {
  /// Creates a switch-shaped skeleton.
  const SwitchControlSkeleton({
    super.key,
    required this.context,
  });

  /// Active transformation context.
  final SkeletonTransformContext context;

  @override
  Widget build(BuildContext buildContext) {
    return SizedBox(
      width: 48,
      height: 28,
      child: SkeletonBox(
        config: context.config,
        color: context.contentColor,
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}
