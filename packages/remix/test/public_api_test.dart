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

  test('mode-aware Fortal filters are constructible from the public API', () {
    final modifier = fortalModeAwareFilter(
      light: const [RemixCssColorFilterOperation.brightness(1.1)],
      dark: const [RemixCssColorFilterOperation.contrast(0.9)],
    );

    expect(modifier, isNotNull);
  });
}
