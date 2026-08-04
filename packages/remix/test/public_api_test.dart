import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  test('segmented control API is constructible from the package barrel', () {
    const item = RemixSegmentedControlItem<String>(
      value: 'list',
      label: 'List',
    );
    const control = RemixSegmentedControl<String>(
      items: [item],
      selectedValue: 'list',
    );
    const unselectedControl = RemixSegmentedControl<int>(
      items: [RemixSegmentedControlItem<int>(value: 1, label: 'One')],
      selectedValue: null,
    );

    expect(control.items.single, item);
    expect(unselectedControl.items.single.value, 1);
    expect(unselectedControl.selectedValue, isNull);
    expect(control.style, isA<SegmentedControlStyler>());
    expect(const SegmentedControlSpec(), isA<SegmentedControlSpec>());
    expect(const SegmentedControlItemSpec(), isA<SegmentedControlItemSpec>());
  });

  test(
    'segmented callback receives T while selectedValue remains nullable',
    () {
      final changes = <String>[];

      final control = RemixSegmentedControl<String>(
        items: const [RemixSegmentedControlItem(value: 'grid', label: 'Grid')],
        selectedValue: null,
        onChanged: changes.add,
      );

      control.onChanged?.call('grid');

      expect(control.selectedValue, isNull);
      expect(changes, ['grid']);
    },
  );

  test('the data list family is constructible from the public API', () {
    const item = RemixDataListItem(
      key: ValueKey<String>('status'),
      label: 'Status',
      value: 'Active',
      alignment: RemixDataListItemAlignment.center,
    );
    const rawStyleSpec = StyleSpec<DataListSpec>(
      spec: DataListSpec(
        rowSpacing: 8,
        columnSpacing: 16,
        labelValueSpacing: 4,
        minLabelWidth: 120,
      ),
    );
    const raw = RemixDataList(
      key: ValueKey<String>('raw'),
      items: [item],
      orientation: Axis.vertical,
      semanticLabel: 'Account details',
      excludeSemantics: true,
      styleSpec: rawStyleSpec,
    );
    final Style<DataListSpec> style = raw.style;
    final StyleSpec<DataListSpec>? styleSpec = raw.styleSpec;

    final DataListStyler styler = RemixDataList.styleFrom(
      rowSpacing: 12,
      columnSpacing: 20,
      labelValueSpacing: 6,
      minLabelWidth: 144,
    );
    final items = <RemixDataListItem>[item];
    const forwardedKey = ValueKey<String>('forwarded');
    final called = styler(
      key: forwardedKey,
      items: items,
      orientation: Axis.vertical,
      semanticLabel: 'Forwarded account details',
      excludeSemantics: true,
    );

    expect(raw, isA<RemixDataList>());
    expect(raw.items.single, same(item));
    expect(style, isA<DataListStyler>());
    expect(styleSpec, same(rawStyleSpec));
    expect(styleSpec?.spec, isA<DataListSpec>());
    expect(styler, isA<DataListStyler>());
    expect(called, isA<RemixDataList>());
    expect(called.key, forwardedKey);
    expect(called.style, same(styler));
    expect(called.items, same(items));
    expect(called.orientation, Axis.vertical);
    expect(called.semanticLabel, 'Forwarded account details');
    expect(called.excludeSemantics, isTrue);
  });

  test('mode-aware Fortal filters are constructible from the public API', () {
    final modifier = fortalModeAwareFilter(
      light: const [RemixCssColorFilterOperation.brightness(1.1)],
      dark: const [RemixCssColorFilterOperation.contrast(0.9)],
    );

    expect(modifier, isNotNull);
  });
}
