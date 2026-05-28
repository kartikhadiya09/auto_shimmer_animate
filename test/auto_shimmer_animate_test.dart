import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

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
    expect(find.byType(Shimmer), findsOneWidget);
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
    expect(find.byType(Shimmer), findsOneWidget);
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
    expect(find.byType(Shimmer), findsNothing);
    expect(find.byType(ColoredBox), findsWidgets);
  });
}
