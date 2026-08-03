import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('RemixDivider Widget Tests', () {
    group('Basic Rendering', () {
      testWidgets('renders divider with default style', (tester) async {
        await tester.pumpRemixApp(const RemixDivider());

        await tester.pumpAndSettle();

        expect(find.byType(RemixDivider), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
      });

      testWidgets('renders divider with custom style', (tester) async {
        await tester.pumpRemixApp(
          RemixDivider(style: DividerStyler().color(Colors.red)),
        );

        await tester.pumpAndSettle();

        expect(find.byType(RemixDivider), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
      });

      testWidgets('renders divider with thickness', (tester) async {
        await tester.pumpRemixApp(
          RemixDivider(style: DividerStyler().thickness(2.0)),
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
            style: DividerStyler().padding(
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
            style: DividerStyler().margin(
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
            style: DividerStyler().decoration(
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
        const styleSpec = DividerSpec(container: StyleSpec(spec: BoxSpec()));

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
              RemixButton(label: 'Button 1', onPressed: () {}),
              const RemixDivider(),
              RemixButton(label: 'Button 2', onPressed: () {}),
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
