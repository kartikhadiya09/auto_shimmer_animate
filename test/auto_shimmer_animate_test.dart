import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:auto_shimmer_animate/src/animation/auto_shimmer_effect.dart';

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
