import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

void main() {
  test('new Fortal controls expose generated public wrappers', () {
    const segmented = FortalSegmentedControl<String>.classic(
      items: [RemixSegmentedControlItem(value: 'one', label: 'One')],
      selectedValue: 'one',
      size: FortalSegmentedControlSize.size3,
    );
    const textArea = FortalTextArea.soft(
      hintText: 'Notes',
      size: FortalTextAreaSize.size1,
    );

    expect(segmented, isA<FortalSegmentedControl<String>>());
    expect(segmented.variant, FortalSegmentedControlVariant.classic);
    expect(segmented.size, FortalSegmentedControlSize.size3);
    expect(textArea, isA<FortalTextArea>());
    expect(textArea.variant, FortalTextAreaVariant.soft);
    expect(textArea.size, FortalTextAreaSize.size1);
    expect(fortalSegmentedControlStyle(), isA<SegmentedControlStyler>());
    expect(fortalTextAreaStyle(), isA<TextFieldStyler>());
  });

  test('mode-aware Fortal filters are constructible from the public API', () {
    final modifier = fortalModeAwareFilter(
      light: const [RemixCssColorFilterOperation.brightness(1.1)],
      dark: const [RemixCssColorFilterOperation.contrast(0.9)],
    );

    expect(modifier, isNotNull);
  });

  test('the Fortal skeleton wrapper is constructible from the public API', () {
    expect(const FortalSkeleton(), isA<FortalSkeleton>());
    expect(fortalSkeletonStyle(), isA<SkeletonStyler>());
  });

  test('the Fortal data list wrapper is constructible from the public API', () {
    const item = RemixDataListItem(label: 'Name', value: 'Jane');
    const fortal = FortalDataList(
      items: [item],
      size: FortalDataListSize.size3,
      highContrast: true,
    );

    expect(fortal, isA<FortalDataList>());
    expect(fortal.size, FortalDataListSize.size3);
    expect(fortal.highContrast, isTrue);
    expect(fortalDataListStyle(), isA<DataListStyler>());
  });

  test(
    'the Fortal data table wrapper is constructible from the public API',
    () {
      const fortal = FortalDataTable<String>.surface(
        rows: ['one'],
        columns: [],
        size: FortalDataTableSize.size3,
      );

      expect(fortal, isA<FortalDataTable<String>>());
      expect(fortal.variant, FortalDataTableVariant.surface);
      expect(fortalDataTableStyle(), isA<DataTableStyler>());
    },
  );
}
