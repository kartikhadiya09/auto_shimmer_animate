import 'package:flutter/material.dart';

import '../builders/widget_transformer.dart';
import '../core/enums/shimmer_node_kind.dart';
import '../core/extensions/widget_transform_extensions.dart';
import '../core/utils/skeleton_decoration.dart';
import '../models/shimmer_node.dart';

/// Converts visual container widgets while preserving layout constraints.
class ContainerTransformer implements WidgetTransformer {
  /// Creates a container transformer.
  const ContainerTransformer();

  @override
  ShimmerNodeKind get nodeKind => ShimmerNodeKind.container;

  @override
  bool canTransform(Widget widget) {
    return widget is Container || widget is DecoratedBox;
  }

  @override
  Widget transform(BuildContext context, ShimmerNode node) {
    final widget = node.widget;

    if (widget is Container) {
      return _transformContainer(context, widget, node.context);
    }

    return _transformDecoratedBox(
        context, widget as DecoratedBox, node.context);
  }

  Widget _transformContainer(
    BuildContext context,
    Container container,
    SkeletonTransformContext transformContext,
  ) {
    final child = container.child?.toAutoSkeleton(
      context,
      transformContext.nextDepth(),
    );

    if (transformContext.ignoreContainers) {
      return _copyContainer(container, child: child);
    }

    final decoration = _needsSkeletonDecoration(container)
        ? SkeletonDecoration.from(
            container.decoration,
            transformContext.config,
            color: transformContext.surfaceColor,
          )
        : null;

    return _clipToRadius(
      decoration: container.decoration,
      transformContext: transformContext,
      child: _copyContainer(container, decoration: decoration, child: child),
    );
  }

  Widget _transformDecoratedBox(
    BuildContext context,
    DecoratedBox decoratedBox,
    SkeletonTransformContext transformContext,
  ) {
    final child = decoratedBox.child?.toAutoSkeleton(
      context,
      transformContext.nextDepth(),
    );

    if (transformContext.ignoreContainers) {
      return DecoratedBox(
        decoration: decoratedBox.decoration,
        position: decoratedBox.position,
        child: child,
      );
    }

    return _clipToRadius(
      decoration: decoratedBox.decoration,
      transformContext: transformContext,
      child: DecoratedBox(
        decoration: SkeletonDecoration.from(
          decoratedBox.decoration,
          transformContext.config,
          color: transformContext.surfaceColor,
        ),
        position: decoratedBox.position,
        child: child,
      ),
    );
  }

  Widget _clipToRadius({
    required Decoration? decoration,
    required SkeletonTransformContext transformContext,
    required Widget child,
  }) {
    final radius = SkeletonDecoration.radiusFrom(
      decoration,
      transformContext.config,
    );

    if (radius == null) {
      return child;
    }

    return ClipRRect(
      borderRadius: radius,
      child: child,
    );
  }

  bool _needsSkeletonDecoration(Container container) {
    return true;
  }

  Widget _copyContainer(
    Container container, {
    Decoration? decoration,
    Widget? child,
  }) {
    return Container(
      alignment: container.alignment,
      padding: container.padding,
      color: decoration == null ? container.color : null,
      decoration: decoration ?? container.decoration,
      foregroundDecoration:
          decoration == null ? container.foregroundDecoration : null,
      constraints: container.constraints,
      margin: container.margin,
      transform: container.transform,
      transformAlignment: container.transformAlignment,
      clipBehavior: decoration == null ? Clip.none : Clip.antiAlias,
      child: child,
    );
  }
}
