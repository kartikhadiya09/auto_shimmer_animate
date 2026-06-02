import 'package:flutter/material.dart';

/// Default colors used by the shimmer skeleton renderer.
abstract final class AutoShimmerColors {
  /// Default parent surface skeleton color.
  static const base = Color(0xFFEBEBF4);

  /// Default child content skeleton color.
  static const childBase = Color(0xFFEBEBF4);

  /// Default moving highlight color.
  static const highlight = Color(0xFFF4F4F4);

  /// Dark theme parent surface skeleton color.
  static const darkBase = Color(0xFF3A3A3A);

  /// Dark theme child content skeleton color.
  static const darkChildBase = Color(0xFF3A3A3A);

  /// Dark theme moving highlight color.
  static const darkHighlight = Color(0xFF424242);
}
