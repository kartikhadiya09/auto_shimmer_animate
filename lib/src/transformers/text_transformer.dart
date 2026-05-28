import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../builders/widget_transformer.dart';
import '../core/enums/shimmer_node_kind.dart';
import '../core/utils/skeleton_box.dart';
import '../core/utils/tinted_skeleton_fallback.dart';
import '../models/shimmer_node.dart';

/// Converts `Text` and `RichText` widgets into text-line skeletons.
class TextTransformer implements WidgetTransformer {
  /// Creates a text transformer.
  const TextTransformer();

  @override
  ShimmerNodeKind get nodeKind => ShimmerNodeKind.text;

  @override
  bool canTransform(Widget widget) {
    return widget is Text || widget is RichText;
  }

  @override
  Widget transform(BuildContext context, ShimmerNode node) {
    final widget = node.widget;
    final transformContext = node.context;

    if (transformContext.ignoreTexts) {
      return TintedSkeletonFallback(
        config: transformContext.config,
        child: widget,
      );
    }

    if (widget is Text) {
      return TextSkeleton(
        text: widget.data ?? widget.textSpan?.toPlainText(),
        style: widget.style,
        maxLines: widget.maxLines,
        context: transformContext,
      );
    }

    final richText = widget as RichText;
    return TextSkeleton(
      text: richText.text.toPlainText(),
      maxLines: richText.maxLines,
      context: transformContext,
    );
  }
}

/// Skeleton representation of one or more text lines.
class TextSkeleton extends StatelessWidget {
  /// Creates a text skeleton.
  const TextSkeleton({
    super.key,
    required this.context,
    this.text,
    this.style,
    this.maxLines,
  });

  /// Active transformation context.
  final SkeletonTransformContext context;

  /// Source text used to estimate placeholder width.
  final String? text;

  /// Source text style used to estimate height.
  final TextStyle? style;

  /// Source maximum line count.
  final int? maxLines;

  @override
  Widget build(BuildContext buildContext) {
    final effectiveStyle = DefaultTextStyle.of(buildContext).style.merge(style);
    final fontSize = effectiveStyle.fontSize ?? 14;
    final lineHeight = math.max(8.0, fontSize * (effectiveStyle.height ?? 1.2));
    final plainText = (text?.trim().isEmpty ?? true) ? 'Loading text' : text!;
    final lineCount = _resolveLineCount(plainText);
    final estimatedWidth = math.max(40.0, plainText.length * fontSize * 0.52);

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth =
            constraints.hasBoundedWidth ? constraints.maxWidth : 240.0;
        final width = math.min(maxWidth, estimatedWidth);

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildLines(width, lineCount, lineHeight),
        );
      },
    );
  }

  List<Widget> _buildLines(double width, int lineCount, double lineHeight) {
    return List.generate(lineCount, (index) {
      final isLast = index == lineCount - 1;
      final lineWidth = lineCount == 1 || !isLast ? width : width * 0.72;

      return Padding(
        padding: EdgeInsets.only(bottom: isLast ? 0 : lineHeight * 0.32),
        child: SizedBox(
          width: math.max(24.0, lineWidth),
          height: math.max(8.0, lineHeight * 0.68),
          child: SkeletonBox(
            config: context.config,
            borderRadius: BorderRadius.circular(lineHeight),
          ),
        ),
      );
    });
  }

  int _resolveLineCount(String plainText) {
    final requestedLines = plainText.split('\n').length;
    return math.max(1, math.min(maxLines ?? requestedLines, 3));
  }
}
