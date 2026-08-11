import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_methods.dart';

void main() {
  group('ToggleGroupStyler', () {
    test('constructors retain container and item styles', () {
      final container = FlexBoxStyler();
      final item = ToggleGroupItemStyler();
      final style = ToggleGroupStyler(container: container, item: item);

      expect(style.$container, Prop.maybeMix(container));
      expect(style.$item, Prop.maybeMix(item));
    });

    styleMethodTest(
      'sets the group background color',
      initial: ToggleGroupStyler(),
      modify: (style) => style.color(Colors.blue),
      expect: (style) {
        expect(style, ToggleGroupStyler.color(Colors.blue));
      },
    );

    styleMethodTest(
      'sets the default item style',
      initial: ToggleGroupStyler(),
      modify: (style) => style.item(ToggleGroupItemStyler()),
      expect: (style) {
        expect(style.$item, Prop.maybeMix(ToggleGroupItemStyler()));
      },
    );

    test('generic call creates a typed group', () {
      final widget = ToggleGroupStyler().call<String>(
        items: const [RemixToggleGroupItem(value: 'list', label: 'List')],
        selectedValue: 'list',
        onChanged: (_) {},
      );

      expect(widget, isA<RemixToggleGroup<String>>());
    });
  });

  group('ToggleGroupItemStyler', () {
    styleMethodTest(
      'sets foreground color on label and icon',
      initial: ToggleGroupItemStyler(),
      modify: (style) => style.labelColor(Colors.red).iconColor(Colors.red),
      expect: (style) {
        expect(style.$label, isNotNull);
        expect(style.$icon, isNotNull);
      },
    );

    styleMethodTest(
      'adds a selected-state variant',
      initial: ToggleGroupItemStyler(),
      modify: (style) =>
          style.onSelected(ToggleGroupItemStyler().color(Colors.purple)),
      expect: (style) {
        expect(style.$variants, hasLength(1));
      },
    );

    styleMethodTest(
      'sets icon and label spacing',
      initial: ToggleGroupItemStyler(),
      modify: (style) => style.spacing(8),
      expect: (style) {
        expect(style, ToggleGroupItemStyler.spacing(8));
      },
    );
  });
}
