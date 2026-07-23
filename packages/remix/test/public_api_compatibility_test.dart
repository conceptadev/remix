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

    expect(badge.label, 'New');
    expect(button.label, 'Save');
    expect(callout.text, 'Saved');
    expect(iconButton.icon, Icons.favorite);
    expect(menu.items, hasLength(2));
    expect(select.items, hasLength(1));
    expect(slider.value, 0.5);
    expect(slider.snapDivisions, 10);
    expect(progress.max, 1);
    expect(tabBar.child, isA<SizedBox>());
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

    expect(button.label, 'Save');
    expect(badge.label, 'New');
    expect(callout.text, 'Saved');
    expect(iconButton.icon, Icons.favorite);
    expect(menu.items, hasLength(1));
    expect(select.items, hasLength(1));
    expect(runtimeSelect.variant, FortalSelectVariant.ghost);
    expect(legacySelectStyle, isA<RemixSelectStyler>());
    expect(legacySelectItemStyle, isA<RemixSelectMenuItemStyler>());
    expect(slider.value, 0.5);
    expect(progress.value, 0.5);
    expect(tabBar.child, isA<SizedBox>());
  });
}
