import 'dart:async';

import 'package:flutter/material.dart';

import '../config/auto_shimmer_config.dart';
import '../effects/auto_shimmer_effect.dart';

/// Default animated shimmer renderer for generated skeletons.
class AutoShimmerLayer extends StatefulWidget {
  /// Creates the default shimmer layer.
  const AutoShimmerLayer({
    super.key,
    required this.config,
    required this.child,
  });

  /// Active shimmer configuration.
  final AutoShimmerConfig config;

  /// Generated skeleton child.
  final Widget child;

  @override
  State<AutoShimmerLayer> createState() => _AutoShimmerLayerState();
}

class _AutoShimmerLayerState extends State<AutoShimmerLayer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Timer? _repeatTimer;

  @override
  void initState() {
    super.initState();
    _controller = _createController();
    _startAnimation();
  }

  @override
  void didUpdateWidget(AutoShimmerLayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldEffect = oldWidget.config.resolvedEffect;
    final effect = widget.config.resolvedEffect;
    final needsControllerUpdate = oldEffect.duration != effect.duration ||
        oldEffect.lowerBound != effect.lowerBound ||
        oldEffect.upperBound != effect.upperBound;

    if (needsControllerUpdate) {
      _repeatTimer?.cancel();
      _controller.dispose();
      _controller = _createController();
    }

    if (oldWidget.config.enabled != widget.config.enabled ||
        oldWidget.config.effectiveRepeatDelay !=
            widget.config.effectiveRepeatDelay ||
        oldEffect != effect ||
        needsControllerUpdate) {
      _startAnimation();
    }
  }

  AnimationController _createController() {
    final effect = widget.config.resolvedEffect;
    return AnimationController(
      vsync: this,
      duration: effect.duration,
      lowerBound: effect.lowerBound,
      upperBound: effect.upperBound,
      value: effect.lowerBound,
    );
  }

  void _startAnimation() {
    _repeatTimer?.cancel();
    _controller.stop();

    final effect = widget.config.resolvedEffect;
    if (!widget.config.enabled) {
      _controller.value = effect.lowerBound;
      return;
    }

    if (effect.reverse) {
      _controller.repeat(reverse: true);
      return;
    }

    _runSweep();
  }

  void _runSweep() {
    final effect = widget.config.resolvedEffect;
    _controller.value = effect.lowerBound;
    _controller.forward().whenComplete(() {
      if (!mounted || !widget.config.enabled) {
        return;
      }

      final delay = widget.config.effectiveRepeatDelay;
      if (delay == Duration.zero) {
        _runSweep();
      } else {
        _repeatTimer = Timer(delay, _runSweep);
      }
    });
  }

  @override
  void dispose() {
    _repeatTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textDirection = Directionality.maybeOf(context);

    if (!widget.config.enabled) {
      return widget.child;
    }

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        child: widget.child,
        builder: (context, child) {
          final effect = widget.config.resolvedEffect;
          return CustomPaint(
            foregroundPainter: _AutoShimmerPainter(
              effect: effect,
              value: _animatedValue(effect),
              textDirection: textDirection,
            ),
            child: child,
          );
        },
      ),
    );
  }

  double _animatedValue(AutoShimmerEffect effect) {
    if (effect.reverse) {
      return _controller.value;
    }

    final distance = effect.upperBound - effect.lowerBound;
    if (distance == 0) {
      return effect.lowerBound;
    }

    final progress =
        ((_controller.value - effect.lowerBound) / distance).clamp(0.0, 1.0);
    final curved = const Interval(
      0,
      0.6,
      curve: Curves.decelerate,
    ).transform(progress);
    return effect.lowerBound + distance * curved;
  }
}

/// Backward-compatible name for the default shimmer wrapper.
typedef ShimmerWrapper = AutoShimmerLayer;

class _AutoShimmerPainter extends CustomPainter {
  const _AutoShimmerPainter({
    required this.effect,
    required this.value,
    required this.textDirection,
  });

  final AutoShimmerEffect effect;
  final double value;
  final TextDirection? textDirection;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) {
      return;
    }

    final rect = Offset.zero & size;
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..shader = effect.createShader(value, rect, textDirection);

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant _AutoShimmerPainter oldDelegate) {
    return oldDelegate.effect != effect ||
        oldDelegate.value != value ||
        oldDelegate.textDirection != textDirection;
  }
}
