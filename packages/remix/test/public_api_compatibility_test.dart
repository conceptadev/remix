import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  test('core constructors retain the origin/main data-driven surface', () {
    const button = RemixButton(label: 'Save');
    const card = RemixCard(child: Text('Passive'));
    const menu = RemixMenu<String>(
      trigger: RemixMenuTrigger(label: 'Actions'),
      items: [RemixMenuItem(value: 'save', label: 'Save')],
    );
    const select = RemixSelect<String>(
      trigger: RemixSelectTrigger(placeholder: 'Choose'),
      items: [RemixSelectItem(value: 'one', label: 'One')],
    );
    const slider = RemixSlider(value: 0.5);
    const progress = RemixProgress(value: 0.5);
    const tabBar = RemixTabBar(child: Text('Tabs'));
    const spinner = RemixSpinner();
    const segmentedItem = RemixSegmentedControlItem<String>(
      value: 'list',
      label: 'List',
    );
    const segmentedControl = RemixSegmentedControl<String>(
      items: [segmentedItem],
      selectedValue: 'list',
    );
    const skeleton = RemixSkeleton(child: Text('Jane Appleseed'));
    const dataList = RemixDataList(
      items: [RemixDataListItem(label: 'Status', value: 'Active')],
    );

    expect(button.label, 'Save');
    expect(card.child, isA<Text>());
    expect(menu.trigger, isA<RemixMenuTrigger>());
    expect(menu.items.single, isA<RemixMenuItem<String>>());
    expect(select.items.single, isA<RemixSelectItem<String>>());
    expect(slider.value, 0.5);
    expect(progress.value, 0.5);
    expect(tabBar.child, isA<Text>());
    expect(spinner, isA<RemixSpinner>());
    expect(segmentedControl.items.single, segmentedItem);
    expect(segmentedControl.items.single.value, 'list');
    expect(skeleton.child, isA<Text>());
    expect(skeleton.loading, isTrue);
    expect(dataList.items.single, isA<RemixDataListItem>());
    expect(dataList.items.single.label, 'Status');
    expect(dataList.items.single.value, 'Active');
    expect(
      dataList.items.single.alignment,
      RemixDataListItemAlignment.baseline,
    );
    expect(dataList.orientation, Axis.horizontal);
    expect(dataList.style, isA<DataListStyler>());
    expect(dataList.styleSpec, isNull);
  });

  test('generated wrappers preserve generic and named constructors', () {
    const menu = FortalMenu<String>.soft(
      trigger: RemixMenuTrigger(label: 'Actions'),
      items: [RemixMenuItem(value: 'save', label: 'Save')],
    );
    const select = FortalSelect<String>.ghost(
      trigger: RemixSelectTrigger(placeholder: 'Choose'),
      items: [RemixSelectItem(value: 'one', label: 'One')],
    );
    const radio = FortalRadio<String>.soft(value: 'one');
    const button = FortalButton.soft(label: 'Save');

    expect(menu.variant, FortalMenuVariant.soft);
    expect(select.variant, FortalSelectVariant.ghost);
    expect(radio.variant, FortalRadioVariant.soft);
    expect(button.variant, FortalButtonVariant.soft);
  });

  test('segmented control accepts a non-nullable value callback', () {
    final changes = <String>[];
    final control = RemixSegmentedControl<String>(
      items: const [RemixSegmentedControlItem(value: 'list', label: 'List')],
      selectedValue: null,
      onChanged: changes.add,
    );

    control.onChanged?.call('list');

    expect(control.selectedValue, isNull);
    expect(changes, ['list']);
  });

  test('theme configuration exposes only canonical names', () {
    const config = FortalThemeConfig(
      accent: .red,
      gray: .mauve,
      brightness: .dark,
      panelBackground: .solid,
      radius: .large,
      scaling: .percent105,
      hasBackground: false,
    );

    expect(config.accent, FortalAccentColor.red);
    expect(config.gray, FortalGrayColor.mauve);
    expect(config.brightness, Brightness.dark);
  });
}
