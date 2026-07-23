import 'package:demo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  for (final (themeName, brightness, appearance) in const [
    ('light', Brightness.light, FortalAppearance.light),
    ('dark', Brightness.dark, FortalAppearance.dark),
  ]) {
    testWidgets(
      'Widgetbook $themeName selection drives Material and Fortal together',
      (tester) async {
        final addon = FortalThemeAddon();
        final state = WidgetbookState(
          queryParams: {
            addon.groupName: FieldCodec.encodeQueryGroup({'name': themeName}),
          },
          root: WidgetbookRoot(children: []),
        );
        addTearDown(state.dispose);

        Brightness? materialBrightness;
        FortalAppearance? fortalAppearance;
        await tester.pumpWidget(
          WidgetbookScope(
            state: state,
            child: Builder(
              builder: (context) => buildFortalWidgetbookApp(
                context,
                Builder(
                  builder: (context) {
                    materialBrightness = Theme.of(context).brightness;
                    fortalAppearance = FortalTheme.of(context).appearance;
                    return const SizedBox.shrink();
                  },
                ),
                addon,
              ),
            ),
          ),
        );

        expect(materialBrightness, brightness);
        expect(fortalAppearance, appearance);
        expect(
          find.ancestor(
            of: find.byType(MaterialApp),
            matching: find.byType(FortalScope),
          ),
          findsOneWidget,
        );
      },
    );
  }
}
