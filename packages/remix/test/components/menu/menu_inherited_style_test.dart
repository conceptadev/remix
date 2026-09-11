import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  for (final raw in [false, true]) {
    testWidgets('menu inherits root item styles unless raw=$raw', (
      tester,
    ) async {
      final brightness = ValueNotifier(Brightness.light);
      addTearDown(brightness.dispose);
      final inherited = MenuStyler()
          .item(
            MenuItemStyler().label(
              TextStyler().fontFamily('InheritedFont').fontSize(19),
            ),
          )
          .onDark(
            MenuStyler().item(
              MenuItemStyler().label(TextStyler().fontSize(27)),
            ),
          );
      await tester.pumpWidget(
        MixScope.empty(
          child: StyleProvider<MenuSpec>(
            style: inherited,
            child: MaterialApp(
              builder: (_, child) => ValueListenableBuilder<Brightness>(
                valueListenable: brightness,
                builder: (_, value, _) => MediaQuery(
                  data: MediaQueryData(platformBrightness: value),
                  child: child!,
                ),
              ),
              home: Scaffold(
                body: Center(
                  child: RemixMenu<String>(
                    trigger: const RemixMenuTrigger(label: 'Options'),
                    onSelected: (_) {},
                    items: [
                      const RemixMenuItem(
                        value: 'inherited',
                        label: 'Inherited',
                      ),
                      RemixMenuItem(
                        value: 'override',
                        label: 'Item override',
                        style: MenuItemStyler().label(
                          TextStyler().fontSize(31),
                        ),
                      ),
                    ],
                    style: MenuStyler().item(
                      MenuItemStyler().label(
                        TextStyler().color(Colors.red),
                      ),
                    ),
                    styleSpec: raw
                        ? const MenuSpec(
                            item: StyleSpec(
                              spec: MenuItemSpec(
                                label: StyleSpec(
                                  spec: TextSpec(
                                    style: TextStyle(
                                      fontFamily: 'RawFont',
                                      fontSize: 21,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : null,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Options'));
      await tester.pumpAndSettle();
      TextStyle? rendered(String label) => tester
          .widget<RichText>(
            find.descendant(
              of: find.text(label),
              matching: find.byType(RichText),
            ),
          )
          .text
          .style;
      for (final value in [
        Brightness.light,
        Brightness.dark,
        Brightness.light,
      ]) {
        brightness.value = value;
        await tester.pumpAndSettle();
        expect(
          rendered('Inherited')?.fontSize,
          raw ? 21 : (value == Brightness.dark ? 27 : 19),
        );
        expect(
          rendered('Inherited')?.fontFamily,
          raw ? 'RawFont' : 'InheritedFont',
        );
        expect(
          rendered('Inherited')?.color,
          raw ? Colors.blue : Colors.red,
        );
        expect(rendered('Item override')?.fontSize, raw ? 21 : 31);
      }
      expect(tester.takeException(), isNull);
    });
  }
}
