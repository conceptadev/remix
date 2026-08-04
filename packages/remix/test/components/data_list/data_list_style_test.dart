import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_methods.dart';

void main() {
  group('DataListStyler', () {
    group('Constructors', () {
      test('default constructor creates valid instance', () {
        final style = DataListStyler();

        expect(style, isNotNull);
        expect(style, isA<DataListStyler>());
      });

      test('create constructor with all parameters', () {
        final container = Prop.maybeMix(BoxStyler());
        final labelContainer = Prop.maybeMix(BoxStyler());
        final valueContainer = Prop.maybeMix(BoxStyler());
        final label = Prop.maybeMix(TextStyler());
        final value = Prop.maybeMix(TextStyler());
        final rowSpacing = Prop.maybe(8.0);
        final variants = <VariantStyle<DataListSpec>>[];

        final style = DataListStyler.create(
          container: container,
          labelContainer: labelContainer,
          valueContainer: valueContainer,
          label: label,
          value: value,
          rowSpacing: rowSpacing,
          variants: variants,
        );

        expect(style.$container, equals(container));
        expect(style.$labelContainer, equals(labelContainer));
        expect(style.$valueContainer, equals(valueContainer));
        expect(style.$label, equals(label));
        expect(style.$value, equals(value));
        expect(style.$rowSpacing, equals(rowSpacing));
        expect(style.$variants, equals(variants));
      });

      test('constructor with styler parameters', () {
        final style = DataListStyler(
          container: BoxStyler(),
          labelContainer: BoxStyler(),
          valueContainer: BoxStyler(),
          label: TextStyler(),
          value: TextStyler(),
          rowSpacing: 8.0,
          columnSpacing: 16.0,
          labelValueSpacing: 4.0,
          minLabelWidth: 120.0,
        );

        expect(style.$container, isNotNull);
        expect(style.$labelContainer, isNotNull);
        expect(style.$valueContainer, isNotNull);
        expect(style.$label, isNotNull);
        expect(style.$value, isNotNull);
        expect(style.$rowSpacing, isNotNull);
        expect(style.$columnSpacing, isNotNull);
        expect(style.$labelValueSpacing, isNotNull);
        expect(style.$minLabelWidth, isNotNull);
      });
    });

    group('Slot Methods', () {
      styleMethodTest(
        'labelContainer',
        initial: DataListStyler(),
        modify: (style) =>
            style.labelContainer(BoxStyler().color(Colors.black12)),
        expect: (style) {
          expect(
            style,
            equals(
              DataListStyler.labelContainer(BoxStyler().color(Colors.black12)),
            ),
          );
        },
      );

      styleMethodTest(
        'valueContainer',
        initial: DataListStyler(),
        modify: (style) =>
            style.valueContainer(BoxStyler().color(Colors.black26)),
        expect: (style) {
          expect(
            style,
            equals(
              DataListStyler.valueContainer(BoxStyler().color(Colors.black26)),
            ),
          );
        },
      );

      styleMethodTest(
        'label',
        initial: DataListStyler(),
        modify: (style) => style.label(TextStyler().fontSize(12)),
        expect: (style) {
          expect(style, equals(DataListStyler.label(TextStyler().fontSize(12))));
        },
      );

      styleMethodTest(
        'value',
        initial: DataListStyler(),
        modify: (style) => style.value(TextStyler().fontSize(14)),
        expect: (style) {
          expect(style, equals(DataListStyler.value(TextStyler().fontSize(14))));
        },
      );

      styleMethodTest(
        'container via forwarded Box surface',
        initial: DataListStyler(),
        modify: (style) => style.padding(EdgeInsetsGeometryMix.all(16.0)),
        expect: (style) {
          expect(
            style,
            equals(DataListStyler.padding(EdgeInsetsGeometryMix.all(16.0))),
          );
        },
      );

      styleMethodTest(
        'color',
        initial: DataListStyler(),
        modify: (style) => style.color(Colors.red),
        expect: (style) {
          expect(style, equals(DataListStyler.color(Colors.red)));
        },
      );
    });

    group('Metric Methods', () {
      styleMethodTest(
        'rowSpacing',
        initial: DataListStyler(),
        modify: (style) => style.rowSpacing(12.0),
        expect: (style) {
          expect(style, equals(DataListStyler.rowSpacing(12.0)));
        },
      );

      styleMethodTest(
        'columnSpacing',
        initial: DataListStyler(),
        modify: (style) => style.columnSpacing(24.0),
        expect: (style) {
          expect(style, equals(DataListStyler.columnSpacing(24.0)));
        },
      );

      styleMethodTest(
        'labelValueSpacing',
        initial: DataListStyler(),
        modify: (style) => style.labelValueSpacing(4.0),
        expect: (style) {
          expect(style, equals(DataListStyler.labelValueSpacing(4.0)));
        },
      );

      styleMethodTest(
        'minLabelWidth',
        initial: DataListStyler(),
        modify: (style) => style.minLabelWidth(120.0),
        expect: (style) {
          expect(style, equals(DataListStyler.minLabelWidth(120.0)));
        },
      );
    });

    group('Remix Helpers', () {
      styleMethodTest(
        'labelTextStyle',
        initial: DataListStyler(),
        modify: (style) => style.labelTextStyle(TextStyleMix(fontSize: 11)),
        expect: (style) {
          expect(
            style.$label,
            equals(
              Prop.maybeMix(TextStyler(style: TextStyleMix(fontSize: 11))),
            ),
          );
        },
      );

      styleMethodTest(
        'labelColor',
        initial: DataListStyler(),
        modify: (style) => style.labelColor(Colors.grey),
        expect: (style) {
          expect(
            style.$label,
            equals(
              Prop.maybeMix(TextStyler(style: TextStyleMix(color: Colors.grey))),
            ),
          );
        },
      );

      styleMethodTest(
        'valueTextStyle',
        initial: DataListStyler(),
        modify: (style) => style.valueTextStyle(TextStyleMix(fontSize: 15)),
        expect: (style) {
          expect(
            style.$value,
            equals(
              Prop.maybeMix(TextStyler(style: TextStyleMix(fontSize: 15))),
            ),
          );
        },
      );

      styleMethodTest(
        'valueColor',
        initial: DataListStyler(),
        modify: (style) => style.valueColor(Colors.black),
        expect: (style) {
          expect(
            style.$value,
            equals(
              Prop.maybeMix(
                TextStyler(style: TextStyleMix(color: Colors.black)),
              ),
            ),
          );
        },
      );

      test('call creates a RemixDataList with this style', () {
        final style = DataListStyler().rowSpacing(8.0);

        final widget = style(
          items: const [RemixDataListItem(label: 'Name', value: 'Leo')],
          orientation: Axis.vertical,
          semanticLabel: 'Account',
        );

        expect(widget, isA<RemixDataList>());
        expect(widget.style, same(style));
        expect(widget.orientation, equals(Axis.vertical));
        expect(widget.semanticLabel, equals('Account'));
        expect(widget.items, hasLength(1));
      });
    });

    group('Modifier Methods', () {
      styleMethodTest(
        'wrap',
        initial: DataListStyler(),
        modify: (style) => style.wrap(.opacity(0.5)),
        expect: (style) {
          expect(style.$modifier, equals(WidgetModifierConfig.opacity(0.5)));
        },
      );

      styleMethodTest(
        'variants',
        initial: DataListStyler(),
        modify: (style) => style.variants(<VariantStyle<DataListSpec>>[]),
        expect: (style) {
          expect(style.$variants, equals(<VariantStyle<DataListSpec>>[]));
        },
      );

      styleMethodTest(
        'animate',
        initial: DataListStyler(),
        modify: (style) => style.animate(
          AnimationConfig.linear(const Duration(milliseconds: 300)),
        ),
        expect: (style) {
          expect(
            style.$animation,
            equals(AnimationConfig.linear(const Duration(milliseconds: 300))),
          );
        },
      );
    });

    group('Core Methods', () {
      testWidgets('resolve method returns StyleSpec with every field', (
        tester,
      ) async {
        final style = DataListStyler()
            .rowSpacing(8.0)
            .columnSpacing(16.0)
            .labelValueSpacing(4.0)
            .minLabelWidth(120.0);

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final spec = style.resolve(context);

                expect(spec, isA<StyleSpec<DataListSpec>>());
                expect(spec.spec.container, isA<StyleSpec<BoxSpec>>());
                expect(spec.spec.labelContainer, isA<StyleSpec<BoxSpec>>());
                expect(spec.spec.valueContainer, isA<StyleSpec<BoxSpec>>());
                expect(spec.spec.label, isA<StyleSpec<TextSpec>>());
                expect(spec.spec.value, isA<StyleSpec<TextSpec>>());
                expect(spec.spec.rowSpacing, equals(8.0));
                expect(spec.spec.columnSpacing, equals(16.0));
                expect(spec.spec.labelValueSpacing, equals(4.0));
                expect(spec.spec.minLabelWidth, equals(120.0));

                return Container();
              },
            ),
          ),
        );
      });

      test('merge with null returns style equal to original', () {
        final originalStyle = DataListStyler().rowSpacing(8.0);

        final mergedStyle = originalStyle.merge(null);

        expect(mergedStyle, equals(originalStyle));
      });

      testWidgets('merge resolves with last-wins scalars', (tester) async {
        final merged = DataListStyler()
            .rowSpacing(8.0)
            .minLabelWidth(100.0)
            .merge(DataListStyler().rowSpacing(12.0).columnSpacing(24.0));

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final spec = merged.resolve(context).spec;

                expect(spec.rowSpacing, equals(12.0));
                expect(spec.minLabelWidth, equals(100.0));
                expect(spec.columnSpacing, equals(24.0));

                return Container();
              },
            ),
          ),
        );
      });

      testWidgets('merge accumulates nested slot styles', (tester) async {
        final merged = DataListStyler()
            .label(TextStyler().fontSize(12))
            .merge(DataListStyler().labelColor(Colors.grey));

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final spec = merged.resolve(context).spec;
                final textStyle = spec.label.spec.style;

                expect(textStyle?.fontSize, equals(12.0));
                expect(textStyle?.color, equals(Colors.grey));

                return Container();
              },
            ),
          ),
        );
      });
    });

    group('Variants', () {
      testWidgets('context variant resolves for the surrounding Mix context', (
        tester,
      ) async {
        final style = DataListStyler()
            .rowSpacing(8.0)
            .onDark(.rowSpacing(24.0));
        double? resolved;

        // Variants merge inside StyleBuilder, the widget resolution path.
        await tester.pumpWidget(
          MaterialApp(
            home: MediaQuery(
              data: const MediaQueryData(platformBrightness: Brightness.dark),
              child: StyleBuilder<DataListSpec>(
                style: style,
                builder: (context, spec) {
                  resolved = spec.rowSpacing;

                  return const SizedBox();
                },
              ),
            ),
          ),
        );

        expect(resolved, equals(24.0));
      });
    });

    group('Equality', () {
      test('identical styles are equal', () {
        final style1 = DataListStyler().rowSpacing(8.0);
        final style2 = DataListStyler().rowSpacing(8.0);

        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });

      test('styles with different properties are not equal', () {
        final style1 = DataListStyler().rowSpacing(8.0);
        final style2 = DataListStyler().rowSpacing(12.0);

        expect(style1, isNot(equals(style2)));
      });
    });

    group('Props', () {
      test('props list contains all properties', () {
        final style = DataListStyler();

        expect(style.props, hasLength(12));
        expect(style.props, contains(style.$container));
        expect(style.props, contains(style.$labelContainer));
        expect(style.props, contains(style.$valueContainer));
        expect(style.props, contains(style.$label));
        expect(style.props, contains(style.$value));
        expect(style.props, contains(style.$rowSpacing));
        expect(style.props, contains(style.$columnSpacing));
        expect(style.props, contains(style.$labelValueSpacing));
        expect(style.props, contains(style.$minLabelWidth));
      });
    });

    group('Chaining', () {
      test('multiple style methods can be chained', () {
        final style = DataListStyler()
            .labelColor(Colors.grey)
            .valueColor(Colors.black)
            .rowSpacing(8.0)
            .columnSpacing(16.0)
            .minLabelWidth(120.0);

        expect(style, isA<DataListStyler>());
        expect(style.$label, isNotNull);
        expect(style.$value, isNotNull);
        expect(style.$rowSpacing, isNotNull);
      });
    });
  });
}
