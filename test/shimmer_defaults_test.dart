import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:auto_shimmer_animate/src/core/utils/skeleton_box.dart';

void main() {
  testWidgets('uses light theme shimmer colors by default', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.light(),
        home: const AutoShimmerAnimate(
          isLoading: true,
          child: Text('Layered content'),
        ),
      ),
    );

    final box = tester.widget<SkeletonBox>(find.byType(SkeletonBox).first);
    final shimmer =
        tester.widget<AutoShimmerLayer>(find.byType(AutoShimmerLayer));
    final effect = shimmer.config.resolvedEffect as AutoShimmerSweepEffect;

    expect(box.config.surfaceColor, const Color(0xFFEBEBF4));
    expect(box.config.contentColor, const Color(0xFFEBEBF4));
    expect(box.config.hasShimmerAnimationOverrides, isFalse);
    expect(effect.baseColor, const Color(0xFFEBEBF4));
    expect(effect.highlightColor, const Color(0xFFF4F4F4));
    expect(effect.highlightOpacity, 1.0);
    expect(effect.stops, const [0.1, 0.3, 0.4]);
    expect(effect.duration, const Duration(milliseconds: 2000));
  });

  testWidgets('uses dark theme shimmer colors by default', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.dark(),
        home: const AutoShimmerAnimate(
          isLoading: true,
          child: Text('Dark content'),
        ),
      ),
    );

    final box = tester.widget<SkeletonBox>(find.byType(SkeletonBox).first);
    final shimmer =
        tester.widget<AutoShimmerLayer>(find.byType(AutoShimmerLayer));
    final effect = shimmer.config.resolvedEffect as AutoShimmerSweepEffect;

    expect(box.config.surfaceColor, const Color(0xFF3A3A3A));
    expect(box.config.contentColor, const Color(0xFF3A3A3A));
    expect(box.config.hasShimmerAnimationOverrides, isFalse);
    expect(effect.baseColor, const Color(0xFF3A3A3A));
    expect(effect.highlightColor, const Color(0xFF424242));
    expect(effect.highlightOpacity, 1.0);
  });

  test('config accepts nullable overrides and resolves package defaults', () {
    const config = AutoShimmerConfig(
      baseColor: null,
      childBaseColor: null,
      highlightColor: null,
      duration: null,
      repeatDelay: null,
      borderRadius: null,
      direction: null,
      enabled: null,
      layeredSkeleton: null,
      perElementShimmer: null,
      highlightOpacity: null,
      highlightWidth: null,
    );

    expect(config.baseColor, const Color(0xFFEBEBF4));
    expect(config.childBaseColor, const Color(0xFFEBEBF4));
    expect(config.highlightColor, const Color(0xFFF4F4F4));
    expect(config.duration, const Duration(milliseconds: 2000));
    expect(config.effectiveRepeatDelay, Duration.zero);
    expect(config.direction, AutoShimmerDirection.leftTopToRightBottom);
    expect(config.enabled, isTrue);
    expect(config.layeredSkeleton, isTrue);
    expect(config.perElementShimmer, isTrue);
    expect(config.highlightOpacity, 1.0);
    expect(config.highlightWidth, 0.1);
    expect(config.hasShimmerAnimationOverrides, isFalse);
  });

  testWidgets('passes timing and enabled values to internal shimmer layer',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AutoShimmerAnimate(
          isLoading: true,
          duration: Duration(milliseconds: 900),
          repeatDelay: Duration(milliseconds: 80),
          enabled: false,
          child: Text('Tuned shimmer'),
        ),
      ),
    );

    final shimmer =
        tester.widget<AutoShimmerLayer>(find.byType(AutoShimmerLayer));

    expect(shimmer.config.duration, const Duration(milliseconds: 900));
    expect(
        shimmer.config.effectiveRepeatDelay, const Duration(milliseconds: 80));
    expect(shimmer.config.enabled, isFalse);
  });

  test('config tracks explicit shimmer animation overrides', () {
    const config = AutoShimmerConfig(duration: Duration(milliseconds: 900));

    expect(config.hasShimmerAnimationOverrides, isTrue);
  });

  testWidgets('user-provided baseColor is used exactly', (tester) async {
    const customColor = Color(0xFF123456);
    await tester.pumpWidget(
      const MaterialApp(
        home: AutoShimmerAnimate(
          isLoading: true,
          baseColor: customColor,
          child: Text('Custom base color'),
        ),
      ),
    );

    final config =
        tester.widget<SkeletonBox>(find.byType(SkeletonBox).first).config;
    expect(config.baseColor, customColor);
  });

  testWidgets('user-provided highlightColor is used exactly', (tester) async {
    const customColor = Color(0xFFABCDEF);
    await tester.pumpWidget(
      const MaterialApp(
        home: AutoShimmerAnimate(
          isLoading: true,
          highlightColor: customColor,
          child: Text('Custom highlight color'),
        ),
      ),
    );

    final shimmer =
        tester.widget<AutoShimmerLayer>(find.byType(AutoShimmerLayer));
    final effect = shimmer.config.resolvedEffect as AutoShimmerSweepEffect;
    expect(effect.highlightColor, customColor);
  });

  testWidgets('user-provided childBaseColor is used exactly', (tester) async {
    const customColor = Color(0xFF654321);
    await tester.pumpWidget(
      const MaterialApp(
        home: AutoShimmerAnimate(
          isLoading: true,
          childBaseColor: customColor,
          child: Text('Custom child base color'),
        ),
      ),
    );

    final config =
        tester.widget<SkeletonBox>(find.byType(SkeletonBox).first).config;
    expect(config.childBaseColor, customColor);
  });

  testWidgets('default highlight width matches sweep stop spacing',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AutoShimmerAnimate(
          isLoading: true,
          child: Text('Subtle shimmer'),
        ),
      ),
    );

    final config =
        tester.widget<SkeletonBox>(find.byType(SkeletonBox).first).config;
    expect(config.highlightWidth, 0.1);
  });
}
