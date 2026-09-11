import 'dart:ui' show PointerDeviceKind;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  testWidgets(
    'open menu tracks theme and preserves item hover and kind styles',
    (tester) async {
      final brightness = ValueNotifier(Brightness.light);
      addTearDown(brightness.dispose);
      final style = MenuStyler()
          .item(MenuItemStyler().label(TextStyler().fontSize(12)))
          .onDark(
            MenuStyler()
                .item(
                  MenuItemStyler()
                      .label(TextStyler().fontSize(24))
                      .onHovered(
                        MenuItemStyler().label(TextStyler().fontSize(30)),
                      ),
                )
                .checkboxItem(
                  MenuItemStyler().label(TextStyler().fontSize(26)),
                ),
          );
      await tester.pumpWidget(
        MixScope.empty(
          child: MaterialApp(
            builder: (context, child) => ValueListenableBuilder(
              valueListenable: brightness,
              builder: (context, value, _) => MediaQuery(
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
                    const RemixMenuItem(value: 'copy', label: 'Copy'),
                    RemixMenuCheckboxItem(
                      value: 'check',
                      label: 'Checked',
                      checked: true,
                      onChanged: (_) {},
                    ),
                  ],
                  style: style,
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Options'));
      await tester.pumpAndSettle();
      double? fontSize(String label) => tester
          .widget<RichText>(
            find.descendant(
              of: find.text(label),
              matching: find.byType(RichText),
            ),
          )
          .text
          .style
          ?.fontSize;
      expect(fontSize('Copy'), 12);
      brightness.value = Brightness.dark;
      await tester.pumpAndSettle();
      expect(fontSize('Copy'), 24);
      expect(fontSize('Checked'), 26);
      final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await mouse.addPointer(location: Offset.zero);
      await mouse.moveTo(tester.getCenter(find.text('Copy')));
      await tester.pumpAndSettle();
      expect(fontSize('Copy'), 30);
      await mouse.removePointer();
      await tester.pumpAndSettle();
      expect(fontSize('Copy'), 24);
      brightness.value = Brightness.light;
      await tester.pumpAndSettle();
      expect(fontSize('Copy'), 12);
      expect(fontSize('Checked'), 12);
    },
  );
  for (final brightness in Brightness.values) {
    for (final overrideSize in <double?>[null, 32]) {
      testWidgets(
        'menu root variant $brightness and item override $overrideSize',
        (tester) async {
          final style = MenuStyler()
              .item(MenuItemStyler().label(TextStyler().fontSize(12)))
              .onDark(
                MenuStyler().item(
                  MenuItemStyler().label(TextStyler().fontSize(24)),
                ),
              );
          double? resolvedRootSize;
          await tester.pumpWidget(
            MixScope.empty(
              child: MaterialApp(
                builder: (context, child) => MediaQuery(
                  data: MediaQueryData(platformBrightness: brightness),
                  child: child!,
                ),
                home: Scaffold(
                  body: Center(
                    child: Column(
                      children: [
                        StyleBuilder<MenuSpec>(
                          style: style,
                          builder: (context, spec) {
                            resolvedRootSize =
                                spec.item.spec.label.spec.style?.fontSize;
                            return const SizedBox();
                          },
                        ),
                        RemixMenu<String>(
                          trigger: const RemixMenuTrigger(label: 'Options'),
                          items: [
                            RemixMenuItem(
                              value: 'copy',
                              label: 'Copy',
                              style: overrideSize == null
                                  ? const MenuItemStyler.create()
                                  : MenuItemStyler().label(
                                      TextStyler().fontSize(overrideSize),
                                    ),
                            ),
                          ],
                          style: style,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
          await tester.pumpAndSettle();
          final expectedSize = brightness == Brightness.dark ? 24.0 : 12.0;
          expect(resolvedRootSize, expectedSize);
          await tester.tap(find.text('Options'));
          await tester.pumpAndSettle();
          final text = tester.widget<RichText>(
            find.descendant(
              of: find.text('Copy'),
              matching: find.byType(RichText),
            ),
          );
          expect(text.text.style?.fontSize, overrideSize ?? expectedSize);
        },
      );
    }
  }
}
