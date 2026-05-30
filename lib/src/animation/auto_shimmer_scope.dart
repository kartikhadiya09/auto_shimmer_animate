import 'dart:async';

import 'package:flutter/widgets.dart';

import '../config/auto_shimmer_config.dart';

/// Resolves shader bounds for a skeleton descendant.
typedef AutoShimmerShaderBoundsResolver = Rect? Function(
  BuildContext context,
  Rect localBounds,
);

/// Provides a synchronized shimmer animation to a skeleton subtree.
class AutoShimmerScope extends StatefulWidget {
  /// Creates a synchronized shimmer scope.
  const AutoShimmerScope({
    super.key,
    required this.config,
    required this.child,
  });

  /// Active shimmer configuration.
  final AutoShimmerConfig config;

  /// Skeleton subtree that should share shimmer timing.
  final Widget child;

  /// Returns the nearest synchronized shimmer animation, if any.
  static Animation<double>? animationOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_AutoShimmerScopeData>()
        ?.animation;
  }

  /// Returns the nearest scoped shimmer config, if any.
  static AutoShimmerConfig? configOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_AutoShimmerScopeData>()
        ?.config;
  }

  /// Returns a build-time resolver for scope-aligned shader bounds.
  static AutoShimmerShaderBoundsResolver? shaderBoundsResolverOf(
    BuildContext context,
  ) {
    return context
        .dependOnInheritedWidgetOfExactType<_AutoShimmerScopeData>()
        ?.shaderBoundsFor;
  }

  /// Returns a shader rect aligned to the shared shimmer scope, if available.
  static Rect? shaderBoundsFor(BuildContext context, Rect localBounds) {
    final element = context
        .getElementForInheritedWidgetOfExactType<_AutoShimmerScopeData>();
    final scopeData = element?.widget;

    if (scopeData is! _AutoShimmerScopeData) {
      return null;
    }

    return scopeData.shaderBoundsFor(context, localBounds);
  }

  @override
  State<AutoShimmerScope> createState() => _AutoShimmerScopeState();
}

class _AutoShimmerScopeState extends State<AutoShimmerScope>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final GlobalKey _scopeKey = GlobalKey(debugLabel: 'AutoShimmerScope');
  bool _isLooping = false;
  int _loopToken = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.config.duration,
    );
    _startLoopIfNeeded();
  }

  @override
  void didUpdateWidget(covariant AutoShimmerScope oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.config.duration != widget.config.duration) {
      _controller.duration = widget.config.duration;
    }

    if (!widget.config.enabled) {
      _loopToken++;
      _isLooping = false;
      _controller.stop(canceled: true);
      _controller.value = 0;
      return;
    }

    _startLoopIfNeeded();
  }

  void _startLoopIfNeeded() {
    if (!widget.config.enabled || _isLooping) {
      return;
    }

    _isLooping = true;
    unawaited(_runLoop(++_loopToken));
  }

  Future<void> _runLoop(int token) async {
    while (mounted && widget.config.enabled && token == _loopToken) {
      try {
        await _controller.forward(from: 0).orCancel;
      } on TickerCanceled {
        break;
      }

      if (!mounted || !widget.config.enabled || token != _loopToken) {
        break;
      }

      if (widget.config.effectiveRepeatDelay > Duration.zero) {
        await Future<void>.delayed(widget.config.effectiveRepeatDelay);
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
    return _AutoShimmerScopeData(
      animation: _controller,
      config: widget.config,
      scopeKey: _scopeKey,
      child: KeyedSubtree(
        key: _scopeKey,
        child: widget.child,
      ),
    );
  }
}

class _AutoShimmerScopeData extends InheritedWidget {
  const _AutoShimmerScopeData({
    required this.animation,
    required this.config,
    required this.scopeKey,
    required super.child,
  });

  final Animation<double> animation;
  final AutoShimmerConfig config;
  final GlobalKey scopeKey;

  Rect? shaderBoundsFor(BuildContext context, Rect localBounds) {
    final scopeContext = scopeKey.currentContext;
    final scopeRenderObject = scopeContext?.findRenderObject();
    final descendantRenderObject = context.findRenderObject();

    if (scopeRenderObject is! RenderBox ||
        descendantRenderObject is! RenderBox ||
        !scopeRenderObject.hasSize ||
        !descendantRenderObject.hasSize) {
      return null;
    }

    final offset = descendantRenderObject.localToGlobal(
      Offset.zero,
      ancestor: scopeRenderObject,
    );

    return Rect.fromLTWH(
      localBounds.left - offset.dx,
      localBounds.top - offset.dy,
      scopeRenderObject.size.width,
      scopeRenderObject.size.height,
    );
  }

  @override
  bool updateShouldNotify(_AutoShimmerScopeData oldWidget) {
    return animation != oldWidget.animation ||
        config != oldWidget.config ||
        scopeKey != oldWidget.scopeKey;
  }
}
