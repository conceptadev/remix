import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  test('origin main widget constructor APIs remain source compatible', () {
    final focusNode = FocusNode();
    addTearDown(focusNode.dispose);

    const badge = RemixBadge(label: 'New');
    final button = RemixButton(
      label: 'Save',
      leadingIcon: Icons.save,
      trailingIcon: Icons.check,
      textBuilder: (context, spec, text) => Text(text),
      leadingIconBuilder: (context, spec, icon) => Icon(icon),
      trailingIconBuilder: (context, spec, icon) => Icon(icon),
      onPressed: () {},
    );
    const callout = RemixCallout(text: 'Saved', icon: Icons.info);
    final iconButton = RemixIconButton(
      icon: Icons.favorite,
      iconBuilder: (context, spec, icon) => Icon(icon),
      onPressed: () {},
    );
    final menu = RemixMenu<String>(
      trigger: const RemixMenuTrigger(label: 'Options', icon: Icons.more_vert),
      items: const <RemixMenuItemData<String>>[
        RemixMenuItem(value: 'copy', label: 'Copy'),
        RemixMenuDivider(),
      ],
    );
    final select = RemixSelect<String>(
      trigger: const RemixSelectTrigger(placeholder: 'Choose'),
      items: const [RemixSelectItem(value: 'one', label: 'One')],
    );
    final slider = RemixSlider(
      value: 0.5,
      onChanged: (value) {},
      onChangeStart: (value) {},
      onChangeEnd: (value) {},
      snapDivisions: 10,
      focusNode: focusNode,
      autofocus: true,
    );
    const progress = RemixProgress(value: 0.5);
    const tabBar = RemixTabBar(child: SizedBox());

    final String buttonLabel = button.label;
    final IconData buttonIcon = iconButton.icon;
    final RemixMenuTrigger menuTrigger = menu.trigger;
    final List<RemixMenuItemData<String>> menuItems = menu.items;
    final List<RemixSelectItem<String>> selectItems = select.items;
    final double sliderValue = slider.value;
    final double progressValue = progress.value;
    final Widget tabBarChild = tabBar.child;
    const compositionalMenuItems = <RemixMenuItemData<String>>[
      RemixMenuLabel(child: Text('Actions')),
      RemixMenuAction(value: 'copy', child: Text('Copy')),
      RemixMenuCheckboxItem(value: 'grid', checked: true, child: Text('Grid')),
      RemixMenuGroup(
        children: [RemixMenuAction(value: 'archive', child: Text('Archive'))],
      ),
      RemixMenuSeparator(),
      RemixMenuRadioGroup(
        value: 'comfortable',
        onChanged: null,
        children: [
          RemixMenuRadioItem(value: 'comfortable', child: Text('Comfortable')),
        ],
      ),
      RemixMenuSubmenu(
        child: Text('More'),
        items: [RemixMenuAction(value: 'settings', child: Text('Settings'))],
      ),
    ];

    expect(badge.label, 'New');
    expect(buttonLabel, 'Save');
    expect(callout.text, 'Saved');
    expect(buttonIcon, Icons.favorite);
    expect(menuTrigger.label, 'Options');
    expect(menuItems, hasLength(2));
    expect(selectItems, hasLength(1));
    expect(compositionalMenuItems, hasLength(7));
    expect(select.items, hasLength(1));
    expect(sliderValue, 0.5);
    expect(slider.snapDivisions, 10);
    expect(progressValue, 0.5);
    expect(progress.max, 1);
    expect(tabBarChild, isA<SizedBox>());
  });

  test('origin main raw specs and styler calls remain source compatible', () {
    const spinner = RemixSpinnerSpec(
      size: 24,
      strokeWidth: 2,
      indicatorColor: Colors.blue,
      trackColor: Colors.grey,
      trackStrokeWidth: 1,
      duration: Duration(seconds: 1),
    );
    const progress = RemixProgressSpec(
      trackContainer: StyleSpec(spec: BoxSpec()),
    );
    const select = RemixSelectSpec(
      menuContainer: StyleSpec(spec: FlexBoxSpec()),
    );
    const tabBar = RemixTabBarSpec(container: StyleSpec(spec: FlexBoxSpec()));
    final slider = RemixSliderSpec(
      trackColor: Colors.grey,
      trackWidth: 4,
      rangeColor: Colors.blue,
      rangeWidth: 6,
    );

    final buttonWidget = ButtonStyler().call(label: 'Save', onPressed: () {});
    final menuWidget = RemixMenuStyler().call<String>(
      trigger: const RemixMenuTrigger(label: 'Options'),
      items: const [RemixMenuItem(value: 'copy', label: 'Copy')],
    );
    final selectWidget = RemixSelectStyler().call<String>(
      trigger: const RemixSelectTrigger(placeholder: 'Choose'),
      items: const [RemixSelectItem(value: 'one', label: 'One')],
    );
    final sliderWidget = RemixSliderStyler().call(
      value: 0.5,
      onChanged: (value) {},
      snapDivisions: 10,
    );
    final tabBarWidget = RemixTabBarStyler().call(child: const SizedBox());
    final generatedSpinner = RemixSpinnerStyler.strokeWidth(
      2,
    ).indicatorColor(Colors.blue);
    final generatedProgress = RemixProgressStyler.trackContainer(
      BoxStyler().color(Colors.black),
    );
    final generatedSelect = RemixSelectStyler.menuContainer(
      FlexBoxStyler().mainAxisSize(.min),
    );
    final generatedSlider = RemixSliderStyler.trackColor(
      Colors.grey,
    ).rangeColor(Colors.blue);
    final generatedSelectContainer = RemixSelectStyler.color(Colors.white);
    final generatedTabBar = RemixTabBarStyler.row().spacing(8);
    final legacyButtonSpinner = ButtonStyler()
        .spinnerIndicatorColor(Colors.blue)
        .spinnerTrackColor(Colors.grey)
        .spinnerStrokeWidth(2)
        .spinnerTrackStrokeWidth(1);
    final legacyDividerThickness = RemixDividerStylerRemixHelpers(
      RemixDividerStyler(),
    ).thickness(1);
    final legacyTabBarFlex = RemixTabBarStyler().flex(
      FlexStyler(mainAxisSize: MainAxisSize.min),
    );
    final legacySliderHelpers = RemixSliderStyler()
        .trackThickness(3)
        .rangeThickness(4);
    final spinnerPainter = RemixSpinnerPainter(
      animation: const AlwaysStoppedAnimation(0),
      strokeWidth: 2,
      indicatorColor: Colors.blue,
      trackColor: Colors.grey,
      trackStrokeWidth: 1,
    );
    final spinnerWidget = createSpinnerWidget(spinner);

    expect(spinner.indicatorColor, Colors.blue);
    expect(progress.trackContainer.spec, isA<BoxSpec>());
    expect(select.menuContainer.spec, isA<FlexBoxSpec>());
    expect(tabBar.container.spec, isA<FlexBoxSpec>());
    expect(slider.rangeWidth, 6);
    expect(buttonWidget.label, 'Save');
    expect(menuWidget.items, hasLength(1));
    expect(selectWidget.items, hasLength(1));
    expect(sliderWidget.value, 0.5);
    expect(tabBarWidget.child, isA<SizedBox>());
    expect(generatedSpinner, isA<RemixSpinnerStyler>());
    expect(generatedProgress, isA<RemixProgressStyler>());
    expect(generatedSelect, isA<RemixSelectStyler>());
    expect(generatedSlider, isA<RemixSliderStyler>());
    expect(generatedSelectContainer, isA<RemixSelectStyler>());
    expect(generatedTabBar, isA<RemixTabBarStyler>());
    expect(legacyButtonSpinner, isA<ButtonStyler>());
    expect(legacyDividerThickness, isA<RemixDividerStyler>());
    expect(legacyTabBarFlex, isA<RemixTabBarStyler>());
    expect(legacySliderHelpers, isA<RemixSliderStyler>());
    expect(RemixSliderSpec.defaultTrackStrokeWidth, 8);
    expect(spinnerPainter.strokeWidth, 2);
    expect(spinnerWidget, isA<Widget>());
  });

  test('origin main Fortal wrapper APIs remain source compatible', () {
    final button = FortalButton.solid(label: 'Save', onPressed: () {});
    const badge = FortalBadge.soft(label: 'New');
    const callout = FortalCallout.soft(text: 'Saved', icon: Icons.info);
    final iconButton = FortalIconButton.solid(
      icon: Icons.favorite,
      onPressed: () {},
    );
    const menu = FortalMenu<String>.solid(
      trigger: RemixMenuTrigger(label: 'Options'),
      items: [RemixMenuItem(value: 'copy', label: 'Copy')],
    );
    const select = FortalSelect<String>.surface(
      trigger: RemixSelectTrigger(placeholder: 'Choose'),
      items: [RemixSelectItem(value: 'one', label: 'One')],
    );
    const runtimeSelect = FortalSelect<String>(
      variant: FortalSelectVariant.ghost,
      trigger: RemixSelectTrigger(placeholder: 'Choose'),
      items: [RemixSelectItem(value: 'one', label: 'One')],
    );
    final legacySelectStyle = fortalSelectStyler(
      variant: FortalSelectVariant.soft,
    );
    final legacySelectItemStyle = fortalSelectMenuItemStyler(
      variant: FortalSelectVariant.surface,
    );
    final slider = FortalSlider.surface(value: 0.5, onChanged: (value) {});
    const progress = FortalProgress.surface(value: 0.5);
    const tabBar = FortalTabBar(child: SizedBox());
    const checkbox = FortalCheckbox.surface(
      selected: true,
      checkedIcon: Icons.check,
      uncheckedIcon: Icons.close,
      indeterminateIcon: Icons.remove,
    );
    final String buttonLabel = button.label;
    final RemixMenuTrigger menuTrigger = menu.trigger;
    final List<RemixSelectItem<String>> selectItems = select.items;
    final double sliderValue = slider.value;
    final double progressValue = progress.value;
    final Widget tabBarChild = tabBar.child;
    final IconData checkedIcon = checkbox.checkedIcon;
    final IconData? uncheckedIcon = checkbox.uncheckedIcon;
    final IconData indeterminateIcon = checkbox.indeterminateIcon;

    expect(buttonLabel, 'Save');
    expect(badge.label, 'New');
    expect(callout.text, 'Saved');
    expect(iconButton.icon, Icons.favorite);
    expect(menuTrigger.label, 'Options');
    expect(menu.items, hasLength(1));
    expect(selectItems, hasLength(1));
    expect(runtimeSelect.variant, FortalSelectVariant.ghost);
    expect(legacySelectStyle, isA<RemixSelectStyler>());
    expect(legacySelectItemStyle, isA<RemixSelectMenuItemStyler>());
    expect(sliderValue, 0.5);
    expect(progressValue, 0.5);
    expect(tabBarChild, isA<SizedBox>());
    expect(checkedIcon, Icons.check);
    expect(uncheckedIcon, Icons.close);
    expect(indeterminateIcon, Icons.remove);
  });

  test('origin main Fortal theme API remains source compatible', () {
    const config = FortalThemeConfig(
      accent: FortalAccentColor.mauve,
      gray: FortalGrayColor.slate,
      brightness: Brightness.dark,
    );
    final copied = config.copyWith(
      accent: FortalAccentColor.sage,
      gray: FortalGrayColor.olive,
      brightness: Brightness.light,
    );
    const scope = FortalScope(
      accent: FortalAccentColor.sand,
      gray: FortalGrayColor.gray,
      brightness: Brightness.light,
      child: SizedBox(),
    );
    final BoxShadowToken shadow1 = FortalTokens.shadow1;
    final colors = resolveFortalTokens(config);

    expect(config.accent, FortalAccentColor.mauve);
    expect(config.gray, FortalGrayColor.slate);
    expect(config.brightness, Brightness.dark);
    expect(config.isDark, isTrue);
    expect(copied.accent, FortalAccentColor.sage);
    expect(scope.accent, FortalAccentColor.sand);
    expect(scope.gray, FortalGrayColor.gray);
    expect(scope.brightness, Brightness.light);
    expect(shadow1, isA<BoxShadowToken>());
    expect(colors, isA<FortalThemeColors>());
  });
}
