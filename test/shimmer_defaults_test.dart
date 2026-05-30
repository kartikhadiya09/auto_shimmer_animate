import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:auto_shimmer_animate/src/animation/auto_shimmer_effect.dart';
import 'package:auto_shimmer_animate/src/animation/auto_shimmer_gradient.dart';
import 'package:auto_shimmer_animate/src/animation/auto_shimmer_scope.dart';
import 'package:auto_shimmer_animate/src/core/utils/skeleton_box.dart';

void main() {
  testWidgets('uses layered skeleton colors by default', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AutoShimmerAnimate(
          isLoading: true,
          child: Text('Layered content'),
        ),
      ),
    );

    final box = tester.widget<SkeletonBox>(find.byType(SkeletonBox).first);

    expect(box.config.layeredSkeleton, isTrue);
    expect(box.config.surfaceColor, const Color(0xFFE5E7EB));
    expect(box.config.contentColor, const Color(0xFFDADDE3));
    expect(box.config.highlightColor, const Color(0xFFF2F4F7));
    expect(box.config.highlightOpacity, 0.35);
    expect(box.config.highlightWidth, 0.12);
    expect(box.config.duration, const Duration(milliseconds: 1600));
    expect(box.config.effectiveRepeatDelay, Duration.zero);
    expect(box.color, const Color(0xFFDADDE3));
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
    expect(config.highlightColor, const Color(0xFFF2F4F7));
    expect(config.duration, const Duration(milliseconds: 1600));
    expect(config.effectiveRepeatDelay, Duration.zero);
    expect(config.direction, AutoShimmerDirection.leftToRight);
    expect(config.enabled, isTrue);
    expect(config.layeredSkeleton, isTrue);
    expect(config.perElementShimmer, isTrue);
    expect(config.highlightOpacity, 0.35);
    expect(config.highlightWidth, 0.12);
  });

  testWidgets('supports highlight opacity and width customization',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AutoShimmerAnimate(
          isLoading: true,
          highlightOpacity: 0.45,
          highlightWidth: 0.14,
          child: Text('Tuned shimmer'),
        ),
      ),
    );

    final effect = tester.widget<AutoShimmerEffect>(
      find.byType(AutoShimmerEffect).first,
    );

    expect(effect.highlightOpacity, 0.45);
    expect(effect.highlightWidth, 0.14);
  });

  test('shimmer gradient blends highlight from base color', () {
    final highlight = AutoShimmerGradient.effectiveHighlight(
      const Color(0xFFE5E7EB),
      const Color(0xFFF2F4F7),
      0.35,
    );

    expect(
      highlight,
      Color.lerp(
        const Color(0xFFE5E7EB),
        const Color(0xFFF2F4F7),
        0.35,
      ),
    );
  });

  test('shimmer highlight width clamps safely', () {
    expect(AutoShimmerGradient.stops(-1), [0.0, 0.49, 0.5, 0.51, 1.0]);
    expect(AutoShimmerGradient.stops(2), [0.0, 0.0, 0.5, 1.0, 1.0]);
  });

  testWidgets('shared shimmer scope exposes aligned shader bounds',
      (tester) async {
    final descendantKey = GlobalKey();

    await tester.pumpWidget(
      MaterialApp(
        home: Center(
          child: SizedBox(
            width: 240,
            height: 80,
            child: AutoShimmerScope(
              config: const AutoShimmerConfig(),
              child: Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  key: descendantKey,
                  width: 60,
                  height: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    final bounds = AutoShimmerScope.shaderBoundsFor(
      descendantKey.currentContext!,
      const Rect.fromLTWH(0, 0, 60, 20),
    );

    expect(bounds, isNotNull);
    expect(bounds!.width, 240);
    expect(bounds.height, 80);
    expect(bounds.left, lessThan(0));
  });
}
