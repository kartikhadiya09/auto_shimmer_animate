import 'package:flutter/widgets.dart';

import 'auto_shimmer_config.dart';

/// Provides default shimmer configuration to all descendants.
///
/// Values passed directly to `AutoShimmerAnimate` override the nearest
/// `AutoShimmerTheme`.
class AutoShimmerTheme extends InheritedWidget {
  /// Creates a theme that supplies [data] to descendant shimmer widgets.
  const AutoShimmerTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// Configuration used by descendant shimmer widgets.
  final AutoShimmerConfig data;

  /// Returns the nearest [AutoShimmerConfig], or the package defaults.
  static AutoShimmerConfig of(BuildContext context) {
    return maybeOf(context) ?? AutoShimmerConfig.adaptive(context);
  }

  /// Returns the nearest [AutoShimmerConfig], if one exists.
  static AutoShimmerConfig? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AutoShimmerTheme>()?.data;
  }

  @override
  bool updateShouldNotify(AutoShimmerTheme oldWidget) {
    return data != oldWidget.data;
  }
}
