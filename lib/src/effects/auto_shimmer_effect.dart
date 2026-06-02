import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Describes how the animated shimmer overlay should be painted.
abstract class AutoShimmerEffect {
  /// Creates an effect with animation bounds and timing.
  const AutoShimmerEffect({
    required this.duration,
    this.lowerBound = -0.5,
    this.upperBound = 1.5,
    this.reverse = false,
  });

  /// The starting value used by the internal animation controller.
  final double lowerBound;

  /// The ending value used by the internal animation controller.
  final double upperBound;

  /// Whether the animation should ping-pong instead of restarting.
  final bool reverse;

  /// Time taken by one animation pass.
  final Duration duration;

  /// Builds the shader used by the shimmer overlay at animation value [value].
  Shader createShader(
    double value,
    Rect rect,
    TextDirection? textDirection,
  );

  /// Linearly interpolates this effect toward [other].
  AutoShimmerEffect lerp(AutoShimmerEffect? other, double t);
}

/// A directional linear shimmer overlay.
class AutoShimmerSweepEffect extends AutoShimmerEffect {
  /// Creates a directional shimmer effect.
  const AutoShimmerSweepEffect({
    this.baseColor = const Color(0xFFEBEBF4),
    this.highlightColor = const Color(0xFFF4F4F4),
    this.highlightOpacity = 1.0,
    this.highlightWidth = 0.1,
    this.stops = const [0.1, 0.3, 0.4],
    this.begin = const AlignmentDirectional(-1.0, -0.3),
    this.end = const AlignmentDirectional(1.0, 0.3),
    this.tileMode = TileMode.clamp,
    super.duration = const Duration(milliseconds: 2000),
    super.lowerBound = -0.5,
    super.upperBound = 1.5,
  });

  /// Color painted before and after the moving highlight.
  final Color baseColor;

  /// Color of the moving highlight.
  final Color highlightColor;

  /// Opacity of the moving highlight.
  final double highlightOpacity;

  /// Relative width of the highlight band.
  final double highlightWidth;

  /// Gradient stops.
  final List<double>? stops;

  /// Gradient start alignment.
  final AlignmentGeometry begin;

  /// Gradient end alignment.
  final AlignmentGeometry end;

  /// Gradient tiling mode.
  final TileMode tileMode;

  @override
  Shader createShader(
    double value,
    Rect rect,
    TextDirection? textDirection,
  ) {
    final resolvedStops = stops ?? _stopsFromWidth();

    return LinearGradient(
      colors: [
        baseColor,
        highlightColor.withValues(alpha: highlightOpacity),
        baseColor,
      ],
      stops: resolvedStops,
      begin: begin,
      end: end,
      tileMode: tileMode,
      transform: _SlidingGradientTransform(
        offset: value,
        isVertical: _isVertical(textDirection),
      ),
    ).createShader(rect, textDirection: textDirection);
  }

  List<double> _stopsFromWidth() {
    final width = highlightWidth.clamp(0.02, 0.5);
    final center = 0.3;
    return [
      (center - width * 2).clamp(0.0, 1.0),
      center,
      (center + width).clamp(0.0, 1.0),
    ];
  }

  bool _isVertical(TextDirection? textDirection) {
    final direction = textDirection ?? TextDirection.ltr;
    final resolvedBegin = begin.resolve(direction);
    final resolvedEnd = end.resolve(direction);
    return resolvedBegin.x == 0 && resolvedEnd.x == 0;
  }

  @override
  AutoShimmerEffect lerp(AutoShimmerEffect? other, double t) {
    if (other is AutoShimmerSweepEffect) {
      return AutoShimmerSweepEffect(
        baseColor: Color.lerp(baseColor, other.baseColor, t)!,
        highlightColor: Color.lerp(highlightColor, other.highlightColor, t)!,
        highlightOpacity: lerpDouble(
          highlightOpacity,
          other.highlightOpacity,
          t,
        )!,
        highlightWidth: lerpDouble(highlightWidth, other.highlightWidth, t)!,
        stops: t < 0.5 ? stops : other.stops,
        begin: AlignmentGeometry.lerp(begin, other.begin, t)!,
        end: AlignmentGeometry.lerp(end, other.end, t)!,
        tileMode: t < 0.5 ? tileMode : other.tileMode,
        duration: t < 0.5 ? duration : other.duration,
        lowerBound: lerpDouble(lowerBound, other.lowerBound, t)!,
        upperBound: lerpDouble(upperBound, other.upperBound, t)!,
      );
    }
    return this;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AutoShimmerSweepEffect &&
            other.baseColor == baseColor &&
            other.highlightColor == highlightColor &&
            other.highlightOpacity == highlightOpacity &&
            other.highlightWidth == highlightWidth &&
            listEquals(other.stops, stops) &&
            other.begin == begin &&
            other.end == end &&
            other.tileMode == tileMode &&
            other.duration == duration &&
            other.lowerBound == lowerBound &&
            other.upperBound == upperBound;
  }

  @override
  int get hashCode {
    return Object.hash(
      highlightColor,
      baseColor,
      highlightOpacity,
      highlightWidth,
      Object.hashAll(stops ?? const []),
      begin,
      end,
      tileMode,
      duration,
      lowerBound,
      upperBound,
    );
  }
}

/// A low-level shimmer effect for custom gradient colors and stops.
class AutoShimmerRawEffect extends AutoShimmerEffect {
  /// Creates a raw directional gradient shimmer effect.
  const AutoShimmerRawEffect({
    required this.colors,
    this.stops,
    this.begin = const AlignmentDirectional(-1.0, -0.3),
    this.end = const AlignmentDirectional(1.0, 0.3),
    this.tileMode = TileMode.clamp,
    super.duration = const Duration(milliseconds: 2000),
    super.lowerBound = -0.5,
    super.upperBound = 1.5,
  });

  /// Gradient colors.
  final List<Color> colors;

  /// Gradient stops.
  final List<double>? stops;

  /// Gradient start alignment.
  final AlignmentGeometry begin;

  /// Gradient end alignment.
  final AlignmentGeometry end;

  /// Gradient tiling mode.
  final TileMode tileMode;

  @override
  Shader createShader(
    double value,
    Rect rect,
    TextDirection? textDirection,
  ) {
    return LinearGradient(
      colors: colors,
      stops: stops,
      begin: begin,
      end: end,
      tileMode: tileMode,
      transform: _SlidingGradientTransform(
        offset: value,
        isVertical: begin.resolve(textDirection ?? TextDirection.ltr).x == 0 &&
            end.resolve(textDirection ?? TextDirection.ltr).x == 0,
      ),
    ).createShader(rect, textDirection: textDirection);
  }

  @override
  AutoShimmerEffect lerp(AutoShimmerEffect? other, double t) {
    if (other is AutoShimmerRawEffect && other.colors.length == colors.length) {
      return AutoShimmerRawEffect(
        colors: List.generate(
          colors.length,
          (index) => Color.lerp(colors[index], other.colors[index], t)!,
        ),
        stops: t < 0.5 ? stops : other.stops,
        begin: AlignmentGeometry.lerp(begin, other.begin, t)!,
        end: AlignmentGeometry.lerp(end, other.end, t)!,
        tileMode: t < 0.5 ? tileMode : other.tileMode,
        duration: t < 0.5 ? duration : other.duration,
        lowerBound: lerpDouble(lowerBound, other.lowerBound, t)!,
        upperBound: lerpDouble(upperBound, other.upperBound, t)!,
      );
    }
    return this;
  }
}

/// A soft color pulse overlay for low-motion loading states.
class AutoShimmerPulseEffect extends AutoShimmerEffect {
  /// Creates a pulse effect.
  const AutoShimmerPulseEffect({
    this.from = const Color(0x00FFFFFF),
    this.to = const Color(0x66FFFFFF),
    super.duration = const Duration(milliseconds: 1200),
    super.lowerBound = 0,
    super.upperBound = 1,
  }) : super(reverse: true);

  /// Starting overlay color.
  final Color from;

  /// Ending overlay color.
  final Color to;

  @override
  Shader createShader(
    double value,
    Rect rect,
    TextDirection? textDirection,
  ) {
    final color = Color.lerp(from, to, value)!;
    return LinearGradient(colors: [color, color]).createShader(rect);
  }

  @override
  AutoShimmerEffect lerp(AutoShimmerEffect? other, double t) {
    if (other is AutoShimmerPulseEffect) {
      return AutoShimmerPulseEffect(
        from: Color.lerp(from, other.from, t)!,
        to: Color.lerp(to, other.to, t)!,
        duration: t < 0.5 ? duration : other.duration,
        lowerBound: lerpDouble(lowerBound, other.lowerBound, t)!,
        upperBound: lerpDouble(upperBound, other.upperBound, t)!,
      );
    }
    return this;
  }
}

/// A multi-band shimmer with a richer aurora-style sweep.
class AutoShimmerAuroraEffect extends AutoShimmerEffect {
  /// Creates an aurora shimmer effect.
  const AutoShimmerAuroraEffect({
    this.colors = const [
      Color(0x0000BCD4),
      Color(0x6600BCD4),
      Color(0x55FFFFFF),
      Color(0x669C27B0),
      Color(0x0000BCD4),
    ],
    this.stops = const [0.0, 0.24, 0.48, 0.68, 1.0],
    this.begin = const AlignmentDirectional(-1.2, -0.8),
    this.end = const AlignmentDirectional(1.2, 0.8),
    super.duration = const Duration(milliseconds: 2200),
    super.lowerBound = -0.6,
    super.upperBound = 1.6,
  });

  /// Gradient colors.
  final List<Color> colors;

  /// Gradient stops.
  final List<double> stops;

  /// Gradient start alignment.
  final AlignmentGeometry begin;

  /// Gradient end alignment.
  final AlignmentGeometry end;

  @override
  Shader createShader(
    double value,
    Rect rect,
    TextDirection? textDirection,
  ) {
    return LinearGradient(
      colors: colors,
      stops: stops,
      begin: begin,
      end: end,
      transform: _SlidingGradientTransform(offset: value, isVertical: false),
    ).createShader(rect, textDirection: textDirection);
  }

  @override
  AutoShimmerEffect lerp(AutoShimmerEffect? other, double t) {
    if (other is AutoShimmerAuroraEffect &&
        other.colors.length == colors.length) {
      return AutoShimmerAuroraEffect(
        colors: List.generate(
          colors.length,
          (index) => Color.lerp(colors[index], other.colors[index], t)!,
        ),
        stops: t < 0.5 ? stops : other.stops,
        begin: AlignmentGeometry.lerp(begin, other.begin, t)!,
        end: AlignmentGeometry.lerp(end, other.end, t)!,
        duration: t < 0.5 ? duration : other.duration,
        lowerBound: lerpDouble(lowerBound, other.lowerBound, t)!,
        upperBound: lerpDouble(upperBound, other.upperBound, t)!,
      );
    }
    return this;
  }
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({
    required this.offset,
    required this.isVertical,
  });

  final double offset;
  final bool isVertical;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    if (isVertical) {
      return Matrix4.translationValues(0, bounds.height * offset, 0);
    }
    final resolvedOffset =
        textDirection == TextDirection.rtl ? -offset : offset;
    return Matrix4.translationValues(bounds.width * resolvedOffset, 0, 0);
  }
}
