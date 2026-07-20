import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';
import '../../helpers/test_methods.dart';

void main() {
  group('ButtonStyler', () {
    group('Constructors', () {
      test('default constructor creates valid instance', () {
        final style = ButtonStyler();

        expect(style, isNotNull);
        expect(style, isA<ButtonStyler>());
      });

      test('create constructor with all parameters', () {
        final container = Prop.maybeMix(FlexBoxStyler());
        final label = Prop.maybeMix(TextStyler());
        final icon = Prop.maybeMix(IconStyler());
        final spinner = Prop.maybeMix(RemixSpinnerStyler());
        final variants = <VariantStyle<RemixButtonSpec>>[];

        final style = ButtonStyler.create(
          container: container,
          label: label,
          icon: icon,
          spinner: spinner,
          variants: variants,
        );

        expect(style, isNotNull);
        expect(style.$container, equals(container));
        expect(style.$label, equals(label));
        expect(style.$icon, equals(icon));
        expect(style.$spinner, equals(spinner));
        expect(style.$variants, equals(variants));
      });

      test('constructor with styler parameters', () {
        final containerStyler = FlexBoxStyler();
        final labelStyler = TextStyler();
        final iconStyler = IconStyler();
        final spinnerStyle = RemixSpinnerStyler();

        final style = ButtonStyler()
            .container(containerStyler)
            .label(labelStyler)
            .icon(iconStyler)
            .spinner(spinnerStyle);

        expect(style, isNotNull);
        expect(style.$container, isNotNull);
        expect(style.$label, isNotNull);
        expect(style.$icon, isNotNull);
        expect(style.$spinner, isNotNull);
      });

      test('shadow factory applies shadow style', () {
        final shadow = BoxShadowMix().color(Colors.black).blurRadius(4.0);
        final style = ButtonStyler().shadow(shadow);

        expect(style, equals(ButtonStyler.shadow(shadow)));
      });
    });

    group('Style Methods', () {
      styleMethodTest(
        'label',
        initial: ButtonStyler(),
        modify: (style) => style.label(TextStyler()),
        expect: (style) {
          expect(style.$label, Prop.maybeMix(TextStyler()));
        },
      );

      styleMethodTest(
        'icon',
        initial: ButtonStyler(),
        modify: (style) => style.icon(IconStyler()),
        expect: (style) {
          expect(style.$icon, equals(Prop.maybeMix(IconStyler())));
        },
      );

      styleMethodTest(
        'spinner',
        initial: ButtonStyler(),
        modify: (style) => style.spinner(RemixSpinnerStyler()),
        expect: (style) {
          expect(style.$spinner, equals(Prop.maybeMix(RemixSpinnerStyler())));
        },
      );

      styleMethodTest(
        'padding',
        initial: ButtonStyler(),
        modify: (style) => style.padding(EdgeInsetsGeometryMix.all(16.0)),
        expect: (style) {
          expect(
            style,
            equals(ButtonStyler.padding(EdgeInsetsGeometryMix.all(16.0))),
          );
        },
      );

      styleMethodTest(
        'margin',
        initial: ButtonStyler(),
        modify: (style) => style.margin(EdgeInsetsGeometryMix.all(8.0)),
        expect: (style) {
          expect(
            style,
            equals(ButtonStyler.margin(EdgeInsetsGeometryMix.all(8.0))),
          );
        },
      );

      styleMethodTest(
        'decoration',
        initial: ButtonStyler(),
        modify: (style) => style.decoration(
          BoxDecorationMix(
            color: Colors.blue,
            borderRadius: BorderRadiusMix.circular(8.0),
          ),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              ButtonStyler.decoration(
                BoxDecorationMix(
                  color: Colors.blue,
                  borderRadius: BorderRadiusMix.circular(8.0),
                ),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'alignment',
        initial: ButtonStyler(),
        modify: (style) => style.alignment(Alignment.centerLeft),
        expect: (style) {
          expect(style, equals(ButtonStyler.alignment(Alignment.centerLeft)));
        },
      );

      styleMethodTest(
        'spacing',
        initial: ButtonStyler(),
        modify: (style) => style.spacing(12.0),
        expect: (style) {
          expect(style, equals(ButtonStyler.spacing(12.0)));
        },
      );

      styleMethodTest(
        'constraints',
        initial: ButtonStyler(),
        modify: (style) => style.constraints(
          BoxConstraintsMix(minWidth: 100.0, minHeight: 40.0),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              ButtonStyler.constraints(
                BoxConstraintsMix(minWidth: 100.0, minHeight: 40.0),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'variants',
        initial: ButtonStyler(),
        modify: (style) => style.variants(<VariantStyle<RemixButtonSpec>>[]),
        expect: (style) {
          expect(style.$variants, equals(<VariantStyle<RemixButtonSpec>>[]));
        },
      );
      styleMethodTest(
        'flex',
        initial: ButtonStyler(),
        modify: (style) => style.flex(FlexStyler()),
        expect: (style) {
          expect(
            style.$container,
            equals(Prop.maybeMix(FlexBoxStyler().flex(FlexStyler()))),
          );
        },
      );

      styleMethodTest(
        'foregroundDecoration',
        initial: ButtonStyler(),
        modify: (style) => style.foregroundDecoration(
          BoxDecorationMix(
            border: BoxBorderMix.all(BorderSideMix(color: Colors.red)),
          ),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              ButtonStyler.foregroundDecoration(
                BoxDecorationMix(
                  border: BoxBorderMix.all(BorderSideMix(color: Colors.red)),
                ),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'transform',
        initial: ButtonStyler(),
        modify: (style) =>
            style.transform(Matrix4.identity(), alignment: Alignment.topLeft),
        expect: (style) {
          expect(
            style,
            equals(
              ButtonStyler.transform(
                Matrix4.identity(),
                alignment: Alignment.topLeft,
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'modifierRotate',
        initial: ButtonStyler(),
        modify: (style) =>
            style.modifierRotate(0.5, alignment: Alignment.topLeft),
        expect: (style) {
          expect(
            style.$modifier,
            equals(
              WidgetModifierConfig.rotate(
                radians: 0.5,
                alignment: Alignment.topLeft,
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'scale',
        initial: ButtonStyler(),
        modify: (style) => style.scale(1.2, alignment: Alignment.topLeft),
        expect: (style) {
          expect(
            style,
            equals(ButtonStyler.scale(1.2, alignment: Alignment.topLeft)),
          );
        },
      );

      styleMethodTest(
        'translate',
        initial: ButtonStyler(),
        modify: (style) => style.translate(1.0, 2.0, 3.0),
        expect: (style) {
          expect(style, equals(ButtonStyler.translate(1.0, 2.0, 3.0)));
        },
      );

      styleMethodTest(
        'skew',
        initial: ButtonStyler(),
        modify: (style) => style.skew(0.1, 0.2),
        expect: (style) {
          expect(style, equals(ButtonStyler.skew(0.1, 0.2)));
        },
      );

      styleMethodTest(
        'transformReset',
        initial: ButtonStyler(),
        modify: (style) => style.transformReset(),
        expect: (style) {
          expect(style.$container, isNotNull);
        },
      );

      testWidgets('transform shortcut helpers resolve expected matrices', (
        tester,
      ) async {
        final scaleBox = await _resolveContainerBoxSpec(
          tester,
          ButtonStyler().scale(1.2, alignment: Alignment.topLeft),
        );
        expect(
          scaleBox.transform?.storage,
          orderedEquals(Matrix4.diagonal3Values(1.2, 1.2, 1.0).storage),
        );
        expect(scaleBox.transformAlignment, equals(Alignment.topLeft));

        final translateBox = await _resolveContainerBoxSpec(
          tester,
          ButtonStyler().translate(1.0, 2.0, 3.0),
        );
        expect(
          translateBox.transform?.storage,
          orderedEquals(Matrix4.translationValues(1.0, 2.0, 3.0).storage),
        );

        final skewMatrix = Matrix4.identity()
          ..setEntry(0, 1, 0.1)
          ..setEntry(1, 0, 0.2);
        final skewBox = await _resolveContainerBoxSpec(
          tester,
          ButtonStyler().skew(0.1, 0.2),
        );
        expect(skewBox.transform?.storage, orderedEquals(skewMatrix.storage));

        final resetBox = await _resolveContainerBoxSpec(
          tester,
          ButtonStyler().transformReset(),
        );
        expect(
          resetBox.transform?.storage,
          orderedEquals(Matrix4.identity().storage),
        );
      });

      styleMethodTest(
        'color',
        initial: ButtonStyler(),
        modify: (style) => style.color(Colors.blue),
        expect: (style) {
          expect(style, equals(ButtonStyler.color(Colors.blue)));
        },
      );

      styleMethodTest(
        'wrap',
        initial: ButtonStyler(),
        modify: (style) => style.wrap(.clipOval()),
        expect: (style) {
          expect(style.$modifier, equals(WidgetModifierConfig.clipOval()));
        },
      );

      styleMethodTest(
        'inherited spacing helpers',
        initial: ButtonStyler(),
        modify: (style) => style.paddingStart(4.0).marginEnd(8.0),
        expect: (style) {
          expect(style.$container, isNotNull);
        },
      );

      styleMethodTest(
        'inherited border helpers',
        initial: ButtonStyler(),
        modify: (style) => style.borderTop(color: Colors.red, width: 2.0),
        expect: (style) {
          expect(
            style.$container,
            equals(
              Prop.maybeMix(
                FlexBoxStyler().borderTop(color: Colors.red, width: 2.0),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'inherited shape and constraint helpers',
        initial: ButtonStyler(),
        modify: (style) => style.shapeStadium().minHeight(32.0),
        expect: (style) {
          expect(style.$container, isNotNull);
        },
      );
    });

    group('Call Method', () {
      test('call method creates RemixButton with minimal parameters', () {
        final style = ButtonStyler();

        const child = Text('Test Button');
        final button = style.call(child: child);

        expect(button, isA<RemixButton>());
        expect(button.child, same(child));
        expect(button.onPressed, isNull);
      });

      test('call method creates RemixButton with all parameters', () {
        final style = ButtonStyler();
        final focusNode = FocusNode();

        const child = Row(children: [Icon(Icons.star), Text('Test Button')]);
        final button = style.call(
          child: child,
          loading: true,
          enabled: false,
          enableFeedback: false,
          onPressed: () {},
          focusNode: focusNode,
        );

        expect(button, isA<RemixButton>());
        expect(button.child, same(child));
        expect(button.loading, isTrue);
        expect(button.enabled, isFalse);
        expect(button.enableFeedback, isFalse);
        expect(button.onPressed, isNotNull);
        expect(button.focusNode, equals(focusNode));
      });
    });

    group('Core Methods', () {
      testWidgets('resolve method returns StyleSpec', (
        WidgetTester tester,
      ) async {
        final style = ButtonStyler();

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final spec = style.resolve(context);

                expect(spec, isA<StyleSpec<RemixButtonSpec>>());
                expect(spec.spec, isA<RemixButtonSpec>());
                expect(spec.spec.container, isA<StyleSpec<FlexBoxSpec>>());
                expect(spec.spec.label, isA<StyleSpec<TextSpec>>());
                expect(spec.spec.icon, isA<StyleSpec<IconSpec>>());
                expect(spec.spec.spinner, isA<StyleSpec<RemixSpinnerSpec>>());

                return Container();
              },
            ),
          ),
        );
      });

      test('merge with null returns style equal to original', () {
        final originalStyle = ButtonStyler();

        final mergedStyle = originalStyle.merge(null);

        expect(mergedStyle, equals(originalStyle));
      });
    });

    group('Equality', () {
      test('identical styles are equal', () {
        final style1 = ButtonStyler();
        final style2 = ButtonStyler();

        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });

      test('styles with different properties are not equal', () {
        final style1 = ButtonStyler().padding(EdgeInsetsGeometryMix.all(16.0));
        final style2 = ButtonStyler().padding(EdgeInsetsGeometryMix.all(8.0));

        expect(style1, isNot(equals(style2)));
      });
    });
  });

  group('FortalButton recipe', () {
    test('defaults to solid variant and size2', () {
      expect(
        fortalButtonStyler(),
        equals(fortalButtonStyler(variant: .solid, size: .size2)),
      );
    });

    testWidgets('high contrast selects the stronger button roles', (
      tester,
    ) async {
      final solid = await _resolveFortalButtonStyle(
        tester,
        fortalButtonStyler(),
      );
      final highContrastSolid = await _resolveFortalButtonStyle(
        tester,
        fortalButtonStyler(highContrast: true),
      );

      expect(solid.spec.surface?.color, indigo.light.scale.step(9));
      expect(
        highContrastSolid.spec.surface?.color,
        indigo.light.scale.step(12),
      );
      expect(solid.spec.label.spec.style?.color, Colors.white);
      expect(
        highContrastSolid.spec.label.spec.style?.color,
        slate.light.scale.step(1),
      );

      for (final variant in FortalButtonVariant.values.where(
        (variant) => variant != .solid && variant != .classic,
      )) {
        final normal = await _resolveFortalButtonStyle(
          tester,
          fortalButtonStyler(variant: variant),
        );
        final highContrast = await _resolveFortalButtonStyle(
          tester,
          fortalButtonStyler(variant: variant, highContrast: true),
        );

        expect(
          normal.spec.label.spec.style?.color,
          indigo.light.scale.alphaStep(11),
          reason: '$variant normal foreground',
        );
        expect(
          highContrast.spec.label.spec.style?.color,
          indigo.light.scale.step(12),
          reason: '$variant high-contrast foreground',
        );
      }
    });

    for (final variant in FortalButtonVariant.values) {
      testWidgets('resolves $variant variant', (tester) async {
        final resolved = await _resolveFortalButtonStyle(
          tester,
          fortalButtonStyler(variant: variant),
        );

        expect(resolved, isA<StyleSpec<RemixButtonSpec>>());
        expect(resolved.spec, isA<RemixButtonSpec>());
      });
    }

    testWidgets('each size resolves distinct layout metrics', (tester) async {
      final resolvedBySize = <FortalButtonSize, StyleSpec<RemixButtonSpec>>{};

      for (final size in FortalButtonSize.values) {
        resolvedBySize[size] = await _resolveFortalButtonStyle(
          tester,
          fortalButtonStyler(size: size),
        );
      }

      final paddings = resolvedBySize.values
          .map((spec) => spec.spec.container.spec.box?.spec.padding)
          .toSet();
      final spacings = resolvedBySize.values
          .map((spec) => spec.spec.container.spec.flex?.spec.spacing)
          .toSet();

      expect(paddings, hasLength(FortalButtonSize.values.length));
      expect(spacings, {4.0, 8.0, 12.0});
    });
  });
}

Future<StyleSpec<RemixButtonSpec>> _resolveFortalButtonStyle(
  WidgetTester tester,
  ButtonStyler style,
) async {
  late final StyleSpec<RemixButtonSpec> resolved;

  await tester.pumpRemixApp(
    Builder(
      builder: (context) {
        resolved = style.resolve(context);

        return const SizedBox.shrink();
      },
    ),
  );

  return resolved;
}

Future<BoxSpec> _resolveContainerBoxSpec(
  WidgetTester tester,
  ButtonStyler style,
) async {
  final resolved = await _resolveFortalButtonStyle(tester, style);

  return resolved.spec.container.spec.box!.spec;
}
