import 'dart:async';

import 'package:flutter/material.dart';

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

  @override
  State<AutoShimmerEffect> createState() => _AutoShimmerEffectState();
}

class _AutoShimmerEffectState extends State<AutoShimmerEffect>
    with SingleTickerProviderStateMixin {
  static const _startOffset = -0.85;
  static const _endOffset = 1.85;
  static const _bandSizeFactor = 0.34;
  static const _gradientStops = [0.0, 0.38, 0.5, 0.62, 1.0];

  late final AnimationController _controller;
  late Animation<double> _position;
  bool _isLooping = false;
  int _loopToken = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _position = _buildPositionAnimation();
    _startLoopIfNeeded();
  }

  @override
  void didUpdateWidget(covariant AutoShimmerEffect oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
    }

    if (oldWidget.direction != widget.direction) {
      _position = _buildPositionAnimation();
    }

    if (!widget.enabled) {
      _loopToken++;
      _isLooping = false;
      _controller.stop(canceled: true);
      _controller.value = 0;
      return;
    }

    _startLoopIfNeeded();
  }

  Animation<double> _buildPositionAnimation() {
    final isReverse = switch (widget.direction) {
      AutoShimmerDirection.rightToLeft ||
      AutoShimmerDirection.bottomToTop =>
        true,
      AutoShimmerDirection.leftToRight ||
      AutoShimmerDirection.topToBottom =>
        false,
    };

    return Tween<double>(
      begin: isReverse ? _endOffset : _startOffset,
      end: isReverse ? _startOffset : _endOffset,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }

  void _startLoopIfNeeded() {
    if (!widget.enabled || _isLooping) {
      return;
    }

    _isLooping = true;
    unawaited(_runLoop(++_loopToken));
  }

  Future<void> _runLoop(int token) async {
    while (mounted && widget.enabled && token == _loopToken) {
      try {
        await _controller.forward(from: 0).orCancel;
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
    _controller.stop(canceled: true);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.child;
    }

    return AnimatedBuilder(
      animation: _position,
      child: widget.child,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return _buildGradient(bounds, _position.value);
          },
          child: child,
        );
      },
    );
  }

  Shader _buildGradient(Rect bounds, double position) {
    final width = bounds.width == 0 ? 1.0 : bounds.width;
    final height = bounds.height == 0 ? 1.0 : bounds.height;
    final axis = _axisFor(widget.direction);
    final extent = axis.isHorizontal ? width : height;
    final center = extent * position;
    final halfBand = extent * _bandSizeFactor;
    final highlight = Color.lerp(
      widget.baseColor,
      widget.highlightColor,
      0.72,
    )!;

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
      stops: _gradientStops,
    ).createShader(
      axis.isHorizontal
          ? Rect.fromLTWH(center - halfBand, 0, halfBand * 2, height)
          : Rect.fromLTWH(0, center - halfBand, width, halfBand * 2),
    );
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
