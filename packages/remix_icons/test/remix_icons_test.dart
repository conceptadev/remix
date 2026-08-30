import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix_icons/remix_icons.dart';

void main() {
  test('exposes stable icon metadata', () {
    expect(RemixIcons.accessibility.codePoint, 0xE000);
    expect(RemixIcons.accessibility.fontFamily, 'RemixIcons');
    expect(RemixIcons.accessibility.fontPackage, 'remix_icons');

    expect(RemixIcons.check.fontFamily, 'RemixIcons');
    expect(RemixIcons.switchIcon.fontFamily, 'RemixIcons');
    expect(RemixIcons.zoomOut.codePoint, greaterThan(0xE000));
  });

  testWidgets('builds representative generated glyph categories', (
    tester,
  ) async {
    const representatives = [
      RemixIcons.check,
      RemixIcons.heartFilled,
      RemixIcons.borderSplit,
      RemixIcons.arrowLeft,
      RemixIcons.shadow,
    ];

    await tester.pumpWidget(
      WidgetsApp(
        color: const Color(0xFFFFFFFF),
        builder: (context, child) =>
            Row(children: [for (final icon in representatives) Icon(icon)]),
      ),
    );

    expect(find.byType(Icon), findsNWidgets(representatives.length));
    for (final icon in representatives) {
      expect(find.byIcon(icon), findsOneWidget);
    }
  });
}
