import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix_fortal/remix_fortal.dart';

void main() {
  testWidgets('FortalIcons remains a rendering-compatible RemixIcons alias', (
    tester,
  ) async {
    expect(identical(FortalIcons.check, RemixIcons.check), isTrue);
    expect(FortalIcons.check.fontFamily, 'RemixIcons');
    expect(FortalIcons.check.fontPackage, 'remix_icons');

    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: Icon(FortalIcons.check),
      ),
    );

    expect(find.byIcon(RemixIcons.check), findsOneWidget);
  });
}
