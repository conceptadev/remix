import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';
import '../../helpers/test_methods.dart';

void main() {
  group('SegmentedControlStyler', () {
    test('constructors retain independent track and item styles', () {
      final container = BoxStyler();
      final item = SegmentedControlItemStyler();
      final style = SegmentedControlStyler(container: container, item: item);

      expect(style.$container, Prop.maybeMix(container));
      expect(style.$item, Prop.maybeMix(item));
    });

    styleMethodTest(
      'sets the track background color',
      initial: SegmentedControlStyler(),
      modify: (style) => style.color(Colors.blue),
      expect: (style) {
        expect(style, SegmentedControlStyler.color(Colors.blue));
      },
    );

    test('resolves the supported track layout controls', () {
      final spec = SegmentedControlStyler()
          .mainAxisSize(.max)
          .spacing(6)
          .build(MockBuildContext())
          .spec;

      expect(spec.mainAxisSize, MainAxisSize.max);
      expect(spec.spacing, 6);
    });

    styleMethodTest(
      'sets the default item style',
      initial: SegmentedControlStyler(),
      modify: (style) => style.item(SegmentedControlItemStyler()),
      expect: (style) {
        expect(style.$item, Prop.maybeMix(SegmentedControlItemStyler()));
      },
    );
  });

  group('SegmentedControlItemStyler', () {
    test('exposes a box surface and explicit content spacing', () {
      final container = BoxStyler().paddingAll(4);
      final style = SegmentedControlItemStyler(
        container: container,
        spacing: 6,
      );

      expect(style.$container, Prop.maybeMix(container));
      expect(style.$spacing, Prop.maybe(6.0));

      final spec = style.build(MockBuildContext()).spec;
      final StyleSpec<BoxSpec> resolvedContainer = spec.container;
      expect(resolvedContainer.spec.padding, isNotNull);
      expect(spec.spacing, 6);
    });

    styleMethodTest(
      'sets foreground color on label and icon',
      initial: SegmentedControlItemStyler(),
      modify: (style) => style.labelColor(Colors.red).iconColor(Colors.red),
      expect: (style) {
        expect(style.$label, isNotNull);
        expect(style.$icon, isNotNull);
      },
    );

    styleMethodTest(
      'adds selected, disabled, hovered, focused, and pressed variants',
      initial: SegmentedControlItemStyler(),
      modify: (style) => style
          .onSelected(SegmentedControlItemStyler().color(Colors.blue))
          .onDisabled(SegmentedControlItemStyler().color(Colors.grey))
          .onHovered(SegmentedControlItemStyler().color(Colors.green))
          .onFocused(SegmentedControlItemStyler().color(Colors.orange))
          .onPressed(SegmentedControlItemStyler().color(Colors.purple)),
      expect: (style) {
        expect(style.$variants, hasLength(5));
      },
    );

    test('container effects merge through the generated item styler', () {
      final merged = SegmentedControlItemStyler()
          .containerEffects(RemixBoxEffectsMix(outlineOffset: 2))
          .merge(
            SegmentedControlItemStyler().containerEffects(
              RemixBoxEffectsMix(backdropBlur: 3),
            ),
          );

      final spec = merged.build(MockBuildContext()).spec;

      expect(spec.containerEffects?.outlineOffset, 2);
      expect(spec.containerEffects?.backdropBlur, 3);
    });
  });
}
