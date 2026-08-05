import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  test('core constructors retain the origin/main data-driven surface', () {
    const button = RemixButton(label: 'Save');
    const card = RemixCard(child: Text('Passive'));
    const checkbox = RemixCheckbox(
      selected: false,
      label: 'Receive updates',
      minimumTapTargetSize: Size.zero,
    );
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
    const skeleton = RemixSkeleton(child: Text('Jane Appleseed'));
    const dataList = RemixDataList(
      items: [RemixDataListItem(label: 'Status', value: 'Active')],
    );

    expect(button.label, 'Save');
    expect(card.child, isA<Text>());
    expect(checkbox.label, 'Receive updates');
    expect(checkbox.minimumTapTargetSize, Size.zero);
    expect(menu.trigger, isA<RemixMenuTrigger>());
    expect(menu.items.single, isA<RemixMenuItem<String>>());
    expect(select.items.single, isA<RemixSelectItem<String>>());
    expect(slider.value, 0.5);
    expect(progress.value, 0.5);
    expect(tabBar.child, isA<Text>());
    expect(spinner, isA<RemixSpinner>());
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
    const checkbox = FortalCheckbox.soft(
      selected: false,
      label: 'Receive updates',
      minimumTapTargetSize: Size.zero,
    );

    expect(menu.variant, FortalMenuVariant.soft);
    expect(select.variant, FortalSelectVariant.ghost);
    expect(radio.variant, FortalRadioVariant.soft);
    expect(button.variant, FortalButtonVariant.soft);
    expect(checkbox.label, 'Receive updates');
    expect(checkbox.minimumTapTargetSize, Size.zero);
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
