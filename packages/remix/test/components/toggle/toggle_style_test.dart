import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_methods.dart';

void main() {
  group('RemixToggleStyler', () {
    group('Constructors', () {
      test('default constructor creates valid instance', () {
        final style = RemixToggleStyler();

        expect(style, isNotNull);
        expect(style, isA<RemixToggleStyler>());
      });

      test('create constructor with all parameters', () {
        final container = Prop.maybeMix(FlexBoxStyler());
        final label = Prop.maybeMix(TextStyler());
        final icon = Prop.maybeMix(IconStyler());
        final variants = <VariantStyle<RemixToggleSpec>>[];

        final style = RemixToggleStyler.create(
          container: container,
          label: label,
          icon: icon,
          variants: variants,
        );

        expect(style, isNotNull);
        expect(style.$container, equals(container));
        expect(style.$label, equals(label));
        expect(style.$icon, equals(icon));
        expect(style.$variants, equals(variants));
      });

      test('constructor with styler parameters', () {
        final containerStyler = FlexBoxStyler();
        final labelStyler = TextStyler();
        final iconStyler = IconStyler();

        final style = RemixToggleStyler(
          container: containerStyler,
          label: labelStyler,
          icon: iconStyler,
        );

        expect(style, isNotNull);
        expect(style.$container, isNotNull);
        expect(style.$label, isNotNull);
        expect(style.$icon, isNotNull);
      });
    });

    group('Style Methods', () {
      styleMethodTest(
        'label',
        initial: RemixToggleStyler(),
        modify: (style) => style.label(TextStyler()),
        expect: (style) {
          expect(style.$label, Prop.maybeMix(TextStyler()));
        },
      );

      styleMethodTest(
        'icon',
        initial: RemixToggleStyler(),
        modify: (style) => style.icon(IconStyler()),
        expect: (style) {
          expect(style.$icon, equals(Prop.maybeMix(IconStyler())));
        },
      );

      styleMethodTest(
        'alignment',
        initial: RemixToggleStyler(),
        modify: (style) => style.alignment(Alignment.centerLeft),
        expect: (style) {
          expect(
            style,
            equals(RemixToggleStyler.alignment(Alignment.centerLeft)),
          );
        },
      );

      styleMethodTest(
        'backgroundColor',
        initial: RemixToggleStyler(),
        modify: (style) => style.backgroundColor(Colors.blue),
        expect: (style) {
          expect(
            style.$container,
            equals(
              Prop.maybeMix(
                FlexBoxStyler(decoration: BoxDecorationMix(color: Colors.blue)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'padding',
        initial: RemixToggleStyler(),
        modify: (style) => style.padding(EdgeInsetsGeometryMix.all(16.0)),
        expect: (style) {
          expect(
            style,
            equals(RemixToggleStyler.padding(EdgeInsetsGeometryMix.all(16.0))),
          );
        },
      );

      styleMethodTest(
        'margin',
        initial: RemixToggleStyler(),
        modify: (style) => style.margin(EdgeInsetsGeometryMix.all(8.0)),
        expect: (style) {
          expect(
            style,
            equals(RemixToggleStyler.margin(EdgeInsetsGeometryMix.all(8.0))),
          );
        },
      );

      styleMethodTest(
        'decoration',
        initial: RemixToggleStyler(),
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
              RemixToggleStyler.decoration(
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
        'spacing',
        initial: RemixToggleStyler(),
        modify: (style) => style.spacing(12.0),
        expect: (style) {
          expect(style, equals(RemixToggleStyler.spacing(12.0)));
        },
      );

      styleMethodTest(
        'constraints',
        initial: RemixToggleStyler(),
        modify: (style) => style.constraints(
          BoxConstraintsMix(minWidth: 100.0, minHeight: 40.0),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              RemixToggleStyler.constraints(
                BoxConstraintsMix(minWidth: 100.0, minHeight: 40.0),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'foregroundDecoration',
        initial: RemixToggleStyler(),
        modify: (style) => style.foregroundDecoration(
          BoxDecorationMix(
            border: BoxBorderMix.all(BorderSideMix(color: Colors.red)),
          ),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              RemixToggleStyler.foregroundDecoration(
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
        initial: RemixToggleStyler(),
        modify: (style) =>
            style.transform(Matrix4.identity(), alignment: Alignment.topLeft),
        expect: (style) {
          expect(
            style,
            equals(
              RemixToggleStyler.transform(
                Matrix4.identity(),
                alignment: Alignment.topLeft,
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'flex',
        initial: RemixToggleStyler(),
        modify: (style) => style.flex(FlexStyler()),
        expect: (style) {
          expect(
            style.$container,
            equals(Prop.maybeMix(FlexBoxStyler().flex(FlexStyler()))),
          );
        },
      );

      styleMethodTest(
        'labelColor',
        initial: RemixToggleStyler(),
        modify: (style) => style.labelColor(Colors.white),
        expect: (style) {
          expect(
            style.$label,
            equals(
              Prop.maybeMix(
                TextStyler(style: TextStyleMix(color: Colors.white)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'iconColor',
        initial: RemixToggleStyler(),
        modify: (style) => style.iconColor(Colors.blue),
        expect: (style) {
          expect(
            style.$icon,
            equals(Prop.maybeMix(IconStyler(color: Colors.blue))),
          );
        },
      );

      styleMethodTest(
        'iconSize',
        initial: RemixToggleStyler(),
        modify: (style) => style.iconSize(24.0),
        expect: (style) {
          expect(style.$icon, equals(Prop.maybeMix(IconStyler(size: 24.0))));
        },
      );

      styleMethodTest(
        'variants',
        initial: RemixToggleStyler(),
        modify: (style) => style.variants(<VariantStyle<RemixToggleSpec>>[]),
        expect: (style) {
          expect(style.$variants, equals(<VariantStyle<RemixToggleSpec>>[]));
        },
      );

      styleMethodTest(
        'wrap',
        initial: RemixToggleStyler(),
        modify: (style) => style.wrap(.clipOval()),
        expect: (style) {
          expect(style.$modifier, equals(WidgetModifierConfig.clipOval()));
        },
      );

      styleMethodTest(
        'animate',
        initial: RemixToggleStyler(),
        modify: (style) =>
            style.animate(AnimationConfig.linear(const Duration(seconds: 1))),
        expect: (style) {
          expect(
            style.$animation,
            equals(AnimationConfig.linear(const Duration(seconds: 1))),
          );
        },
      );
    });

    group('Call Method', () {
      test('call method creates RemixToggle with required parameters', () {
        final style = RemixToggleStyler();
        final onChanged = (bool v) {};

        final toggle = style.call(
          selected: false,
          onChanged: onChanged,
          label: 'Test Toggle',
        );

        expect(toggle, isA<RemixToggle>());
        expect(toggle.label, equals('Test Toggle'));
        expect(toggle.onChanged, equals(onChanged));
      });

      test('call method creates RemixToggle with all parameters', () {
        final style = RemixToggleStyler();
        final focusNode = FocusNode();

        final toggle = style.call(
          selected: true,
          onChanged: (value) {},
          label: 'Bold',
          icon: Icons.format_bold,
          enabled: false,
          enableFeedback: false,
          focusNode: focusNode,
          autofocus: true,
          semanticLabel: 'Test Toggle',
          mouseCursor: SystemMouseCursors.forbidden,
        );

        expect(toggle, isA<RemixToggle>());
        expect(toggle.selected, isTrue);
        expect(toggle.label, equals('Bold'));
        expect(toggle.icon, equals(Icons.format_bold));
        expect(toggle.enabled, isFalse);
        expect(toggle.enableFeedback, isFalse);
        expect(toggle.focusNode, equals(focusNode));
        expect(toggle.autofocus, isTrue);
        expect(toggle.semanticLabel, equals('Test Toggle'));
        expect(toggle.mouseCursor, equals(SystemMouseCursors.forbidden));

        focusNode.dispose();
      });
    });

    group('Fortal styles', () {
      testWidgets('size metrics use scaled shared tokens', (tester) async {
        final resolved = await _resolveFortalToggleStyle(
          tester,
          fortalToggleStyler(size: .size3),
          scaling: .percent110,
        );
        final box = resolved.container.spec.box!.spec;
        final padding = box.padding!.resolve(TextDirection.ltr);

        expect(padding.left, closeTo(17.6, 1e-9));
        expect(padding.top, closeTo(8.8, 1e-9));
        expect(resolved.container.spec.flex?.spec.spacing, closeTo(6.6, 1e-9));
        expect(resolved.label.spec.style?.fontSize, closeTo(17.6, 1e-9));
        expect(resolved.label.spec.style?.height, closeTo(24 / 16, 1e-9));
        expect(resolved.label.spec.style?.fontWeight, FontWeight.w500);
        expect(resolved.icon.spec.size, closeTo(22, 1e-9));
        expect(_toggleRadius(resolved), closeTo(6.6, 1e-9));
      });

      testWidgets('pressed and disabled state precedence is deterministic', (
        tester,
      ) async {
        final pressed = await _resolveFortalToggleStyle(
          tester,
          fortalToggleStyler(),
          states: {WidgetState.pressed},
        );
        final selectedPressed = await _resolveFortalToggleStyle(
          tester,
          fortalToggleStyler(),
          states: {WidgetState.selected, WidgetState.pressed},
        );
        final disabled = await _resolveFortalToggleStyle(
          tester,
          fortalToggleStyler(),
          states: {
            WidgetState.disabled,
            WidgetState.selected,
            WidgetState.hovered,
            WidgetState.pressed,
          },
        );
        final focused = await _resolveFortalToggleStyle(
          tester,
          fortalToggleStyler(),
          states: {WidgetState.focused},
        );

        expect(_toggleColor(pressed), slate.light.scale.alphaStep(4));
        expect(_toggleColor(selectedPressed), indigo.light.scale.step(5));
        expect(_toggleColor(disabled), slate.light.scale.alphaStep(3));
        expect(disabled.label.spec.style?.color, slate.light.scale.step(8));
        expect(
          _toggleBorder(focused).top.color,
          indigo.light.scale.alphaStep(8),
        );
      });
    });

    group('Core Methods', () {
      testWidgets('resolve method returns StyleSpec', (
        WidgetTester tester,
      ) async {
        final style = RemixToggleStyler();

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final spec = style.resolve(context);

                expect(spec, isA<StyleSpec<RemixToggleSpec>>());
                expect(spec.spec, isA<RemixToggleSpec>());
                expect(spec.spec.container, isA<StyleSpec<FlexBoxSpec>>());
                expect(spec.spec.label, isA<StyleSpec<TextSpec>>());
                expect(spec.spec.icon, isA<StyleSpec<IconSpec>>());

                return Container();
              },
            ),
          ),
        );
      });

      test('merge with null returns style equal to original', () {
        final originalStyle = RemixToggleStyler();

        final mergedStyle = originalStyle.merge(null);

        expect(mergedStyle, equals(originalStyle));
      });

      test('merge combines properties correctly', () {
        final style1 = RemixToggleStyler(
          container: FlexBoxStyler(alignment: Alignment.centerLeft),
        );
        final style2 = RemixToggleStyler(
          label: TextStyler(style: TextStyleMix(color: Colors.blue)),
        );

        final merged = style1.merge(style2);

        expect(
          merged.$container,
          equals(Prop.maybeMix(FlexBoxStyler(alignment: Alignment.centerLeft))),
        );
        expect(
          merged.$label,
          equals(
            Prop.maybeMix(TextStyler(style: TextStyleMix(color: Colors.blue))),
          ),
        );
      });
    });

    group('Equality', () {
      test('identical styles are equal', () {
        final style1 = RemixToggleStyler();
        final style2 = RemixToggleStyler();

        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });

      test('styles with different properties are not equal', () {
        final style1 = RemixToggleStyler().padding(
          EdgeInsetsGeometryMix.all(16.0),
        );
        final style2 = RemixToggleStyler().padding(
          EdgeInsetsGeometryMix.all(8.0),
        );

        expect(style1, isNot(equals(style2)));
      });

      test('props list contains all properties', () {
        final style = RemixToggleStyler();

        expect(style.props, hasLength(6));
        expect(style.props, contains(style.$container));
        expect(style.props, contains(style.$label));
        expect(style.props, contains(style.$icon));
        expect(style.props, contains(style.$variants));
        expect(style.props, contains(style.$animation));
        expect(style.props, contains(style.$modifier));
      });
    });
  });
}

Future<RemixToggleSpec> _resolveFortalToggleStyle(
  WidgetTester tester,
  RemixToggleStyler style, {
  Set<WidgetState> states = const {},
  FortalScaling scaling = .percent100,
  FortalRadius radius = .medium,
}) async {
  late RemixToggleSpec resolved;
  await tester.pumpWidget(
    FortalScope(
      appearance: .light,
      scaling: scaling,
      radius: radius,
      child: WidgetsApp(
        color: Colors.black,
        builder: (context, child) => WidgetStateProvider(
          states: states,
          child: Builder(
            builder: (context) {
              resolved = style.build(context).spec;
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    ),
  );
  return resolved;
}

BoxDecoration _toggleDecoration(RemixToggleSpec spec) =>
    spec.container.spec.box!.spec.decoration! as BoxDecoration;

Color? _toggleColor(RemixToggleSpec spec) => _toggleDecoration(spec).color;

Border _toggleBorder(RemixToggleSpec spec) =>
    _toggleDecoration(spec).border! as Border;

double _toggleRadius(RemixToggleSpec spec) =>
    (_toggleDecoration(spec).borderRadius! as BorderRadius).topLeft.x;
