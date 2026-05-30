import 'dart:async';

import 'package:flutter/material.dart';

import 'auto_shimmer_gradient.dart';
import 'auto_shimmer_scope.dart';
import '../core/constants/auto_shimmer_defaults.dart';
import '../core/enums/auto_shimmer_direction.dart';

/// Built-in shimmer animation used by generated skeletons.
class AutoShimmerEffect extends StatefulWidget {
  /// Creates a shimmer effect around [child].
  const AutoShimmerEffect({
    super.key,
    required this.child,
    required this.baseColor,
    required this.highlightColor,
    required this.duration,
    required this.repeatDelay,
    required this.direction,
    this.enabled = true,
    this.borderRadius,
    this.shape,
    this.animation,
    this.highlightOpacity = AutoShimmerDefaults.highlightOpacity,
    this.highlightWidth = AutoShimmerDefaults.highlightWidth,
  });

  /// Skeleton content to animate.
  final Widget child;

  /// Base skeleton color.
  final Color baseColor;

  /// Animated highlight color.
  final Color highlightColor;

  /// Time taken by one shimmer pass.
  final Duration duration;

  /// Delay between shimmer passes.
  final Duration repeatDelay;

  /// Direction of the shimmer pass.
  final AutoShimmerDirection direction;

  /// Whether the shimmer animation should run.
  final bool enabled;

  /// Optional radius used to clip the shimmer layer.
  final BorderRadius? borderRadius;

  /// Optional shape used by the shimmer layer.
  final ShapeBorder? shape;

  /// Optional shared shimmer animation.
  final Animation<double>? animation;

  /// Opacity used for the moving shimmer highlight.
  final double highlightOpacity;

  /// Relative width used for the moving shimmer highlight.
  final double highlightWidth;

  @override
  State<AutoShimmerEffect> createState() => _AutoShimmerEffectState();
}

class _AutoShimmerEffectState extends State<AutoShimmerEffect>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  bool _isLooping = false;
  int _loopToken = 0;

  @override
  void initState() {
    super.initState();
    _configureFallbackController();
    _startLoopIfNeeded();
  }

  @override
  void didUpdateWidget(covariant AutoShimmerEffect oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.animation != widget.animation) {
      _configureFallbackController();
    }

    if (_controller != null && oldWidget.duration != widget.duration) {
      _controller!.duration = widget.duration;
    }

    if (!widget.enabled) {
      _loopToken++;
      _isLooping = false;
      _controller?.stop(canceled: true);
      _controller?.value = 0;
      return;
    }

    _startLoopIfNeeded();
  }

  Animation<double> get _activeAnimation {
    return widget.animation ?? _controller!;
  }

  void _configureFallbackController() {
    if (widget.animation != null) {
      _loopToken++;
      _isLooping = false;
      _controller?.stop(canceled: true);
      _controller?.dispose();
      _controller = null;
      return;
    }

    _controller ??= AnimationController(
      vsync: this,
      duration: widget.duration,
    );
  }

  void _startLoopIfNeeded() {
    if (!widget.enabled || _isLooping || widget.animation != null) {
      return;
    }

    _isLooping = true;
    unawaited(_runLoop(++_loopToken));
  }

  Future<void> _runLoop(int token) async {
    while (mounted && widget.enabled && token == _loopToken) {
      try {
        await _controller!.forward(from: 0).orCancel;
      } on TickerCanceled {
        break;
      }

      if (!mounted || !widget.enabled || token != _loopToken) {
        break;
      }

      if (widget.repeatDelay > Duration.zero) {
        await Future<void>.delayed(widget.repeatDelay);
      }
    }

    if (token == _loopToken) {
      _isLooping = false;
    }
  }

  @override
  void dispose() {
    _loopToken++;
    _controller?.stop(canceled: true);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.child;
    }

    return AnimatedBuilder(
      animation: _activeAnimation,
      child: widget.child,
      builder: (context, child) {
        final shaderBoundsResolver =
            AutoShimmerScope.shaderBoundsResolverOf(context);
        final shimmer = ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            final shaderBounds =
                shaderBoundsResolver?.call(context, bounds) ?? bounds;

            return _buildGradient(shaderBounds, _activeAnimation.value);
          },
          child: child,
        );

        if (widget.borderRadius == null) {
          return shimmer;
        }

        return ClipRRect(
          borderRadius: widget.borderRadius!,
          child: shimmer,
        );
      },
    );
  }

  Shader _buildGradient(Rect bounds, double position) {
    final width = bounds.width == 0 ? 1.0 : bounds.width;
    final height = bounds.height == 0 ? 1.0 : bounds.height;
    final axis = _axisFor(widget.direction);
    final slide = AutoShimmerGradient.slide(position, widget.direction);
    final highlight = AutoShimmerGradient.effectiveHighlight(
      widget.baseColor,
      widget.highlightColor,
      widget.highlightOpacity,
    );

    return LinearGradient(
      begin: axis.begin,
      end: axis.end,
      colors: [
        widget.baseColor,
        widget.baseColor,
        highlight,
        widget.baseColor,
        widget.baseColor,
      ],
      stops: AutoShimmerGradient.stops(widget.highlightWidth),
      transform: _SlidingGradientTransform(
        dx: axis.isHorizontal ? slide * width : 0,
        dy: axis.isHorizontal ? 0 : slide * height,
      ),
    ).createShader(bounds);
  }

  _ShimmerAxis _axisFor(AutoShimmerDirection direction) {
    return switch (direction) {
      AutoShimmerDirection.leftToRight => const _ShimmerAxis(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          isHorizontal: true,
        ),
      AutoShimmerDirection.rightToLeft => const _ShimmerAxis(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          isHorizontal: true,
        ),
      AutoShimmerDirection.topToBottom => const _ShimmerAxis(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          isHorizontal: false,
        ),
      AutoShimmerDirection.bottomToTop => const _ShimmerAxis(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          isHorizontal: false,
        ),
    };
  }
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({
    required this.dx,
    required this.dy,
  });

  final double dx;
  final double dy;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(dx, dy, 0);
  }
}

class _ShimmerAxis {
  const _ShimmerAxis({
    required this.begin,
    required this.end,
    required this.isHorizontal,
  });

  final Alignment begin;
  final Alignment end;
  final bool isHorizontal;
}
