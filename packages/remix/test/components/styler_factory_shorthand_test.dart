import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('generated Remix styler factories', () {
    test('support contextual shorthand for widget-state variants', () {
      final style = ButtonStyler()
          .onHovered(.color(Colors.green))
          .onPressed(.scale(0.97));

      expect(style.$variants, hasLength(2));
    });

    test('match their fluent methods', () {
      expect(CardStyler.color(Colors.blue), CardStyler().color(Colors.blue));
      expect(SpinnerStyler.size(20), SpinnerStyler().size(20));
      expect(ButtonStyler.rotate(0.25), ButtonStyler().rotate(0.25));
      expect(
        ToggleGroupStyler.color(Colors.blue),
        ToggleGroupStyler().color(Colors.blue),
      );
      expect(
        PopoverStyler.color(Colors.purple),
        PopoverStyler().color(Colors.purple),
      );
    });

    test('forward a restricted Box surface from Select menuContainer', () {
      expect(
        SelectStyler.color(Colors.white),
        SelectStyler().color(Colors.white),
      );
    });

    test('match field factories with fluent methods', () {
      final trigger = MenuTriggerStyler.color(Colors.black);

      expect(MenuStyler.trigger(trigger), MenuStyler().trigger(trigger));

      final layout = FlexBoxStyler.spacing(12);
      expect(TextFieldStyler.layout(layout), TextFieldStyler().layout(layout));
    });

    test('support canonical color factory and fluent forms', () {
      expect(CardStyler().color(Colors.red), CardStyler.color(Colors.red));
    });

    test('support contextual shorthand for selected state', () {
      final style = ToggleGroupItemStyler().onSelected(.color(Colors.green));

      expect(style.$variants, hasLength(1));
    });

    test('match slot conveniences with nested factories', () {
      const color = Colors.indigo;
      final padding = EdgeInsetsGeometryMix.all(12);
      final textStyle = TextStyleMix(fontSize: 14);

      expect(CardStyler().color(color), CardStyler.color(color));
      expect(
        AccordionStyler().titleColor(color),
        AccordionStyler.title(TextStyler.color(color)),
      );
      expect(
        AccordionStyler().leadingIconSize(16),
        AccordionStyler.leadingIcon(IconStyler.size(16)),
      );
      expect(
        AccordionStyler().contentPadding(padding),
        AccordionStyler.content(BoxStyler.padding(padding)),
      );
      expect(AvatarStyler().size(24, 24), AvatarStyler.size(24, 24));
      expect(
        BadgeStyler().labelColor(color),
        BadgeStyler.label(TextStyler.color(color)),
      );
      expect(
        CalloutStyler().contentTextStyle(textStyle),
        CalloutStyler.text(TextStyler(style: textStyle)),
      );

      final contextual = AccordionStyler()
          .onHovered(.title(.color(color)))
          .onPressed(.content(.padding(padding)));
      expect(contextual.$variants, hasLength(2));
    });

    testWidgets('resolve forwarded APIs to their nested specs', (tester) async {
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

      void expectSameSpec<S extends Spec<S>>(Style<S> actual, Style<S> nested) {
        expect(
          actual.resolve(context).spec,
          equals(nested.resolve(context).spec),
        );
      }

      final padding = EdgeInsetsGeometryMix.all(12);
      final radius = BorderRadiusGeometryMix.circular(8);

      expectSameSpec(
        CardStyler().padding(padding).color(Colors.blue).borderRadius(radius),
        CardStyler(
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
        ButtonStyler().padding(padding).color(Colors.blue).spacing(8),
        ButtonStyler(
          container: FlexBoxStyler(
            padding: padding,
            decoration: BoxDecorationMix(color: Colors.blue),
            spacing: 8,
          ),
        ),
      );
      expectSameSpec(
        SliderStyler().size(20, 20).color(Colors.blue),
        SliderStyler(
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
        SelectStyler().padding(padding).color(Colors.white),
        SelectStyler(
          menuContainer: FlexBoxStyler(
            padding: padding,
            decoration: BoxDecorationMix(color: Colors.white),
          ),
        ),
      );
      expectSameSpec(
        TextFieldStyler().color(Colors.white).textColor(Colors.black),
        TextFieldStyler(
          container: BoxStyler(
            decoration: BoxDecorationMix(color: Colors.white),
          ),
          text: TextStyler(style: TextStyleMix(color: Colors.black)),
        ),
      );
      expectSameSpec(
        ToggleGroupStyler().padding(padding).color(Colors.blue).spacing(4),
        ToggleGroupStyler(
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
