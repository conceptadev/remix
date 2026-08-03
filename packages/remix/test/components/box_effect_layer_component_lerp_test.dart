import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  const beginLayer = RemixBoxEffectLayerSpec(
    shadows: [RemixBoxShadow(color: Colors.red)],
  );
  const endLayer = RemixBoxEffectLayerSpec(
    shadows: [RemixBoxShadow(color: Colors.blue)],
  );

  final badgeBegin = BadgeSpec(
    containerEffects: RemixBoxEffectsSpec(
      behindContent: beginLayer,
      overContent: beginLayer,
    ),
  );
  final badgeEnd = BadgeSpec(
    containerEffects: RemixBoxEffectsSpec(
      behindContent: endLayer,
      overContent: endLayer,
    ),
  );
  final buttonBegin = ButtonSpec(
    containerEffects: RemixBoxEffectsSpec(
      behindContent: beginLayer,
      overContent: beginLayer,
    ),
  );
  final buttonEnd = ButtonSpec(
    containerEffects: RemixBoxEffectsSpec(
      behindContent: endLayer,
      overContent: endLayer,
    ),
  );
  final calloutBegin = CalloutSpec(
    containerEffects: RemixBoxEffectsSpec(
      behindContent: beginLayer,
      overContent: beginLayer,
    ),
  );
  final calloutEnd = CalloutSpec(
    containerEffects: RemixBoxEffectsSpec(
      behindContent: endLayer,
      overContent: endLayer,
    ),
  );
  final cardBegin = CardSpec(
    containerEffects: RemixBoxEffectsSpec(
      behindContent: beginLayer,
      overContent: beginLayer,
    ),
  );
  final cardEnd = CardSpec(
    containerEffects: RemixBoxEffectsSpec(
      behindContent: endLayer,
      overContent: endLayer,
    ),
  );
  final checkboxBegin = CheckboxSpec(
    containerEffects: RemixBoxEffectsSpec(
      behindContent: beginLayer,
      overContent: beginLayer,
    ),
  );
  final checkboxEnd = CheckboxSpec(
    containerEffects: RemixBoxEffectsSpec(
      behindContent: endLayer,
      overContent: endLayer,
    ),
  );
  final dialogBegin = DialogSpec(
    containerEffects: RemixBoxEffectsSpec(behindContent: beginLayer),
  );
  final dialogEnd = DialogSpec(
    containerEffects: RemixBoxEffectsSpec(behindContent: endLayer),
  );
  final iconButtonBegin = IconButtonSpec(
    containerEffects: RemixBoxEffectsSpec(
      behindContent: beginLayer,
      overContent: beginLayer,
    ),
  );
  final iconButtonEnd = IconButtonSpec(
    containerEffects: RemixBoxEffectsSpec(
      behindContent: endLayer,
      overContent: endLayer,
    ),
  );
  final menuBegin = MenuSpec(
    containerEffects: RemixBoxEffectsSpec(behindContent: beginLayer),
  );
  final menuEnd = MenuSpec(
    containerEffects: RemixBoxEffectsSpec(behindContent: endLayer),
  );
  final popoverBegin = PopoverSpec(
    containerEffects: RemixBoxEffectsSpec(behindContent: beginLayer),
  );
  final popoverEnd = PopoverSpec(
    containerEffects: RemixBoxEffectsSpec(behindContent: endLayer),
  );
  final progressBegin = ProgressSpec(
    trackEffects: RemixBoxEffectsSpec(
      behindContent: beginLayer,
      overContent: beginLayer,
    ),
    indicatorEffects: RemixBoxEffectsSpec(
      behindContent: beginLayer,
      overContent: beginLayer,
    ),
  );
  final progressEnd = ProgressSpec(
    trackEffects: RemixBoxEffectsSpec(
      behindContent: endLayer,
      overContent: endLayer,
    ),
    indicatorEffects: RemixBoxEffectsSpec(
      behindContent: endLayer,
      overContent: endLayer,
    ),
  );
  final radioBegin = RadioSpec(
    containerEffects: RemixBoxEffectsSpec(
      behindContent: beginLayer,
      overContent: beginLayer,
    ),
  );
  final radioEnd = RadioSpec(
    containerEffects: RemixBoxEffectsSpec(
      behindContent: endLayer,
      overContent: endLayer,
    ),
  );
  final selectTriggerBegin = SelectTriggerSpec(
    containerEffects: RemixBoxEffectsSpec(
      behindContent: beginLayer,
      overContent: beginLayer,
    ),
  );
  final selectTriggerEnd = SelectTriggerSpec(
    containerEffects: RemixBoxEffectsSpec(
      behindContent: endLayer,
      overContent: endLayer,
    ),
  );
  final selectContentBegin = SelectContentSpec(
    containerEffects: RemixBoxEffectsSpec(behindContent: beginLayer),
  );
  final selectContentEnd = SelectContentSpec(
    containerEffects: RemixBoxEffectsSpec(behindContent: endLayer),
  );
  final sliderBegin = SliderSpec(
    trackEffects: RemixBoxEffectsSpec(
      behindContent: beginLayer,
      overContent: beginLayer,
    ),
    rangeEffects: RemixBoxEffectsSpec(
      behindContent: beginLayer,
      overContent: beginLayer,
    ),
    thumbEffects: RemixBoxEffectsSpec(
      behindContent: beginLayer,
      overContent: beginLayer,
    ),
    thumbFocusEffects: RemixBoxEffectsSpec(overContent: beginLayer),
  );
  final sliderEnd = SliderSpec(
    trackEffects: RemixBoxEffectsSpec(
      behindContent: endLayer,
      overContent: endLayer,
    ),
    rangeEffects: RemixBoxEffectsSpec(
      behindContent: endLayer,
      overContent: endLayer,
    ),
    thumbEffects: RemixBoxEffectsSpec(
      behindContent: endLayer,
      overContent: endLayer,
    ),
    thumbFocusEffects: RemixBoxEffectsSpec(overContent: endLayer),
  );
  final switchBegin = SwitchSpec(
    trackEffects: RemixBoxEffectsSpec(
      behindContent: beginLayer,
      overContent: beginLayer,
    ),
    thumbEffects: RemixBoxEffectsSpec(
      behindContent: beginLayer,
      overContent: beginLayer,
    ),
  );
  final switchEnd = SwitchSpec(
    trackEffects: RemixBoxEffectsSpec(
      behindContent: endLayer,
      overContent: endLayer,
    ),
    thumbEffects: RemixBoxEffectsSpec(
      behindContent: endLayer,
      overContent: endLayer,
    ),
  );
  final textFieldBegin = TextFieldSpec(
    containerEffects: RemixBoxEffectsSpec(
      behindContent: beginLayer,
      overContent: beginLayer,
    ),
  );
  final textFieldEnd = TextFieldSpec(
    containerEffects: RemixBoxEffectsSpec(
      behindContent: endLayer,
      overContent: endLayer,
    ),
  );

  final cases = <String, RemixBoxEffectLayerSpec? Function(double)>{
    'badge surface': (t) =>
        badgeBegin.lerp(badgeEnd, t).containerEffects?.behindContent,
    'badge overlay': (t) =>
        badgeBegin.lerp(badgeEnd, t).containerEffects?.overContent,
    'button surface': (t) =>
        buttonBegin.lerp(buttonEnd, t).containerEffects?.behindContent,
    'button overlay': (t) =>
        buttonBegin.lerp(buttonEnd, t).containerEffects?.overContent,
    'callout surface': (t) =>
        calloutBegin.lerp(calloutEnd, t).containerEffects?.behindContent,
    'callout overlay': (t) =>
        calloutBegin.lerp(calloutEnd, t).containerEffects?.overContent,
    'card surface': (t) =>
        cardBegin.lerp(cardEnd, t).containerEffects?.behindContent,
    'card overlay': (t) =>
        cardBegin.lerp(cardEnd, t).containerEffects?.overContent,
    'checkbox surface': (t) =>
        checkboxBegin.lerp(checkboxEnd, t).containerEffects?.behindContent,
    'checkbox overlay': (t) =>
        checkboxBegin.lerp(checkboxEnd, t).containerEffects?.overContent,
    'dialog surface': (t) =>
        dialogBegin.lerp(dialogEnd, t).containerEffects?.behindContent,
    'icon button surface': (t) =>
        iconButtonBegin.lerp(iconButtonEnd, t).containerEffects?.behindContent,
    'icon button overlay': (t) =>
        iconButtonBegin.lerp(iconButtonEnd, t).containerEffects?.overContent,
    'menu surface': (t) =>
        menuBegin.lerp(menuEnd, t).containerEffects?.behindContent,
    'popover surface': (t) =>
        popoverBegin.lerp(popoverEnd, t).containerEffects?.behindContent,
    'progress surface': (t) =>
        progressBegin.lerp(progressEnd, t).trackEffects?.behindContent,
    'progress overlay': (t) =>
        progressBegin.lerp(progressEnd, t).trackEffects?.overContent,
    'progress indicator surface': (t) =>
        progressBegin.lerp(progressEnd, t).indicatorEffects?.behindContent,
    'progress indicator overlay': (t) =>
        progressBegin.lerp(progressEnd, t).indicatorEffects?.overContent,
    'radio surface': (t) =>
        radioBegin.lerp(radioEnd, t).containerEffects?.behindContent,
    'radio overlay': (t) =>
        radioBegin.lerp(radioEnd, t).containerEffects?.overContent,
    'select trigger surface': (t) => selectTriggerBegin
        .lerp(selectTriggerEnd, t)
        .containerEffects
        ?.behindContent,
    'select trigger overlay': (t) => selectTriggerBegin
        .lerp(selectTriggerEnd, t)
        .containerEffects
        ?.overContent,
    'select content surface': (t) => selectContentBegin
        .lerp(selectContentEnd, t)
        .containerEffects
        ?.behindContent,
    'slider track surface': (t) =>
        sliderBegin.lerp(sliderEnd, t).trackEffects?.behindContent,
    'slider track overlay': (t) =>
        sliderBegin.lerp(sliderEnd, t).trackEffects?.overContent,
    'slider range surface': (t) =>
        sliderBegin.lerp(sliderEnd, t).rangeEffects?.behindContent,
    'slider range overlay': (t) =>
        sliderBegin.lerp(sliderEnd, t).rangeEffects?.overContent,
    'slider thumb surface': (t) =>
        sliderBegin.lerp(sliderEnd, t).thumbEffects?.behindContent,
    'slider thumb overlay': (t) =>
        sliderBegin.lerp(sliderEnd, t).thumbEffects?.overContent,
    'slider thumb focus overlay': (t) =>
        sliderBegin.lerp(sliderEnd, t).thumbFocusEffects?.overContent,
    'switch surface': (t) =>
        switchBegin.lerp(switchEnd, t).trackEffects?.behindContent,
    'switch overlay': (t) =>
        switchBegin.lerp(switchEnd, t).trackEffects?.overContent,
    'switch thumb surface': (t) =>
        switchBegin.lerp(switchEnd, t).thumbEffects?.behindContent,
    'switch thumb overlay': (t) =>
        switchBegin.lerp(switchEnd, t).thumbEffects?.overContent,
    'text field surface': (t) =>
        textFieldBegin.lerp(textFieldEnd, t).containerEffects?.behindContent,
    'text field overlay': (t) =>
        textFieldBegin.lerp(textFieldEnd, t).containerEffects?.overContent,
  };

  for (final entry in cases.entries) {
    test('${entry.key} interpolates instead of snapping', () {
      expect(
        entry.value(0.25)?.shadows.first.color,
        Color.lerp(Colors.red, Colors.blue, 0.25),
      );
    });
  }
}
