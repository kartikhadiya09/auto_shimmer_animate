import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:auto_shimmer_animate/src/animation/auto_shimmer_effect.dart';
import 'package:auto_shimmer_animate/src/core/utils/skeleton_box.dart';

void main() {
  testWidgets('layered mode uses per-element shimmer effects', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AutoShimmerAnimate(
          isLoading: true,
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  Text('Title'),
                  SizedBox(height: 8),
                  Text('Subtitle'),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.byType(SkeletonBox).evaluate().length, greaterThan(2));
    expect(find.byType(AutoShimmerEffect).evaluate().length, greaterThan(2));
  });

  testWidgets('multiple skeleton boxes share one shimmer animation',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AutoShimmerAnimate(
          isLoading: true,
          child: Column(
            children: [
              Text('Title'),
              SizedBox(height: 8),
              Text('Subtitle'),
            ],
          ),
        ),
      ),
    );

    final effects = tester
        .widgetList<AutoShimmerEffect>(find.byType(AutoShimmerEffect))
        .toList(growable: false);

    expect(effects.length, greaterThan(1));
    expect(effects.first.animation, isNotNull);
    expect(
      effects.every((effect) => effect.animation == effects.first.animation),
      isTrue,
    );
  });

  testWidgets('ListTile content shimmers as separate elements', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: AutoShimmerAnimate(
            isLoading: true,
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text('Title'),
              subtitle: Text('Subtitle'),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
        ),
      ),
    );

    expect(find.byType(SkeletonBox).evaluate().length, greaterThanOrEqualTo(4));
    expect(
      find.byType(AutoShimmerEffect).evaluate().length,
      greaterThanOrEqualTo(4),
    );
  });

  testWidgets('flat mode keeps one global shimmer effect', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AutoShimmerAnimate(
          isLoading: true,
          layeredSkeleton: false,
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  Text('Title'),
                  SizedBox(height: 8),
                  Text('Subtitle'),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.byType(AutoShimmerEffect), findsOneWidget);
  });
}
