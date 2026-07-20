import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('RemixDivider Widget Tests', () {
    test('defaults to a decorative horizontal divider', () {
      const divider = RemixDivider();

      expect(divider.orientation, Axis.horizontal);
      expect(divider.decorative, isTrue);
    });

    testWidgets('exposes non-decorative separator semantics', (tester) async {
      await tester.pumpRemixApp(
        const RemixDivider(decorative: false, semanticLabel: 'Section break'),
      );

      expect(find.bySemanticsLabel('Section break'), findsOneWidget);
    });

    testWidgets('keeps decorative dividers out of the semantics tree', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        const RemixDivider(semanticLabel: 'Decorative break'),
      );

      expect(find.bySemanticsLabel('Decorative break'), findsNothing);
    });

    testWidgets('Fortal divider sizes resolve every orientation and length', (
      tester,
    ) async {
      const fixedLengths = <FortalDividerSize, double>{
        FortalDividerSize.size1: 16,
        FortalDividerSize.size2: 32,
        FortalDividerSize.size3: 64,
      };

      for (final orientation in Axis.values) {
        for (final entry in fixedLengths.entries) {
          await tester.pumpRemixApp(
            FortalDivider(size: entry.key, orientation: orientation),
          );
          expect(
            tester.getSize(find.byType(Box)),
            orientation == Axis.horizontal
                ? Size(entry.value, 1)
                : Size(1, entry.value),
            reason: '$orientation ${entry.key}',
          );
        }
      }

      await tester.pumpRemixApp(
        const SizedBox(
          width: 120,
          height: 20,
          child: FortalDivider(size: .size4),
        ),
      );
      expect(tester.getSize(find.byType(Box)), const Size(120, 1));

      await tester.pumpRemixApp(
        const SizedBox(
          width: 20,
          height: 120,
          child: FortalDivider(size: .size4, orientation: Axis.vertical),
        ),
      );
      expect(tester.getSize(find.byType(Box)), const Size(1, 120));
    });

    group('Basic Rendering', () {
      testWidgets('renders divider with default style', (tester) async {
        await tester.pumpRemixApp(const RemixDivider());

        await tester.pumpAndSettle();

        expect(find.byType(RemixDivider), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
      });

      testWidgets('renders divider with custom style', (tester) async {
        await tester.pumpRemixApp(
          RemixDivider(style: RemixDividerStyler().color(Colors.red)),
        );

        await tester.pumpAndSettle();

        expect(find.byType(RemixDivider), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
      });

      testWidgets('renders divider with thickness', (tester) async {
        await tester.pumpRemixApp(
          RemixDivider(style: RemixDividerStyler().thickness(2.0)),
        );

        await tester.pumpAndSettle();

        expect(find.byType(RemixDivider), findsOneWidget);
      });
    });

    group('Layout', () {
      testWidgets('multiple dividers render correctly', (tester) async {
        await tester.pumpRemixApp(
          Column(
            children: const [
              Text('Item 1'),
              RemixDivider(),
              Text('Item 2'),
              RemixDivider(),
              Text('Item 3'),
            ],
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byType(RemixDivider), findsNWidgets(2));
        expect(find.text('Item 1'), findsOneWidget);
        expect(find.text('Item 2'), findsOneWidget);
        expect(find.text('Item 3'), findsOneWidget);
      });

      testWidgets('divider stretches to fill available width', (tester) async {
        await tester.pumpRemixApp(
          SizedBox(width: 200, child: const RemixDivider()),
        );

        await tester.pumpAndSettle();

        final box = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(box.width, equals(200));
      });
    });

    group('Style Application', () {
      testWidgets('applies padding style correctly', (tester) async {
        await tester.pumpRemixApp(
          RemixDivider(
            style: RemixDividerStyler().padding(
              EdgeInsetsGeometryMix.symmetric(vertical: 8.0),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byType(RemixDivider), findsOneWidget);
      });

      testWidgets('applies margin style correctly', (tester) async {
        await tester.pumpRemixApp(
          RemixDivider(
            style: RemixDividerStyler().margin(
              EdgeInsetsGeometryMix.symmetric(horizontal: 16.0),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byType(RemixDivider), findsOneWidget);
      });

      testWidgets('applies decoration style correctly', (tester) async {
        await tester.pumpRemixApp(
          RemixDivider(
            style: RemixDividerStyler().decoration(
              BoxDecorationMix(
                color: Colors.blue,
                borderRadius: BorderRadiusMix.circular(4.0),
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byType(RemixDivider), findsOneWidget);
      });
    });

    group('StyleSpec Usage', () {
      testWidgets('renders with styleSpec parameter', (tester) async {
        const styleSpec = RemixDividerSpec(
          container: StyleSpec(spec: BoxSpec()),
        );

        await tester.pumpRemixApp(RemixDivider(styleSpec: styleSpec));

        await tester.pumpAndSettle();

        expect(find.byType(RemixDivider), findsOneWidget);
      });
    });

    group('Integration', () {
      testWidgets('works in ListView', (tester) async {
        await tester.pumpRemixApp(
          ListView(
            children: List.generate(5, (index) {
              return Column(
                children: [
                  Text('Item $index'),
                  if (index < 4) const RemixDivider(),
                ],
              );
            }),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byType(RemixDivider), findsNWidgets(4));
      });

      testWidgets('works alongside other Remix components', (tester) async {
        await tester.pumpRemixApp(
          Column(
            children: [
              RemixButton(onPressed: () {}, child: const Text('Button 1')),
              const RemixDivider(),
              RemixButton(onPressed: () {}, child: const Text('Button 2')),
            ],
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byType(RemixButton), findsNWidgets(2));
        expect(find.byType(RemixDivider), findsOneWidget);
      });
    });
  });
}
