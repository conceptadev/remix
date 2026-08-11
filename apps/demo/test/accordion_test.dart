import 'package:demo/components/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

void main() {
  testWidgets('catalog presents each accordion item as a separate panel', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: FortalScope(child: Builder(builder: buildAvatarUseCase)),
      ),
    );

    final group = tester.widget<RemixAccordionGroup<String>>(
      find.byType(RemixAccordionGroup<String>),
    );
    final items = group.child as Column;

    expect(items.spacing, 8);
    expect(items.children, hasLength(2));
    expect(items.children, everyElement(isA<FortalAccordion<String>>()));
    expect(find.byType(FortalDivider), findsNothing);
  });
}
