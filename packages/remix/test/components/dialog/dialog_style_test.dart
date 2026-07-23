import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_methods.dart';

void main() {
  group('RemixDialogStyler', () {
    group('Constructors', () {
      test('default constructor creates valid instance', () {
        const style = RemixDialogStyler.create();
        expect(style, isNotNull);
        expect(style, isA<RemixDialogStyler>());
      });

      test('create constructor with all parameters', () {
        final container = Prop.maybeMix(BoxStyler());
        final title = Prop.maybeMix(TextStyler());
        final description = Prop.maybeMix(TextStyler());
        final actions = Prop.maybeMix(FlexBoxStyler());

        final style = RemixDialogStyler.create(
          container: container,
          title: title,
          description: description,
          actions: actions,
        );

        expect(style, isNotNull);
        expect(style, isA<RemixDialogStyler>());
      });

      test('constructor with styler parameters', () {
        final style = RemixDialogStyler(
          container: BoxStyler(padding: EdgeInsetsGeometryMix.all(24.0)),
          title: TextStyler(style: TextStyleMix(color: Colors.blue)),
          description: TextStyler(style: TextStyleMix(color: Colors.grey)),
          actions: FlexBoxStyler(spacing: 8.0),
        );

        expect(style, isNotNull);
        expect(style, isA<RemixDialogStyler>());
      });
    });

    group('Style Methods', () {
      styleMethodTest(
        'title sets title text styler',
        initial: RemixDialogStyler(),
        modify: (style) =>
            style.title(TextStyler(style: TextStyleMix(color: Colors.red))),
        expect: (style) {
          expect(
            style.$title,
            equals(
              Prop.maybeMix(TextStyler(style: TextStyleMix(color: Colors.red))),
            ),
          );
        },
      );

      styleMethodTest(
        'description sets description text styler',
        initial: RemixDialogStyler(),
        modify: (style) => style.description(
          TextStyler(style: TextStyleMix(color: Colors.green)),
        ),
        expect: (style) {
          expect(
            style.$description,
            equals(
              Prop.maybeMix(
                TextStyler(style: TextStyleMix(color: Colors.green)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'actions sets actions flex box styler',
        initial: RemixDialogStyler(),
        modify: (style) => style.actions(FlexBoxStyler(spacing: 12.0)),
        expect: (style) {
          expect(
            style.$actions,
            equals(Prop.maybeMix(FlexBoxStyler(spacing: 12.0))),
          );
        },
      );

      styleMethodTest(
        'alignment sets container alignment',
        initial: RemixDialogStyler(),
        modify: (style) => style.alignment(Alignment.centerRight),
        expect: (style) {
          expect(
            style,
            equals(RemixDialogStyler.alignment(Alignment.centerRight)),
          );
        },
      );

      styleMethodTest(
        'padding sets container padding',
        initial: RemixDialogStyler(),
        modify: (style) => style.padding(EdgeInsetsGeometryMix.all(24.0)),
        expect: (style) {
          expect(
            style,
            equals(RemixDialogStyler.padding(EdgeInsetsGeometryMix.all(24.0))),
          );
        },
      );

      styleMethodTest(
        'backgroundColor sets container background color',
        initial: RemixDialogStyler(),
        modify: (style) => style.backgroundColor(Colors.white),
        expect: (style) {
          expect(
            style.$container,
            equals(
              Prop.maybeMix(
                BoxStyler(decoration: BoxDecorationMix(color: Colors.white)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'size sets container size constraints',
        initial: RemixDialogStyler(),
        modify: (style) => style.size(400.0, 300.0),
        expect: (style) {
          expect(style, equals(RemixDialogStyler.size(400.0, 300.0)));
        },
      );

      styleMethodTest(
        'borderRadius sets container border radius',
        initial: RemixDialogStyler(),
        modify: (style) =>
            style.borderRadius(BorderRadiusGeometryMix.circular(16.0)),
        expect: (style) {
          expect(
            style,
            equals(
              RemixDialogStyler.borderRadius(
                BorderRadiusGeometryMix.circular(16.0),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'constraints sets container constraints',
        initial: RemixDialogStyler(),
        modify: (style) => style.constraints(
          BoxConstraintsMix(minWidth: 300.0, minHeight: 200.0),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              RemixDialogStyler.constraints(
                BoxConstraintsMix(minWidth: 300.0, minHeight: 200.0),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'decoration sets container decoration',
        initial: RemixDialogStyler(),
        modify: (style) => style.decoration(
          BoxDecorationMix(
            color: Colors.blue,
            borderRadius: BorderRadiusGeometryMix.circular(12.0),
          ),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              RemixDialogStyler.decoration(
                BoxDecorationMix(
                  color: Colors.blue,
                  borderRadius: BorderRadiusGeometryMix.circular(12.0),
                ),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'margin sets container margin',
        initial: RemixDialogStyler(),
        modify: (style) => style.margin(EdgeInsetsGeometryMix.all(16.0)),
        expect: (style) {
          expect(
            style,
            equals(RemixDialogStyler.margin(EdgeInsetsGeometryMix.all(16.0))),
          );
        },
      );

      styleMethodTest(
        'foregroundDecoration sets foreground decoration',
        initial: RemixDialogStyler(),
        modify: (style) => style.foregroundDecoration(
          BoxDecorationMix(color: Colors.yellow.withValues(alpha: 0.3)),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              RemixDialogStyler.foregroundDecoration(
                BoxDecorationMix(color: Colors.yellow.withValues(alpha: 0.3)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'transform sets container transform',
        initial: RemixDialogStyler(),
        modify: (style) => style.transform(Matrix4.rotationZ(0.1)),
        expect: (style) {
          expect(
            style,
            equals(RemixDialogStyler.transform(Matrix4.rotationZ(0.1))),
          );
        },
      );

      styleMethodTest(
        'variants sets variant styles',
        initial: RemixDialogStyler(),
        modify: (style) => style.variants([]),
        expect: (style) {
          expect(style.$variants, equals([]));
        },
      );

      styleMethodTest(
        'wrap sets widget modifier config',
        initial: RemixDialogStyler(),
        modify: (style) => style.wrap(WidgetModifierConfig()),
        expect: (style) {
          expect(style.$modifier, equals(WidgetModifierConfig()));
        },
      );

      styleMethodTest(
        'animate sets animation config',
        initial: RemixDialogStyler(),
        modify: (style) =>
            style.animate(AnimationConfig.linear(Duration(milliseconds: 300))),
        expect: (style) {
          expect(
            style.$animation,
            equals(AnimationConfig.linear(Duration(milliseconds: 300))),
          );
        },
      );
    });

    group('Core Methods', () {
      testWidgets('resolve method returns StyleSpec', (tester) async {
        const style = RemixDialogStyler.create();
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final spec = style.resolve(context);
                expect(spec, isA<StyleSpec<RemixDialogSpec>>());
                expect(spec.spec, isA<RemixDialogSpec>());
                return Container();
              },
            ),
          ),
        );
      });

      test('merge with null returns style equal to original', () {
        const originalStyle = RemixDialogStyler.create();
        final mergedStyle = originalStyle.merge(null);
        expect(mergedStyle, equals(originalStyle));
      });

      test('merge with other style combines properties', () {
        const style1 = RemixDialogStyler.create();
        final style2 = RemixDialogStyler();

        final merged = style1.merge(style2);
        expect(merged, isNot(same(style1)));
        expect(merged, isNot(same(style2)));
        expect(merged, isA<RemixDialogStyler>());
      });

      test('call creates RemixDialog with this style', () {
        final style = RemixDialogStyler().backgroundColor(Colors.white);

        final dialog = style.call(
          title: 'Confirm',
          description: 'Continue?',
          actions: const [Text('OK')],
          modal: false,
          semanticLabel: 'Confirmation dialog',
        );

        expect(dialog, isA<RemixDialog>());
        expect(dialog.style, same(style));
        expect(dialog.title, 'Confirm');
        expect(dialog.description, 'Continue?');
        expect(dialog.actions, hasLength(1));
        expect(dialog.modal, isFalse);
        expect(dialog.semanticLabel, 'Confirmation dialog');
      });

      test('props list contains all properties', () {
        const style = RemixDialogStyler.create();
        expect(style.props, hasLength(8));
        expect(style.props, contains(style.$container));
        expect(style.props, contains(style.$title));
        expect(style.props, contains(style.$description));
        expect(style.props, contains(style.$actions));
        expect(style.props, contains(style.$variants));
        expect(style.props, contains(style.$animation));
        expect(style.props, contains(style.$modifier));
      });
    });

    group('Equality', () {
      test('identical styles are equal', () {
        const style1 = RemixDialogStyler.create();
        const style2 = RemixDialogStyler.create();
        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });

      test('styles with different properties are not equal', () {
        const style1 = RemixDialogStyler.create();
        final style2 = RemixDialogStyler();
        expect(style1, equals(style2));
      });

      test('styles with same properties are equal', () {
        final style1 = RemixDialogStyler();
        final style2 = RemixDialogStyler();
        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });
    });
  });
}
