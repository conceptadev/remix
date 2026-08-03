import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_methods.dart';

void main() {
  group('CheckboxStyler', () {
    group('Constructors', () {
      test('default constructor creates valid instance', () {
        const style = CheckboxStyler.create();
        expect(style, isNotNull);
        expect(style, isA<CheckboxStyler>());
      });

      test('create constructor with all parameters', () {
        final container = Prop.maybeMix(BoxStyler());
        final indicator = Prop.maybeMix(IconStyler());

        final style = CheckboxStyler.create(
          container: container,
          indicator: indicator,
        );

        expect(style, isNotNull);
        expect(style, isA<CheckboxStyler>());
      });

      test('constructor with styler parameters', () {
        final style = CheckboxStyler(
          container: BoxStyler(padding: EdgeInsetsGeometryMix.all(4.0)),
          indicator: IconStyler(color: Colors.blue),
        );

        expect(style, isNotNull);
        expect(style, isA<CheckboxStyler>());
      });
    });

    group('Style Methods', () {
      styleMethodTest(
        'shape sets container shape',
        initial: CheckboxStyler(),
        modify: (style) => style.shape(
          RoundedRectangleBorderMix(
            borderRadius: BorderRadiusMix.circular(8.0),
          ),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              CheckboxStyler.shape(
                RoundedRectangleBorderMix(
                  borderRadius: BorderRadiusMix.circular(8.0),
                ),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'border sets container border',
        initial: CheckboxStyler(),
        modify: (style) =>
            style.border(BoxBorderMix.all(BorderSideMix(color: Colors.grey))),
        expect: (style) {
          expect(
            style,
            equals(
              CheckboxStyler.border(
                BoxBorderMix.all(BorderSideMix(color: Colors.grey)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'indicatorColor sets indicator color',
        initial: CheckboxStyler(),
        modify: (style) => style.indicatorColor(Colors.green),
        expect: (style) {
          expect(
            style.$indicator,
            equals(Prop.maybeMix(IconStyler(color: Colors.green))),
          );
        },
      );

      styleMethodTest(
        'alignment sets container alignment',
        initial: CheckboxStyler(),
        modify: (style) => style.alignment(Alignment.centerLeft),
        expect: (style) {
          expect(style, equals(CheckboxStyler.alignment(Alignment.centerLeft)));
        },
      );

      styleMethodTest(
        'icon sets indicator icon styler',
        initial: CheckboxStyler(),
        modify: (style) => style.icon(IconStyler(size: 16.0)),
        expect: (style) {
          expect(
            style.$indicator,
            equals(Prop.maybeMix(IconStyler(size: 16.0))),
          );
        },
      );

      styleMethodTest(
        'padding sets container padding',
        initial: CheckboxStyler(),
        modify: (style) => style.padding(EdgeInsetsGeometryMix.all(8.0)),
        expect: (style) {
          expect(
            style,
            equals(CheckboxStyler.padding(EdgeInsetsGeometryMix.all(8.0))),
          );
        },
      );

      styleMethodTest(
        'fillColor sets container background color',
        initial: CheckboxStyler(),
        modify: (style) => style.fillColor(Colors.blue),
        expect: (style) {
          expect(
            style.$container,
            equals(
              Prop.maybeMix(
                BoxStyler(decoration: BoxDecorationMix(color: Colors.blue)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'size sets container size with width and height',
        initial: CheckboxStyler(),
        modify: (style) => style.size(20.0, 20.0),
        expect: (style) {
          expect(style, equals(CheckboxStyler.size(20.0, 20.0)));
        },
      );

      styleMethodTest(
        'borderRadius sets container border radius',
        initial: CheckboxStyler(),
        modify: (style) =>
            style.borderRadius(BorderRadiusGeometryMix.circular(6.0)),
        expect: (style) {
          expect(
            style,
            equals(
              CheckboxStyler.borderRadius(
                BorderRadiusGeometryMix.circular(6.0),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'animate sets animation config',
        initial: CheckboxStyler(),
        modify: (style) =>
            style.animate(AnimationConfig.linear(Duration(milliseconds: 200))),
        expect: (style) {
          expect(
            style.$animation,
            equals(AnimationConfig.linear(Duration(milliseconds: 200))),
          );
        },
      );

      styleMethodTest(
        'variants sets variant styles',
        initial: CheckboxStyler(),
        modify: (style) => style.variants([]),
        expect: (style) {
          expect(style.$variants, equals([]));
        },
      );

      styleMethodTest(
        'wrap sets widget modifier config',
        initial: CheckboxStyler(),
        modify: (style) => style.wrap(WidgetModifierConfig()),
        expect: (style) {
          expect(style.$modifier, equals(WidgetModifierConfig()));
        },
      );

      styleMethodTest(
        'constraints sets container constraints',
        initial: CheckboxStyler(),
        modify: (style) => style.constraints(
          BoxConstraintsMix(minWidth: 18.0, minHeight: 18.0),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              CheckboxStyler.constraints(
                BoxConstraintsMix(minWidth: 18.0, minHeight: 18.0),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'decoration sets container decoration',
        initial: CheckboxStyler(),
        modify: (style) => style.decoration(
          BoxDecorationMix(
            color: Colors.lightBlue,
            borderRadius: BorderRadiusGeometryMix.circular(4.0),
          ),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              CheckboxStyler.decoration(
                BoxDecorationMix(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadiusGeometryMix.circular(4.0),
                ),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'margin sets container margin',
        initial: CheckboxStyler(),
        modify: (style) => style.margin(EdgeInsetsGeometryMix.all(4.0)),
        expect: (style) {
          expect(
            style,
            equals(CheckboxStyler.margin(EdgeInsetsGeometryMix.all(4.0))),
          );
        },
      );

      styleMethodTest(
        'foregroundDecoration sets foreground decoration',
        initial: CheckboxStyler(),
        modify: (style) => style.foregroundDecoration(
          BoxDecorationMix(color: Colors.yellow.withValues(alpha: 0.3)),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              CheckboxStyler.foregroundDecoration(
                BoxDecorationMix(color: Colors.yellow.withValues(alpha: 0.3)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'transform sets container transform',
        initial: CheckboxStyler(),
        modify: (style) => style.transform(Matrix4.rotationZ(0.1)),
        expect: (style) {
          expect(
            style,
            equals(CheckboxStyler.transform(Matrix4.rotationZ(0.1))),
          );
        },
      );
    });

    group('Core Methods', () {
      testWidgets('resolve method returns StyleSpec', (tester) async {
        const style = CheckboxStyler.create();
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final spec = style.resolve(context);
                expect(spec, isA<StyleSpec<CheckboxSpec>>());
                expect(spec.spec, isA<CheckboxSpec>());
                return Container();
              },
            ),
          ),
        );
      });

      test('merge with null returns style equal to original', () {
        const originalStyle = CheckboxStyler.create();
        final mergedStyle = originalStyle.merge(null);
        expect(mergedStyle, equals(originalStyle));
      });

      test('merge with other style combines properties', () {
        final style1 = CheckboxStyler.create();
        final style2 = CheckboxStyler();

        final merged = style1.merge(style2);
        expect(merged, isNot(same(style1)));
        expect(merged, isNot(same(style2)));
        expect(merged, isA<CheckboxStyler>());
      });

      test('props list contains all properties', () {
        const style = CheckboxStyler.create();
        expect(style.props, hasLength(6));
        expect(style.props, contains(style.$container));
        expect(style.props, contains(style.$indicator));
        expect(style.props, contains(style.$variants));
        expect(style.props, contains(style.$animation));
        expect(style.props, contains(style.$modifier));
      });
    });

    group('Call Method', () {
      testWidgets('call method creates RemixCheckbox with all parameters', (
        tester,
      ) async {
        final style = CheckboxStyler().fillColor(Colors.blue);
        final focusNode = FocusNode();

        final checkbox = style.call(
          selected: true,
          onChanged: (value) {},
          enabled: false,
          tristate: true,
          autofocus: true,
          checkedIcon: Icons.check_circle,
          uncheckedIcon: Icons.circle_outlined,
          indeterminateIcon: Icons.remove,
          enableFeedback: false,
          focusNode: focusNode,
          semanticLabel: 'Test Checkbox',
          mouseCursor: SystemMouseCursors.forbidden,
        );

        expect(checkbox, isA<RemixCheckbox>());
        expect(checkbox.selected, equals(true));
        expect(checkbox.enabled, equals(false));
        expect(checkbox.tristate, equals(true));
        expect(checkbox.autofocus, equals(true));
        expect(checkbox.checkedIcon, equals(Icons.check_circle));
        expect(checkbox.uncheckedIcon, equals(Icons.circle_outlined));
        expect(checkbox.indeterminateIcon, equals(Icons.remove));
        expect(checkbox.enableFeedback, equals(false));
        expect(checkbox.focusNode, same(focusNode));
        expect(checkbox.semanticLabel, equals('Test Checkbox'));
        expect(checkbox.mouseCursor, equals(SystemMouseCursors.forbidden));
        expect(checkbox.style, same(style));

        focusNode.dispose();
      });

      testWidgets('call method creates RemixCheckbox with minimal parameters', (
        tester,
      ) async {
        final style = CheckboxStyler();

        final checkbox = style.call(selected: false);

        expect(checkbox, isA<RemixCheckbox>());
        expect(checkbox.selected, equals(false));
        expect(checkbox.enabled, equals(true));
        expect(checkbox.tristate, equals(false));
        expect(checkbox.style, same(style));
      });
    });

    group('Equality', () {
      test('identical styles are equal', () {
        const style1 = CheckboxStyler.create();
        const style2 = CheckboxStyler.create();
        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });

      test('styles with different properties are not equal', () {
        const style1 = CheckboxStyler.create();
        final style2 = CheckboxStyler();
        expect(style1, equals(style2));
      });

      test('styles with same properties are equal', () {
        final style1 = CheckboxStyler();
        final style2 = CheckboxStyler();
        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });
    });
  });
}
