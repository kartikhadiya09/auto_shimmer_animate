import 'package:flutter/material.dart';

import '../builders/widget_transformer.dart';
import '../core/enums/shimmer_node_kind.dart';
import '../core/extensions/widget_transform_extensions.dart';
import '../core/utils/skeleton_box.dart';
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

    final decoration = _needsSkeletonDecoration(container) &&
            child == null &&
            transformContext.paintsBlockSurfaces
        ? SkeletonDecoration.from(
            container.decoration,
            transformContext.config,
            color: transformContext.surfaceColor,
          )
        : null;
    final transformedChild = child == null
        ? null
        : _withOptionalSurface(
            decoration: container.decoration,
            transformContext: transformContext,
            child: _withContainerLayout(container, child),
          );

    return _clipToRadius(
      decoration: container.decoration,
      transformContext: transformContext,
      child: _copyContainer(
        container,
        decoration: decoration,
        child: transformedChild,
        preservePadding: child == null,
        preserveOriginalDecoration: child == null,
      ),
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

    final radius = SkeletonDecoration.radiusFrom(
      decoratedBox.decoration,
      transformContext.config,
    );

    return _clipToRadius(
      decoration: decoratedBox.decoration,
      transformContext: transformContext,
      child: _withOptionalSurface(
        decoration: decoratedBox.decoration,
        transformContext: transformContext,
        child: DecoratedBox(
          decoration: const BoxDecoration(),
          position: decoratedBox.position,
          child: child ?? const SizedBox.shrink(),
        ),
        borderRadius: radius,
      ),
    );
  }

  Widget _withOptionalSurface({
    required Decoration? decoration,
    required SkeletonTransformContext transformContext,
    required Widget child,
    BorderRadiusGeometry? borderRadius,
  }) {
    if (!transformContext.paintsBlockBehindChildren) {
      return child;
    }

    return _surfaceStack(
      decoration: decoration,
      transformContext: transformContext,
      child: child,
      borderRadius: borderRadius,
    );
  }

  Widget _surfaceStack({
    required Decoration? decoration,
    required SkeletonTransformContext transformContext,
    required Widget child,
    BorderRadiusGeometry? borderRadius,
  }) {
    final shape =
        decoration is BoxDecoration && decoration.shape == BoxShape.circle
            ? BoxShape.circle
            : BoxShape.rectangle;

    return Stack(
      fit: StackFit.passthrough,
      children: [
        Positioned.fill(
          child: SkeletonBox(
            config: transformContext.config,
            color: transformContext.surfaceColor,
            borderRadius: shape == BoxShape.circle
                ? null
                : borderRadius ??
                    SkeletonDecoration.radiusFrom(
                      decoration,
                      transformContext.config,
                    ),
            shape: shape,
          ),
        ),
        child,
      ],
    );
  }

  Widget _withContainerLayout(Container container, Widget child) {
    Widget result = child;

    if (container.padding != null) {
      result = Padding(padding: container.padding!, child: result);
    }

    if (container.alignment != null) {
      result = Align(alignment: container.alignment!, child: result);
    }

    return result;
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
    bool preservePadding = true,
    bool preserveOriginalDecoration = true,
  }) {
    final originalDecoration =
        preserveOriginalDecoration ? container.decoration : null;
    final originalColor = preserveOriginalDecoration ? container.color : null;

    return Container(
      alignment: preservePadding ? container.alignment : null,
      padding: preservePadding ? container.padding : null,
      color: decoration == null ? originalColor : null,
      decoration: decoration ?? originalDecoration,
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
