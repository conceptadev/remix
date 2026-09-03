import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

void main() {
  test('generated wrappers preserve generic and named constructors', () {
    const menu = FortalMenu<String>.soft(
      trigger: RemixMenuTrigger(label: 'Actions'),
      items: [RemixMenuItem(value: 'save', label: 'Save')],
    );
    const select = FortalSelect<String>.ghost(
      trigger: RemixSelectTrigger(placeholder: 'Choose'),
      items: [RemixSelectItem(value: 'one', label: 'One')],
    );
    const radio = FortalRadio<String>.soft(
      value: 'one',
      semanticLabel: 'Option',
    );
    const button = FortalButton.soft(label: 'Save');
    const checkbox = FortalCheckbox.soft(
      selected: false,
      label: 'Receive updates',
      minimumTapTargetSize: Size.zero,
    );
    const segmented = FortalSegmentedControl.classic(
      items: [RemixSegmentedControlItem(value: 'list', label: 'List')],
      selectedValue: 'list',
    );
    const textArea = FortalTextArea.classic();

    expect(menu.variant, FortalMenuVariant.soft);
    expect(menu.trigger.label, 'Actions');
    expect(menu.trigger.icon, isNull);

    Widget accountBuilder(
      BuildContext context,
      NakedMenuState state,
      Widget? child,
    ) {
      return child ?? const SizedBox.shrink();
    }

    final unnamedBuilderMenu = FortalMenu<String>(
      trigger: RemixMenuTrigger.builder(
        label: 'Account menu',
        builder: accountBuilder,
      ),
      items: const [RemixMenuItem(value: 'save', label: 'Save')],
    );
    final namedBuilderMenu = FortalMenu<String>.soft(
      trigger: RemixMenuTrigger.builder(
        label: 'Account menu',
        builder: accountBuilder,
      ),
      items: const [RemixMenuItem(value: 'save', label: 'Save')],
    );

    expect(unnamedBuilderMenu.trigger.label, 'Account menu');
    expect(unnamedBuilderMenu.trigger.builder, same(accountBuilder));
    expect(namedBuilderMenu.variant, FortalMenuVariant.soft);
    expect(namedBuilderMenu.trigger.builder, same(accountBuilder));
    expect(select.variant, FortalSelectVariant.ghost);
    expect(radio.variant, FortalRadioVariant.soft);
    expect(button.variant, FortalButtonVariant.soft);
    expect(checkbox.label, 'Receive updates');
    expect(checkbox.minimumTapTargetSize, Size.zero);
    expect(segmented, isA<FortalSegmentedControl<String>>());
    expect(segmented.variant, FortalSegmentedControlVariant.classic);
    expect(textArea.variant, FortalTextAreaVariant.classic);
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
