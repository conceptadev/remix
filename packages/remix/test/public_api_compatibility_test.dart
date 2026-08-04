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
    const checkboxGroup = RemixCheckboxGroup<String>(
      values: {'one'},
      child: RemixCheckboxGroupItem<String>(
        value: 'one',
        label: 'One',
        semanticLabel: 'Option one',
        minimumTapTargetSize: Size.zero,
      ),
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
    expect(checkbox.selected, isFalse);
    expect(checkboxGroup.values.single, 'one');
    expect(checkboxGroup.child, isA<RemixCheckboxGroupItem<String>>());
    final checkboxGroupItem =
        checkboxGroup.child as RemixCheckboxGroupItem<String>;
    expect(checkboxGroupItem.label, 'One');
    expect(checkboxGroupItem.semanticLabel, 'Option one');
    expect(checkboxGroupItem.minimumTapTargetSize, Size.zero);
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
