import 'package:auto_shimmer_animate_example/main.dart';
import 'package:auto_shimmer_animate/src/core/utils/skeleton_box.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('example app can be constructed', () {
    expect(const ExampleApp(), isA<ExampleApp>());
  });

  testWidgets('example loading state renders multiple skeleton boxes',
      (tester) async {
    await tester.pumpWidget(const ExampleApp());

    expect(find.byType(SkeletonBox), findsWidgets);
    expect(find.byType(SkeletonBox).evaluate().length, greaterThan(4));
    expect(find.text('Everyday Travel Pack'), findsNothing);
  });
}
