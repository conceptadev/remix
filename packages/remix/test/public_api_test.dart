import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

enum Interest { design, code }

void main() {
  test('mode-aware Fortal filters are constructible from the public API', () {
    final modifier = fortalModeAwareFilter(
      light: const [RemixCssColorFilterOperation.brightness(1.1)],
      dark: const [RemixCssColorFilterOperation.contrast(0.9)],
    );

    expect(modifier, isNotNull);
  });

  test('checkbox groups are const-constructible over any value type', () {
    const stringGroup = RemixCheckboxGroup<String>(
      values: {'design'},
      child: RemixCheckboxGroupItem<String>(value: 'design', label: 'Design'),
    );
    const enumGroup = RemixCheckboxGroup<Interest>(
      values: {Interest.code},
      child: RemixCheckboxGroupItem<Interest>(
        value: Interest.code,
        label: 'Code',
      ),
    );

    expect(stringGroup.values, equals({'design'}));
    expect(stringGroup.child, isA<RemixCheckboxGroupItem<String>>());
    expect(enumGroup.values, equals({Interest.code}));
    expect(enumGroup.child, isA<RemixCheckboxGroupItem<Interest>>());
  });

  test('checkbox group flags and item passthrough stay on the public API', () {
    final focusNode = FocusNode();
    addTearDown(focusNode.dispose);

    final group = RemixCheckboxGroup<Interest>(
      values: const {Interest.design},
      onChanged: (Set<Interest> values) {},
      enabled: false,
      isRequired: true,
      semanticLabel: 'Interests',
      excludeSemantics: true,
      child: RemixCheckboxGroupItem<Interest>(
        value: Interest.design,
        label: 'Design',
        semanticLabel: 'Design interest',
        enabled: false,
        focusNode: focusNode,
        autofocus: true,
        checkedIcon: Icons.done,
        uncheckedIcon: Icons.close,
        enableFeedback: false,
        minimumTapTargetSize: Size.zero,
        mouseCursor: SystemMouseCursors.basic,
        style: fortalCheckboxStyle(variant: FortalCheckboxVariant.soft),
        styleSpec: const CheckboxSpec(),
      ),
    );

    final item = group.child as RemixCheckboxGroupItem<Interest>;

    expect(group.onChanged, isA<ValueChanged<Set<Interest>>>());
    expect(group.enabled, isFalse);
    expect(group.isRequired, isTrue);
    expect(group.semanticLabel, 'Interests');
    expect(group.excludeSemantics, isTrue);
    expect(item.label, 'Design');
    expect(item.semanticLabel, 'Design interest');
    expect(item.focusNode, same(focusNode));
    expect(item.autofocus, isTrue);
    expect(item.minimumTapTargetSize, Size.zero);
    expect(item.style, isA<CheckboxStyler>());
    expect(item.styleSpec, isA<CheckboxSpec>());
    expect(RemixCheckboxGroupItem.styleFrom, isNotNull);
  });
}
