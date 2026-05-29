import 'package:flutter/material.dart';

import '../builders/widget_transformer.dart';
import '../core/enums/shimmer_node_kind.dart';
import '../core/extensions/widget_transform_extensions.dart';
import '../core/utils/skeleton_box.dart';
import '../models/shimmer_node.dart';

/// Preserves layout widgets while recursively transforming their children.
class LayoutTransformer implements WidgetTransformer {
  /// Creates a layout transformer.
  const LayoutTransformer();

  @override
  ShimmerNodeKind get nodeKind => ShimmerNodeKind.layout;

  @override
  bool canTransform(Widget widget) {
    return widget is SizedBox ||
        widget is Padding ||
        widget is Center ||
        widget is Align ||
        widget is Expanded ||
        widget is Flexible ||
        widget is Spacer ||
        widget is ConstrainedBox ||
        widget is AspectRatio ||
        widget is ClipRRect ||
        widget is ClipOval ||
        widget is Row ||
        widget is Column ||
        widget is Stack ||
        widget is Wrap;
  }

  @override
  Widget transform(BuildContext context, ShimmerNode node) {
    final widget = node.widget;
    final transformContext = node.context;

    if (widget is SizedBox) {
      return _sizedBox(context, widget, transformContext);
    }
    if (widget is Padding) {
      return Padding(
        padding: widget.padding,
        child: _child(context, widget.child, transformContext),
      );
    }
    if (widget is Center) {
      return Center(
        widthFactor: widget.widthFactor,
        heightFactor: widget.heightFactor,
        child: _child(context, widget.child, transformContext),
      );
    }
    if (widget is Align) {
      return Align(
        alignment: widget.alignment,
        widthFactor: widget.widthFactor,
        heightFactor: widget.heightFactor,
        child: _child(context, widget.child, transformContext),
      );
    }
    if (widget is Expanded) {
      return Expanded(
        flex: widget.flex,
        child: widget.child.toAutoSkeleton(context, transformContext),
      );
    }
    if (widget is Flexible) {
      return Flexible(
        flex: widget.flex,
        fit: widget.fit,
        child: widget.child.toAutoSkeleton(context, transformContext),
      );
    }
    if (widget is Spacer) {
      return Spacer(flex: widget.flex);
    }
    if (widget is ConstrainedBox) {
      return ConstrainedBox(
        constraints: widget.constraints,
        child: _requiredChild(context, widget.child, transformContext),
      );
    }
    if (widget is AspectRatio) {
      return AspectRatio(
        aspectRatio: widget.aspectRatio,
        child: _requiredChild(context, widget.child, transformContext),
      );
    }
    if (widget is ClipRRect) {
      return ClipRRect(
        borderRadius: widget.borderRadius,
        clipBehavior: widget.clipBehavior,
        child: _child(context, widget.child, transformContext),
      );
    }
    if (widget is ClipOval) {
      return ClipOval(
        clipBehavior: widget.clipBehavior,
        child: _child(context, widget.child, transformContext),
      );
    }

    return _multiChild(context, widget, transformContext);
  }

  Widget _sizedBox(
    BuildContext context,
    SizedBox widget,
    SkeletonTransformContext transformContext,
  ) {
    if (widget.child != null) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: widget.child!.toAutoSkeleton(context, transformContext),
      );
    }

    if ((widget.width ?? 0) > 0 && (widget.height ?? 0) > 0) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: SkeletonBox(
          config: transformContext.config,
          color: transformContext.contentColor,
        ),
      );
    }

    return SizedBox(width: widget.width, height: widget.height);
  }

  Widget _multiChild(
    BuildContext context,
    Widget widget,
    SkeletonTransformContext transformContext,
  ) {
    if (widget is Row) {
      return Row(
        mainAxisAlignment: widget.mainAxisAlignment,
        mainAxisSize: widget.mainAxisSize,
        crossAxisAlignment: widget.crossAxisAlignment,
        textDirection: widget.textDirection,
        verticalDirection: widget.verticalDirection,
        textBaseline: widget.textBaseline,
        children: _children(context, widget.children, transformContext),
      );
    }

    if (widget is Column) {
      return Column(
        mainAxisAlignment: widget.mainAxisAlignment,
        mainAxisSize: widget.mainAxisSize,
        crossAxisAlignment: widget.crossAxisAlignment,
        textDirection: widget.textDirection,
        verticalDirection: widget.verticalDirection,
        textBaseline: widget.textBaseline,
        children: _children(context, widget.children, transformContext),
      );
    }

    if (widget is Stack) {
      return Stack(
        alignment: widget.alignment,
        textDirection: widget.textDirection,
        fit: widget.fit,
        clipBehavior: widget.clipBehavior,
        children: _children(context, widget.children, transformContext),
      );
    }

    final wrap = widget as Wrap;
    return Wrap(
      direction: wrap.direction,
      alignment: wrap.alignment,
      spacing: wrap.spacing,
      runAlignment: wrap.runAlignment,
      runSpacing: wrap.runSpacing,
      crossAxisAlignment: wrap.crossAxisAlignment,
      textDirection: wrap.textDirection,
      verticalDirection: wrap.verticalDirection,
      clipBehavior: wrap.clipBehavior,
      children: _children(context, wrap.children, transformContext),
    );
  }

  List<Widget> _children(
    BuildContext context,
    List<Widget> children,
    SkeletonTransformContext transformContext,
  ) {
    return children
        .map((child) => child.toAutoSkeleton(context, transformContext))
        .toList(growable: false);
  }

  Widget? _child(
    BuildContext context,
    Widget? child,
    SkeletonTransformContext transformContext,
  ) {
    return child?.toAutoSkeleton(context, transformContext);
  }

  Widget _requiredChild(
    BuildContext context,
    Widget? child,
    SkeletonTransformContext transformContext,
  ) {
    return _child(context, child, transformContext) ?? const SizedBox.shrink();
  }
}
