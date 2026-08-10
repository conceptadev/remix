import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('Fortal Styles', () {
    testWidgets('renders with ghost variant', (tester) async {
      await tester.pumpRemixApp(
        RemixToggle(
          selected: false,
          onChanged: (value) {},
          label: 'Bold',
          style: fortalToggleStyle(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RemixToggle), findsOneWidget);
    });

    testWidgets('renders with outline variant', (tester) async {
      await tester.pumpRemixApp(
        RemixToggle(
          selected: false,
          onChanged: (value) {},
          label: 'Bold',
          style: fortalToggleStyle(variant: .outline),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RemixToggle), findsOneWidget);
    });

    testWidgets('renders with all sizes', (tester) async {
      for (final size in FortalToggleSize.values) {
        await tester.pumpRemixApp(
          RemixToggle(
            selected: false,
            onChanged: (value) {},
            label: 'Bold',
            style: fortalToggleStyle(size: size),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixToggle), findsOneWidget);
      }
    });

    testWidgets('recipe works for all variant/size combos', (tester) async {
      for (final variant in FortalToggleVariant.values) {
        for (final size in FortalToggleSize.values) {
          await tester.pumpRemixApp(
            RemixToggle(
              selected: false,
              onChanged: (value) {},
              label: 'Bold',
              style: fortalToggleStyle(variant: variant, size: size),
            ),
          );
          await tester.pumpAndSettle();

          expect(find.byType(RemixToggle), findsOneWidget);
        }
      }
    });

    testWidgets('wraps a complete label at 200% in 200 logical pixels', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();

      await tester.pumpRemixApp(
        MediaQuery(
          data: const MediaQueryData(textScaler: TextScaler.linear(2)),
          child: SizedBox(
            width: 200,
            child: FortalToggle(
              selected: false,
              label: 'Workspace Write',
              onChanged: (_) {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(tester.getSize(find.byType(RowBox)).width, lessThanOrEqualTo(200));
      expect(
        tester.getSemantics(find.byType(RemixToggle)).label,
        'Workspace Write',
      );
      semantics.dispose();
    });

    testWidgets('preserves normal label geometry and icon-only sizing', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        FortalToggle(selected: false, label: 'Bold', onChanged: (_) {}),
      );
      await tester.pumpAndSettle();

      final rowSize = tester.getSize(find.byType(RowBox));
      final labelSize = tester.getSize(find.text('Bold'));
      expect(rowSize.width, closeTo(labelSize.width + 24, 0.01));
      expect(rowSize.height, closeTo(labelSize.height + 16, 0.01));

      final iconOnlySizes = <Size>[];
      for (final scaler in const [TextScaler.noScaling, TextScaler.linear(2)]) {
        await tester.pumpRemixApp(
          MediaQuery(
            data: MediaQueryData(textScaler: scaler),
            child: FortalToggle(
              selected: false,
              icon: Icons.format_bold,
              onChanged: (_) {},
            ),
          ),
        );
        await tester.pumpAndSettle();
        iconOnlySizes.add(tester.getSize(find.byType(RowBox)));
      }

      expect(iconOnlySizes[1], iconOnlySizes[0]);
    });

    testWidgets('keeps labels intrinsic under unbounded width', (tester) async {
      await tester.pumpRemixApp(
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: FortalToggle(
            selected: false,
            label: 'Workspace Write',
            onChanged: (_) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.byType(Flexible), findsNothing);
    });

    group('focus-visible ring', () {
      late FocusHighlightStrategy previousStrategy;

      setUp(() {
        previousStrategy = FocusManager.instance.highlightStrategy;
      });

      tearDown(() {
        FocusManager.instance.highlightStrategy = previousStrategy;
      });

      testWidgets('outline toggle keeps focus ring when selected', (
        tester,
      ) async {
        FocusManager.instance.highlightStrategy =
            FocusHighlightStrategy.alwaysTraditional;
        final focusRingColor = await resolveInFortalScope(
          tester,
          (context) => MixScope.tokenOf(FortalTokens.focusA8, context),
        );

        Future<Color?> borderColorFor({required bool selected}) async {
          final focusNode = FocusNode();
          addTearDown(focusNode.dispose);
          await tester.pumpRemixApp(
            RemixToggle(
              selected: selected,
              onChanged: (_) {},
              label: 'T',
              focusNode: focusNode,
              style: fortalToggleStyle(variant: .outline),
            ),
          );
          await tester.pumpAndSettle();

          focusNode.requestFocus();
          await tester.pumpAndSettle();

          expect(focusNode.hasFocus, isTrue);
          return _outlineBorderColor(tester);
        }

        final unselected = await borderColorFor(selected: false);
        final selected = await borderColorFor(selected: true);

        expect(unselected, focusRingColor);
        expect(
          selected,
          unselected,
          reason: 'focus ring must survive selection',
        );
      });

      testWidgets('outline toggle hides focus ring in touch mode', (
        tester,
      ) async {
        FocusManager.instance.highlightStrategy =
            FocusHighlightStrategy.alwaysTouch;
        final focusNode = FocusNode();
        addTearDown(focusNode.dispose);

        await tester.pumpRemixApp(
          RemixToggle(
            selected: false,
            onChanged: (_) {},
            label: 'T',
            focusNode: focusNode,
            style: fortalToggleStyle(variant: .outline),
          ),
        );
        await tester.pumpAndSettle();
        final unfocused = _outlineBorderColor(tester);

        focusNode.requestFocus();
        await tester.pumpAndSettle();

        expect(focusNode.hasFocus, isTrue);
        expect(_outlineBorderColor(tester), unfocused);
      });
    });
  });
}

Color? _outlineBorderColor(WidgetTester tester) {
  final spec = tester.resolvedSpecOf<ToggleSpec>(find.text('T'));
  final decoration = spec.container.spec.box?.spec.decoration;
  if (decoration is! BoxDecoration || decoration.border is! Border) return null;
  return (decoration.border! as Border).top.color;
}
