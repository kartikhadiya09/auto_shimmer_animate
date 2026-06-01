import 'package:flutter/material.dart';

/// Default colors used by the shimmer skeleton renderer.
abstract final class AutoShimmerColors {
  /// Default parent surface skeleton color.
  static const base = Color(0xFFE5E7EB);

  /// Default child content skeleton color.
  static const childBase = Color(0xFFDADDE3);

  /// Default moving highlight color.
  static const highlight = Color(0xFFFFFFFF);

  /// Dark theme parent surface skeleton color.
  static const darkBase = Color(0xFF2A2F3A);

  /// Dark theme child content skeleton color.
  static const darkChildBase = Color(0xFF3A404C);
}
