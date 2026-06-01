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
    final shimmer = tester.widget<Shimmer>(find.byType(Shimmer));

    expect(box.config.surfaceColor, const Color(0xFFE5E7EB));
    expect(box.config.contentColor, const Color(0xFFDADDE3));
    expect(box.config.hasShimmerAnimationOverrides, isFalse);
    expect(shimmer.color, const Color(0xFFFFFFFF));
    expect(shimmer.colorOpacity, 0.3);
    expect(shimmer.duration, const Duration(seconds: 3));
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
    final shimmer = tester.widget<Shimmer>(find.byType(Shimmer));

    expect(box.config.surfaceColor, const Color(0xFF2A2F3A));
    expect(box.config.contentColor, const Color(0xFF3A404C));
    expect(box.config.hasShimmerAnimationOverrides, isFalse);
    expect(shimmer.color, const Color(0xFFFFFFFF));
    expect(shimmer.colorOpacity, 0.3);
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

    expect(config.baseColor, const Color(0xFFE5E7EB));
    expect(config.childBaseColor, const Color(0xFFDADDE3));
    expect(config.highlightColor, const Color(0xFFFFFFFF));
    expect(config.duration, const Duration(seconds: 3));
    expect(config.effectiveRepeatDelay, Duration.zero);
    expect(config.direction, AutoShimmerDirection.leftTopToRightBottom);
    expect(config.enabled, isTrue);
    expect(config.layeredSkeleton, isTrue);
    expect(config.perElementShimmer, isTrue);
    expect(config.highlightOpacity, 0.3);
    expect(config.highlightWidth, 0.12);
    expect(config.hasShimmerAnimationOverrides, isFalse);
  });

  testWidgets('passes timing and enabled values to shimmer_animation',
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

    final shimmer = tester.widget<Shimmer>(find.byType(Shimmer));

    expect(shimmer.duration, const Duration(milliseconds: 900));
    expect(shimmer.interval, const Duration(milliseconds: 80));
    expect(shimmer.enabled, isFalse);
  });

  test('config tracks explicit shimmer animation overrides', () {
    const config = AutoShimmerConfig(duration: Duration(milliseconds: 900));

    expect(config.hasShimmerAnimationOverrides, isTrue);
  });
}
