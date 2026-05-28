import 'package:flutter/widgets.dart';

import '../config/auto_shimmer_config.dart';
import '../core/enums/shimmer_node_kind.dart';

/// Recursion callback used by transformers to process child widgets.
typedef SkeletonChildTransformer = Widget Function(
    BuildContext context, Widget child);

/// Shared context passed to every transformer.
@immutable
class SkeletonTransformContext {
  /// Creates transformation context.
  const SkeletonTransformContext({
    required this.config,
    required this.ignoreContainers,
    required this.ignoreImages,
    required this.ignoreTexts,
    required this.transformChild,
  });

  /// Active shimmer configuration.
  final AutoShimmerConfig config;

  /// Whether visual container widgets should be left unchanged.
  final bool ignoreContainers;

  /// Whether image widgets should be left unchanged.
  final bool ignoreImages;

  /// Whether text widgets should be left unchanged.
  final bool ignoreTexts;

  /// Recursively transforms a child widget.
  final SkeletonChildTransformer transformChild;
}

/// Parsed widget node passed to a dedicated transformer.
@immutable
class ShimmerNode {
  /// Creates a shimmer node.
  const ShimmerNode({
    required this.widget,
    required this.kind,
    required this.context,
  });

  /// Widget being transformed.
  final Widget widget;

  /// Category matched by the parser service.
  final ShimmerNodeKind kind;

  /// Shared transformation context.
  final SkeletonTransformContext context;
}
