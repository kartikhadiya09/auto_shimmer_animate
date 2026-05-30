import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:auto_shimmer_animate/src/animation/auto_shimmer_effect.dart';
import 'package:auto_shimmer_animate/src/core/utils/skeleton_box.dart';

void main() {
  testWidgets('AutoShimmerEffect receives borderRadius', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AutoShimmerEffect(
          baseColor: Colors.black12,
          highlightColor: Colors.white,
          duration: const Duration(milliseconds: 1200),
          repeatDelay: Duration.zero,
          direction: AutoShimmerDirection.leftToRight,
          borderRadius: BorderRadius.circular(18),
          child: const SizedBox(width: 80, height: 40),
        ),
      ),
    );

    final effect = tester.widget<AutoShimmerEffect>(
      find.byType(AutoShimmerEffect),
    );

    expect(effect.borderRadius, BorderRadius.circular(18));
  });

  testWidgets('SkeletonBox with borderRadius renders ClipRRect',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SizedBox(
          width: 80,
          height: 40,
          child: SkeletonBox(
            config: const AutoShimmerConfig(),
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );

    expect(find.byType(ClipRRect), findsWidgets);
    expect(
      find.byWidgetPredicate((widget) {
        return widget is ClipRRect &&
            widget.borderRadius == BorderRadius.circular(14);
      }),
      findsWidgets,
    );
  });

  testWidgets('card skeleton preserves rounded clipping', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AutoShimmerAnimate(
          isLoading: true,
          borderRadius: BorderRadius.circular(16),
          child: const Card(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Text('Rounded card'),
            ),
          ),
        ),
      ),
    );

    final card = tester.widget<Card>(find.byType(Card).first);

    expect(card.clipBehavior, Clip.antiAlias);
    expect(card.shape, isA<RoundedRectangleBorder>());
    expect(
      (card.shape! as RoundedRectangleBorder).borderRadius,
      BorderRadius.circular(16),
    );
  });

  testWidgets('container skeleton with borderRadius preserves clipping',
      (tester) async {
    final radius = BorderRadius.circular(20);

    await tester.pumpWidget(
      MaterialApp(
        home: AutoShimmerAnimate(
          isLoading: true,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: radius,
            ),
            child: const Text('Rounded container'),
          ),
        ),
      ),
    );

    expect(
      find.byWidgetPredicate((widget) {
        return widget is ClipRRect && widget.borderRadius == radius;
      }),
      findsWidgets,
    );
  });

  testWidgets('ClipRRect child remains clipped', (tester) async {
    final radius = BorderRadius.circular(22);

    await tester.pumpWidget(
      MaterialApp(
        home: AutoShimmerAnimate(
          isLoading: true,
          child: ClipRRect(
            borderRadius: radius,
            child: const Text('Clipped child'),
          ),
        ),
      ),
    );

    expect(
      find.byWidgetPredicate((widget) {
        return widget is ClipRRect && widget.borderRadius == radius;
      }),
      findsOneWidget,
    );
  });
}
