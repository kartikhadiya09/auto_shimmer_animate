import 'package:flutter/widgets.dart';

import '../config/auto_shimmer_config.dart';
import '../models/shimmer_node.dart';
import '../services/widget_parser_service.dart';

/// Builds a skeleton tree from an existing widget subtree.
class SkeletonBuilder extends StatelessWidget {
  /// Creates a skeleton builder.
  const SkeletonBuilder({
    super.key,
    required this.config,
    required this.child,
    required this.ignoreContainers,
    required this.ignoreImages,
    required this.ignoreTexts,
    this.parser = const WidgetParserService(),
  });

  /// Active shimmer configuration.
  final AutoShimmerConfig config;

  /// Widget subtree to skeletonize.
  final Widget child;

  /// Whether visual container widgets should be left unchanged.
  final bool ignoreContainers;

  /// Whether image widgets should be left unchanged.
  final bool ignoreImages;

  /// Whether text widgets should be left unchanged.
  final bool ignoreTexts;

  /// Parser used to route widgets to transformers.
  final WidgetParserService parser;

  @override
  Widget build(BuildContext context) {
    late final SkeletonTransformContext transformContext;

    transformContext = SkeletonTransformContext(
      config: config,
      ignoreContainers: ignoreContainers,
      ignoreImages: ignoreImages,
      ignoreTexts: ignoreTexts,
      transformChild: (context, child) {
        return parser.parse(context, child, transformContext);
      },
    );

    return parser.parse(context, child, transformContext);
  }
}
