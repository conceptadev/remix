import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('generated Remix styler factories', () {
    test('support contextual shorthand for widget-state variants', () {
      final style = RemixButtonStyler()
          .onHovered(.color(Colors.green))
          .onPressed(.scale(0.97));

      expect(style.$variants, hasLength(2));
    });

    test('match their fluent methods', () {
      expect(
        RemixCardStyler.color(Colors.blue),
        RemixCardStyler().color(Colors.blue),
      );
      expect(RemixSpinnerStyler.size(20), RemixSpinnerStyler().size(20));
      expect(RemixButtonStyler.rotate(0.25), RemixButtonStyler().rotate(0.25));
      expect(
        RemixToggleGroupStyler.color(Colors.blue),
        RemixToggleGroupStyler().color(Colors.blue),
      );
      expect(
        RemixPopoverStyler.color(Colors.purple),
        RemixPopoverStyler().color(Colors.purple),
      );
    });

    test('forward a restricted Box surface from Select content', () {
      expect(
        RemixSelectContentStyler.color(Colors.white),
        RemixSelectContentStyler().color(Colors.white),
      );
    });

    test('retain field factories for composite stylers', () {
      final item = RemixMenuItemStyler.color(Colors.black);

      expect(RemixMenuStyler.item(item), RemixMenuStyler().item(item));

      final layout = FlexBoxStyler.spacing(12);
      expect(
        RemixTextFieldStyler.layout(layout),
        RemixTextFieldStyler().layout(layout),
      );
    });

    test('retain fluent-only conveniences and aliases', () {
      expect(
        RemixCardStyler().paddingAll(12),
        RemixCardStyler.padding(EdgeInsetsGeometryMix.all(12)),
      );
      expect(
        RemixCardStyler().backgroundColor(Colors.red),
        RemixCardStyler.color(Colors.red),
      );
    });

    test('support contextual shorthand for selected state', () {
      final style = RemixToggleGroupItemStyler().onSelected(
        .color(Colors.green),
      );

      expect(style.$variants, hasLength(1));
    });

    test('replace legacy convenience factories with canonical factories', () {
      const color = Colors.indigo;
      final padding = EdgeInsetsGeometryMix.all(12);
      final textStyle = TextStyleMix(fontSize: 14);

      expect(
        RemixCardStyler().backgroundColor(color),
        RemixCardStyler.color(color),
      );
      expect(
        RemixAccordionStyler().titleColor(color),
        RemixAccordionStyler.title(TextStyler.color(color)),
      );
      expect(
        RemixAccordionStyler().leadingIconSize(16),
        RemixAccordionStyler.leadingIcon(IconStyler.size(16)),
      );
      expect(
        RemixAccordionStyler().contentPadding(padding),
        RemixAccordionStyler.content(BoxStyler.padding(padding)),
      );
      expect(RemixAvatarStyler().square(24), RemixAvatarStyler.size(24, 24));
      expect(
        RemixBadgeStyler().foregroundColor(color),
        RemixBadgeStyler.label(TextStyler.color(color)),
      );
      expect(
        RemixCalloutStyler().contentTextStyle(textStyle),
        RemixCalloutStyler.text(TextStyler(style: textStyle)),
      );

      final contextual = RemixAccordionStyler()
          .onHovered(.title(.color(color)))
          .onPressed(.content(.padding(padding)));
      expect(contextual.$variants, hasLength(2));
    });

    testWidgets('resolve forwarded APIs like legacy nested styles', (
      tester,
    ) async {
      late BuildContext context;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (builderContext) {
              context = builderContext;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      void expectSameSpec<S extends Spec<S>>(Style<S> actual, Style<S> legacy) {
        expect(
          actual.resolve(context).spec,
          equals(legacy.resolve(context).spec),
        );
      }

      final padding = EdgeInsetsGeometryMix.all(12);
      final radius = BorderRadiusGeometryMix.circular(8);

      expectSameSpec(
        RemixCardStyler()
            .padding(padding)
            .color(Colors.blue)
            .borderRadius(radius),
        RemixCardStyler(
          container: BoxStyler(
            padding: padding,
            decoration: BoxDecorationMix(
              color: Colors.blue,
              borderRadius: radius,
            ),
          ),
        ),
      );
      expectSameSpec(
        RemixButtonStyler().padding(padding).color(Colors.blue).spacing(8),
        RemixButtonStyler(
          container: FlexBoxStyler(
            padding: padding,
            decoration: BoxDecorationMix(color: Colors.blue),
            spacing: 8,
          ),
        ),
      );
      expectSameSpec(
        RemixSliderStyler().size(20, 20).color(Colors.blue),
        RemixSliderStyler(
          thumb: BoxStyler(
            constraints: BoxConstraintsMix(
              minWidth: 20,
              maxWidth: 20,
              minHeight: 20,
              maxHeight: 20,
            ),
            decoration: BoxDecorationMix(color: Colors.blue),
          ),
        ),
      );
      expectSameSpec(
        RemixSelectStyler().content(
          RemixSelectContentStyler().padding(padding).color(Colors.white),
        ),
        RemixSelectStyler(
          content: RemixSelectContentStyler(
            container: BoxStyler(
              padding: padding,
              decoration: BoxDecorationMix(color: Colors.white),
            ),
          ),
        ),
      );
      expectSameSpec(
        RemixTextFieldStyler().color(Colors.white).textColor(Colors.black),
        RemixTextFieldStyler(
          container: FlexBoxStyler(
            decoration: BoxDecorationMix(color: Colors.white),
          ),
          text: TextStyler(style: TextStyleMix(color: Colors.black)),
        ),
      );
      expectSameSpec(
        RemixToggleGroupStyler().padding(padding).color(Colors.blue).spacing(4),
        RemixToggleGroupStyler(
          container: FlexBoxStyler(
            padding: padding,
            decoration: BoxDecorationMix(color: Colors.blue),
            spacing: 4,
          ),
        ),
      );
    });
  });
}
