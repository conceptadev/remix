import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix_agent_example/motion.dart';

Widget _host(Widget child, {bool reduce = false}) => Directionality(
  textDirection: TextDirection.ltr,
  child: MediaQuery(
    data: MediaQueryData(disableAnimations: reduce),
    child: child,
  ),
);

void main() {
  testWidgets('entrance interpolates without changing layout or replaying', (
    tester,
  ) async {
    const content = SizedBox(key: ValueKey('content'), width: 160, height: 48);
    Widget item() => _host(
      const Center(
        child: CatalogEntrance(key: ValueKey('request-1'), child: content),
      ),
    );
    double opacity() => tester.widget<Opacity>(find.byType(Opacity)).opacity;

    await tester.pumpWidget(item());
    final bounds = tester.getSize(find.byKey(const ValueKey('content')));
    expect(opacity(), 0);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 60));
    expect(opacity(), greaterThan(0));
    expect(opacity(), lessThan(1));
    expect(tester.getSize(find.byKey(const ValueKey('content'))), bounds);
    await tester.pumpAndSettle();
    expect(opacity(), 1);
    await tester.pumpWidget(item());
    expect(opacity(), 1, reason: 'Same request must not replay its entrance.');
  });

  testWidgets('chevron interpolates and can reverse before settling', (
    tester,
  ) async {
    Widget chevron(bool expanded) =>
        _host(Builder(builder: (context) => catalogChevron(context, expanded)));
    double cosine() =>
        tester.widget<Transform>(find.byType(Transform)).transform.entry(0, 0);

    await tester.pumpWidget(chevron(false));
    expect(cosine(), closeTo(1, 0.001));
    await tester.pumpWidget(chevron(true));
    await tester.pump(const Duration(milliseconds: 60));
    expect(cosine(), greaterThan(-1));
    expect(cosine(), lessThan(1));
    await tester.pumpWidget(chevron(false));
    await tester.pumpAndSettle();
    expect(cosine(), closeTo(1, 0.001));
  });

  testWidgets('reduced motion renders entrances and chevrons immediately', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(const CatalogEntrance(child: SizedBox()), reduce: true),
    );
    expect(tester.widget<Opacity>(find.byType(Opacity)).opacity, 1);
    await tester.pumpAndSettle();
    Widget chevron(bool expanded) => _host(
      Builder(builder: (context) => catalogChevron(context, expanded)),
      reduce: true,
    );
    await tester.pumpWidget(chevron(false));
    await tester.pumpWidget(chevron(true));
    expect(
      tester.widget<Transform>(find.byType(Transform)).transform.entry(0, 0),
      closeTo(-1, 0.001),
    );
    expect(tester.binding.transientCallbackCount, 0);
  });
}
