import 'package:flutter/widgets.dart';

import '../adapters/card_adapter.dart';
import '../adapters/common_widget_adapter.dart';
import '../adapters/list_tile_adapter.dart';
import '../adapters/stateless_widget_adapter.dart';
import '../adapters/switch_list_tile_adapter.dart';
import '../builders/widget_transformer.dart';
import '../models/shimmer_node.dart';
import '../transformers/container_transformer.dart';
import '../transformers/icon_transformer.dart';
import '../transformers/image_transformer.dart';
import '../transformers/layout_transformer.dart';
import '../transformers/text_transformer.dart';

/// Routes widgets to the first transformer that supports them.
class WidgetParserService {
  /// Creates a parser with an optional custom transformer list.
  const WidgetParserService({List<WidgetTransformer>? transformers})
      : _transformers = transformers ?? _defaultTransformers;

  static const _defaultTransformers = <WidgetTransformer>[
    TextTransformer(),
    ImageTransformer(),
    IconTransformer(),
    SwitchListTileAdapter(),
    ListTileAdapter(),
    CardAdapter(),
    ContainerTransformer(),
    LayoutTransformer(),
    StatelessWidgetAdapter(),
    CommonWidgetAdapter(),
  ];

  final List<WidgetTransformer> _transformers;

  /// Parses [widget] into a skeleton using [transformContext].
  Widget parse(
    BuildContext context,
    Widget widget,
    SkeletonTransformContext transformContext,
  ) {
    final transformer = _transformers.firstWhere(
      (candidate) => candidate.canTransform(widget),
    );

    return transformer.transform(
      context,
      ShimmerNode(
        widget: widget,
        kind: transformer.nodeKind,
        context: transformContext,
      ),
    );
  }
}
