import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  test('core constructors retain the origin/main data-driven surface', () {
    const button = RemixButton(label: 'Save');
    const card = RemixCard(child: Text('Passive'));
    const menu = RemixMenu<String>(
      trigger: RemixMenuTrigger(label: 'Actions'),
      items: [
        RemixMenuItem(value: 'save', label: 'Save'),
        RemixMenuCheckboxItem(
          value: 'notifications',
          label: 'Notifications',
          checked: true,
        ),
        RemixMenuRadioGroup(
          value: 'compact',
          items: [
            RemixMenuRadioItem(value: 'compact', label: 'Compact'),
            RemixMenuRadioItem(value: 'comfortable', label: 'Comfortable'),
          ],
        ),
        RemixMenuSubmenu(
          label: 'More',
          items: [RemixMenuItem(value: 'archive', label: 'Archive')],
        ),
      ],
    );
    const select = RemixSelect<String>(
      trigger: RemixSelectTrigger(placeholder: 'Choose'),
      items: [RemixSelectItem(value: 'one', label: 'One')],
    );
    const slider = RemixSlider(value: 0.5);
    const progress = RemixProgress(value: 0.5);
    const tabBar = RemixTabBar(child: Text('Tabs'));
    const spinner = RemixSpinner();

    expect(button.label, 'Save');
    expect(card.child, isA<Text>());
    expect(menu.trigger, isA<RemixMenuTrigger>());
    expect(menu.items, hasLength(4));
    expect(menu.items[0], isA<RemixMenuItem<String>>());
    expect(menu.items[1], isA<RemixMenuCheckboxItem<String>>());
    expect(menu.items[2], isA<RemixMenuRadioGroup<String>>());
    expect(menu.items[3], isA<RemixMenuSubmenu<String>>());
    expect(select.items.single, isA<RemixSelectItem<String>>());
    expect(slider.value, 0.5);
    expect(progress.value, 0.5);
    expect(tabBar.child, isA<Text>());
    expect(spinner, isA<RemixSpinner>());
  });

  test('generated wrappers preserve generic and named constructors', () {
    const menu = FortalMenu<String>.soft(
      style: MenuStyler.create(),
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
    expect(menu.style, isA<MenuStyler>());
    expect(select.variant, FortalSelectVariant.ghost);
    expect(radio.variant, FortalRadioVariant.soft);
    expect(button.variant, FortalButtonVariant.soft);
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
