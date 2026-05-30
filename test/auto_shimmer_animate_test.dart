import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:auto_shimmer_animate/src/animation/auto_shimmer_effect.dart';
import 'package:auto_shimmer_animate/src/core/utils/skeleton_box.dart';

enum TestStatus { initial, loading, loaded }

void main() {
  testWidgets('shows original child when not loading', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AutoShimmerAnimate(
          isLoading: false,
          child: Text('Loaded content'),
        ),
      ),
    );

    expect(find.text('Loaded content'), findsOneWidget);
  });

  testWidgets('replaces text with skeleton while loading', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AutoShimmerAnimate(
          isLoading: true,
          child: Text('Loaded content'),
        ),
      ),
    );

    expect(find.text('Loaded content'), findsNothing);
    expect(find.byType(AutoShimmerEffect), findsOneWidget);
  });

  testWidgets('supports childBaseColor customization', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AutoShimmerAnimate(
          isLoading: true,
          baseColor: Colors.black12,
          childBaseColor: Colors.black26,
          child: Text('Custom child color'),
        ),
      ),
    );

    final box = tester.widget<SkeletonBox>(find.byType(SkeletonBox).first);

    expect(box.config.surfaceColor, Colors.black12);
    expect(box.config.contentColor, Colors.black26);
    expect(box.color, Colors.black26);
  });

  testWidgets('supports flat skeleton style', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AutoShimmerAnimate(
          isLoading: true,
          baseColor: Colors.black12,
          childBaseColor: Colors.black26,
          layeredSkeleton: false,
          child: Text('Flat skeleton'),
        ),
      ),
    );

    final box = tester.widget<SkeletonBox>(find.byType(SkeletonBox).first);

    expect(box.config.layeredSkeleton, isFalse);
    expect(box.config.contentColor, Colors.black12);
    expect(box.color, Colors.black12);
  });

  testWidgets('container with child keeps child skeleton visible',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AutoShimmerAnimate(
          isLoading: true,
          baseColor: Colors.black12,
          childBaseColor: Colors.black26,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(12),
            child: const Text('Nested text'),
          ),
        ),
      ),
    );

    final boxes = tester
        .widgetList<SkeletonBox>(find.byType(SkeletonBox))
        .toList(growable: false);

    expect(boxes.any((box) => box.color == Colors.black12), isTrue);
    expect(boxes.any((box) => box.color == Colors.black26), isTrue);
    expect(find.byType(AutoShimmerEffect).evaluate().length, greaterThan(1));
  });

  testWidgets('card with child keeps child skeleton visible', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AutoShimmerAnimate(
          isLoading: true,
          baseColor: Colors.black12,
          childBaseColor: Colors.black26,
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Text('Card text'),
            ),
          ),
        ),
      ),
    );

    final card = tester.widget<Card>(find.byType(Card).first);
    final boxes = tester
        .widgetList<SkeletonBox>(find.byType(SkeletonBox))
        .toList(growable: false);

    expect(card.color, Colors.transparent);
    expect(boxes.any((box) => box.color == Colors.black12), isTrue);
    expect(boxes.any((box) => box.color == Colors.black26), isTrue);
  });

  testWidgets('custom stateless widgets are expanded before fallback',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AutoShimmerAnimate(
          isLoading: true,
          baseColor: Colors.black12,
          childBaseColor: Colors.black26,
          child: _CustomCard(),
        ),
      ),
    );

    final boxes = tester
        .widgetList<SkeletonBox>(find.byType(SkeletonBox))
        .toList(growable: false);

    expect(boxes.length, greaterThan(2));
    expect(boxes.any((box) => box.color == Colors.black12), isTrue);
    expect(boxes.any((box) => box.color == Colors.black26), isTrue);
  });

  testWidgets('supports layered skeleton theme values', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AutoShimmerTheme(
          data: const AutoShimmerConfig(
            baseColor: Colors.black12,
            childBaseColor: Colors.black26,
            layeredSkeleton: true,
          ),
          child: const AutoShimmerAnimate(
            isLoading: true,
            child: Text('Themed shimmer'),
          ),
        ),
      ),
    );

    final box = tester.widget<SkeletonBox>(find.byType(SkeletonBox).first);

    expect(box.config.surfaceColor, Colors.black12);
    expect(box.config.contentColor, Colors.black26);
    expect(box.config.layeredSkeleton, isTrue);
  });

  testWidgets('supports state-based loading', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AutoShimmerStateAnimate<TestStatus>(
          state: TestStatus.loading,
          loadingStates: [TestStatus.initial, TestStatus.loading],
          child: Text('Profile content'),
        ),
      ),
    );

    expect(find.text('Profile content'), findsNothing);
    expect(find.byType(AutoShimmerEffect), findsOneWidget);
  });

  testWidgets('uses custom shimmer builder', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AutoShimmerAnimate(
          isLoading: true,
          shimmerBuilder: (context, child, config) {
            return ColoredBox(color: config.baseColor, child: child);
          },
          child: const Text('Custom builder content'),
        ),
      ),
    );

    expect(find.text('Custom builder content'), findsNothing);
    expect(find.byType(AutoShimmerEffect), findsNothing);
    expect(find.byType(ColoredBox), findsWidgets);
  });

  testWidgets('accepts repeatDelay', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AutoShimmerAnimate(
          isLoading: true,
          repeatDelay: Duration(milliseconds: 100),
          child: Text('Delayed shimmer'),
        ),
      ),
    );

    final effect = tester.widget<AutoShimmerEffect>(
      find.byType(AutoShimmerEffect),
    );

    expect(effect.repeatDelay, const Duration(milliseconds: 100));
  });

  testWidgets('enabled false keeps generated skeleton without animation',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AutoShimmerAnimate(
          isLoading: true,
          enabled: false,
          child: Text('Disabled shimmer'),
        ),
      ),
    );

    final effect = tester.widget<AutoShimmerEffect>(
      find.byType(AutoShimmerEffect),
    );

    expect(effect.enabled, isFalse);
    expect(find.text('Disabled shimmer'), findsNothing);
  });
}

class _CustomCard extends StatelessWidget {
  const _CustomCard();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Text('Custom title'),
            SizedBox(height: 8),
            Text('Custom subtitle'),
          ],
        ),
      ),
    );
  }
}
