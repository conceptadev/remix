import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  const beginLayer = RemixSurfaceLayerSpec(
    shadows: [RemixPaintShadow(color: Colors.red)],
  );
  const endLayer = RemixSurfaceLayerSpec(
    shadows: [RemixPaintShadow(color: Colors.blue)],
  );

  final badgeBegin = RemixBadgeSpec(
    effects: RemixSurfaceEffectsSpec(
      background: beginLayer,
      foreground: beginLayer,
    ),
  );
  final badgeEnd = RemixBadgeSpec(
    effects: RemixSurfaceEffectsSpec(
      background: endLayer,
      foreground: endLayer,
    ),
  );
  final buttonBegin = RemixButtonSpec(
    effects: RemixSurfaceEffectsSpec(
      background: beginLayer,
      foreground: beginLayer,
    ),
  );
  final buttonEnd = RemixButtonSpec(
    effects: RemixSurfaceEffectsSpec(
      background: endLayer,
      foreground: endLayer,
    ),
  );
  final calloutBegin = RemixCalloutSpec(
    effects: RemixSurfaceEffectsSpec(
      background: beginLayer,
      foreground: beginLayer,
    ),
  );
  final calloutEnd = RemixCalloutSpec(
    effects: RemixSurfaceEffectsSpec(
      background: endLayer,
      foreground: endLayer,
    ),
  );
  final cardBegin = RemixCardSpec(
    effects: RemixSurfaceEffectsSpec(
      background: beginLayer,
      foreground: beginLayer,
    ),
  );
  final cardEnd = RemixCardSpec(
    effects: RemixSurfaceEffectsSpec(
      background: endLayer,
      foreground: endLayer,
    ),
  );
  final checkboxBegin = RemixCheckboxSpec(
    effects: RemixSurfaceEffectsSpec(
      background: beginLayer,
      foreground: beginLayer,
    ),
  );
  final checkboxEnd = RemixCheckboxSpec(
    effects: RemixSurfaceEffectsSpec(
      background: endLayer,
      foreground: endLayer,
    ),
  );
  final dialogBegin = RemixDialogSpec(
    effects: RemixSurfaceEffectsSpec(background: beginLayer),
  );
  final dialogEnd = RemixDialogSpec(
    effects: RemixSurfaceEffectsSpec(background: endLayer),
  );
  final iconButtonBegin = RemixIconButtonSpec(
    effects: RemixSurfaceEffectsSpec(
      background: beginLayer,
      foreground: beginLayer,
    ),
  );
  final iconButtonEnd = RemixIconButtonSpec(
    effects: RemixSurfaceEffectsSpec(
      background: endLayer,
      foreground: endLayer,
    ),
  );
  final menuBegin = RemixMenuSpec(
    effects: RemixSurfaceEffectsSpec(background: beginLayer),
  );
  final menuEnd = RemixMenuSpec(
    effects: RemixSurfaceEffectsSpec(background: endLayer),
  );
  final popoverBegin = RemixPopoverSpec(
    effects: RemixSurfaceEffectsSpec(background: beginLayer),
  );
  final popoverEnd = RemixPopoverSpec(
    effects: RemixSurfaceEffectsSpec(background: endLayer),
  );
  final progressBegin = RemixProgressSpec(
    trackEffects: RemixSurfaceEffectsSpec(
      background: beginLayer,
      foreground: beginLayer,
    ),
    indicatorEffects: RemixSurfaceEffectsSpec(
      background: beginLayer,
      foreground: beginLayer,
    ),
  );
  final progressEnd = RemixProgressSpec(
    trackEffects: RemixSurfaceEffectsSpec(
      background: endLayer,
      foreground: endLayer,
    ),
    indicatorEffects: RemixSurfaceEffectsSpec(
      background: endLayer,
      foreground: endLayer,
    ),
  );
  final radioBegin = RemixRadioSpec(
    effects: RemixSurfaceEffectsSpec(
      background: beginLayer,
      foreground: beginLayer,
    ),
  );
  final radioEnd = RemixRadioSpec(
    effects: RemixSurfaceEffectsSpec(
      background: endLayer,
      foreground: endLayer,
    ),
  );
  final selectTriggerBegin = RemixSelectTriggerSpec(
    effects: RemixSurfaceEffectsSpec(
      background: beginLayer,
      foreground: beginLayer,
    ),
  );
  final selectTriggerEnd = RemixSelectTriggerSpec(
    effects: RemixSurfaceEffectsSpec(
      background: endLayer,
      foreground: endLayer,
    ),
  );
  final selectContentBegin = RemixSelectContentSpec(
    effects: RemixSurfaceEffectsSpec(background: beginLayer),
  );
  final selectContentEnd = RemixSelectContentSpec(
    effects: RemixSurfaceEffectsSpec(background: endLayer),
  );
  final sliderBegin = RemixSliderSpec(
    trackEffects: RemixSurfaceEffectsSpec(
      background: beginLayer,
      foreground: beginLayer,
    ),
    rangeEffects: RemixSurfaceEffectsSpec(
      background: beginLayer,
      foreground: beginLayer,
    ),
    thumbEffects: RemixSurfaceEffectsSpec(
      background: beginLayer,
      foreground: beginLayer,
    ),
    thumbFocusEffects: RemixSurfaceEffectsSpec(foreground: beginLayer),
  );
  final sliderEnd = RemixSliderSpec(
    trackEffects: RemixSurfaceEffectsSpec(
      background: endLayer,
      foreground: endLayer,
    ),
    rangeEffects: RemixSurfaceEffectsSpec(
      background: endLayer,
      foreground: endLayer,
    ),
    thumbEffects: RemixSurfaceEffectsSpec(
      background: endLayer,
      foreground: endLayer,
    ),
    thumbFocusEffects: RemixSurfaceEffectsSpec(foreground: endLayer),
  );
  final switchBegin = RemixSwitchSpec(
    trackEffects: RemixSurfaceEffectsSpec(
      background: beginLayer,
      foreground: beginLayer,
    ),
    thumbEffects: RemixSurfaceEffectsSpec(
      background: beginLayer,
      foreground: beginLayer,
    ),
  );
  final switchEnd = RemixSwitchSpec(
    trackEffects: RemixSurfaceEffectsSpec(
      background: endLayer,
      foreground: endLayer,
    ),
    thumbEffects: RemixSurfaceEffectsSpec(
      background: endLayer,
      foreground: endLayer,
    ),
  );
  final textFieldBegin = RemixTextFieldSpec(
    effects: RemixSurfaceEffectsSpec(
      background: beginLayer,
      foreground: beginLayer,
    ),
  );
  final textFieldEnd = RemixTextFieldSpec(
    effects: RemixSurfaceEffectsSpec(
      background: endLayer,
      foreground: endLayer,
    ),
  );

  final cases = <String, RemixSurfaceLayerSpec? Function(double)>{
    'badge surface': (t) => badgeBegin.lerp(badgeEnd, t).effects?.background,
    'badge overlay': (t) => badgeBegin.lerp(badgeEnd, t).effects?.foreground,
    'button surface': (t) => buttonBegin.lerp(buttonEnd, t).effects?.background,
    'button overlay': (t) => buttonBegin.lerp(buttonEnd, t).effects?.foreground,
    'callout surface': (t) =>
        calloutBegin.lerp(calloutEnd, t).effects?.background,
    'callout overlay': (t) =>
        calloutBegin.lerp(calloutEnd, t).effects?.foreground,
    'card surface': (t) => cardBegin.lerp(cardEnd, t).effects?.background,
    'card overlay': (t) => cardBegin.lerp(cardEnd, t).effects?.foreground,
    'checkbox surface': (t) =>
        checkboxBegin.lerp(checkboxEnd, t).effects?.background,
    'checkbox overlay': (t) =>
        checkboxBegin.lerp(checkboxEnd, t).effects?.foreground,
    'dialog surface': (t) => dialogBegin.lerp(dialogEnd, t).effects?.background,
    'icon button surface': (t) =>
        iconButtonBegin.lerp(iconButtonEnd, t).effects?.background,
    'icon button overlay': (t) =>
        iconButtonBegin.lerp(iconButtonEnd, t).effects?.foreground,
    'menu surface': (t) => menuBegin.lerp(menuEnd, t).effects?.background,
    'popover surface': (t) =>
        popoverBegin.lerp(popoverEnd, t).effects?.background,
    'progress surface': (t) =>
        progressBegin.lerp(progressEnd, t).trackEffects?.background,
    'progress overlay': (t) =>
        progressBegin.lerp(progressEnd, t).trackEffects?.foreground,
    'progress indicator surface': (t) =>
        progressBegin.lerp(progressEnd, t).indicatorEffects?.background,
    'progress indicator overlay': (t) =>
        progressBegin.lerp(progressEnd, t).indicatorEffects?.foreground,
    'radio surface': (t) => radioBegin.lerp(radioEnd, t).effects?.background,
    'radio overlay': (t) => radioBegin.lerp(radioEnd, t).effects?.foreground,
    'select trigger surface': (t) =>
        selectTriggerBegin.lerp(selectTriggerEnd, t).effects?.background,
    'select trigger overlay': (t) =>
        selectTriggerBegin.lerp(selectTriggerEnd, t).effects?.foreground,
    'select content surface': (t) =>
        selectContentBegin.lerp(selectContentEnd, t).effects?.background,
    'slider track surface': (t) =>
        sliderBegin.lerp(sliderEnd, t).trackEffects?.background,
    'slider track overlay': (t) =>
        sliderBegin.lerp(sliderEnd, t).trackEffects?.foreground,
    'slider range surface': (t) =>
        sliderBegin.lerp(sliderEnd, t).rangeEffects?.background,
    'slider range overlay': (t) =>
        sliderBegin.lerp(sliderEnd, t).rangeEffects?.foreground,
    'slider thumb surface': (t) =>
        sliderBegin.lerp(sliderEnd, t).thumbEffects?.background,
    'slider thumb overlay': (t) =>
        sliderBegin.lerp(sliderEnd, t).thumbEffects?.foreground,
    'slider thumb focus overlay': (t) =>
        sliderBegin.lerp(sliderEnd, t).thumbFocusEffects?.foreground,
    'switch surface': (t) =>
        switchBegin.lerp(switchEnd, t).trackEffects?.background,
    'switch overlay': (t) =>
        switchBegin.lerp(switchEnd, t).trackEffects?.foreground,
    'switch thumb surface': (t) =>
        switchBegin.lerp(switchEnd, t).thumbEffects?.background,
    'switch thumb overlay': (t) =>
        switchBegin.lerp(switchEnd, t).thumbEffects?.foreground,
    'text field surface': (t) =>
        textFieldBegin.lerp(textFieldEnd, t).effects?.background,
    'text field overlay': (t) =>
        textFieldBegin.lerp(textFieldEnd, t).effects?.foreground,
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
