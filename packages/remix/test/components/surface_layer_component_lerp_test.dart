import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  const beginLayer = RemixSurfaceLayerSpec(color: Colors.red);
  const endLayer = RemixSurfaceLayerSpec(color: Colors.blue);

  final badgeBegin = RemixBadgeSpec(surface: beginLayer, overlay: beginLayer);
  final badgeEnd = RemixBadgeSpec(surface: endLayer, overlay: endLayer);
  final buttonBegin = RemixButtonSpec(surface: beginLayer, overlay: beginLayer);
  final buttonEnd = RemixButtonSpec(surface: endLayer, overlay: endLayer);
  final calloutBegin = RemixCalloutSpec(
    surface: beginLayer,
    overlay: beginLayer,
  );
  final calloutEnd = RemixCalloutSpec(surface: endLayer, overlay: endLayer);
  final cardBegin = RemixCardSpec(surface: beginLayer, overlay: beginLayer);
  final cardEnd = RemixCardSpec(surface: endLayer, overlay: endLayer);
  final checkboxBegin = RemixCheckboxSpec(
    surface: beginLayer,
    overlay: beginLayer,
  );
  final checkboxEnd = RemixCheckboxSpec(surface: endLayer, overlay: endLayer);
  final dialogBegin = RemixDialogSpec(surface: beginLayer);
  final dialogEnd = RemixDialogSpec(surface: endLayer);
  final iconButtonBegin = RemixIconButtonSpec(
    surface: beginLayer,
    overlay: beginLayer,
  );
  final iconButtonEnd = RemixIconButtonSpec(
    surface: endLayer,
    overlay: endLayer,
  );
  final menuBegin = RemixMenuSpec(surface: beginLayer);
  final menuEnd = RemixMenuSpec(surface: endLayer);
  final popoverBegin = RemixPopoverSpec(surface: beginLayer);
  final popoverEnd = RemixPopoverSpec(surface: endLayer);
  final progressBegin = RemixProgressSpec(
    surface: beginLayer,
    overlay: beginLayer,
    indicatorSurface: beginLayer,
    indicatorOverlay: beginLayer,
  );
  final progressEnd = RemixProgressSpec(
    surface: endLayer,
    overlay: endLayer,
    indicatorSurface: endLayer,
    indicatorOverlay: endLayer,
  );
  final radioBegin = RemixRadioSpec(surface: beginLayer, overlay: beginLayer);
  final radioEnd = RemixRadioSpec(surface: endLayer, overlay: endLayer);
  final selectTriggerBegin = RemixSelectTriggerSpec(
    surface: beginLayer,
    overlay: beginLayer,
  );
  final selectTriggerEnd = RemixSelectTriggerSpec(
    surface: endLayer,
    overlay: endLayer,
  );
  final selectContentBegin = RemixSelectContentSpec(surface: beginLayer);
  final selectContentEnd = RemixSelectContentSpec(surface: endLayer);
  final sliderBegin = RemixSliderSpec(
    trackSurface: beginLayer,
    trackOverlay: beginLayer,
    rangeSurface: beginLayer,
    rangeOverlay: beginLayer,
    thumbSurface: beginLayer,
    thumbOverlay: beginLayer,
    thumbFocusOverlay: beginLayer,
  );
  final sliderEnd = RemixSliderSpec(
    trackSurface: endLayer,
    trackOverlay: endLayer,
    rangeSurface: endLayer,
    rangeOverlay: endLayer,
    thumbSurface: endLayer,
    thumbOverlay: endLayer,
    thumbFocusOverlay: endLayer,
  );
  final switchBegin = RemixSwitchSpec(
    surface: beginLayer,
    overlay: beginLayer,
    thumbSurface: beginLayer,
    thumbOverlay: beginLayer,
  );
  final switchEnd = RemixSwitchSpec(
    surface: endLayer,
    overlay: endLayer,
    thumbSurface: endLayer,
    thumbOverlay: endLayer,
  );
  final textFieldBegin = RemixTextFieldSpec(
    surface: beginLayer,
    overlay: beginLayer,
  );
  final textFieldEnd = RemixTextFieldSpec(surface: endLayer, overlay: endLayer);

  final cases = <String, RemixSurfaceLayerSpec? Function(double)>{
    'badge surface': (t) => badgeBegin.lerp(badgeEnd, t).surface,
    'badge overlay': (t) => badgeBegin.lerp(badgeEnd, t).overlay,
    'button surface': (t) => buttonBegin.lerp(buttonEnd, t).surface,
    'button overlay': (t) => buttonBegin.lerp(buttonEnd, t).overlay,
    'callout surface': (t) => calloutBegin.lerp(calloutEnd, t).surface,
    'callout overlay': (t) => calloutBegin.lerp(calloutEnd, t).overlay,
    'card surface': (t) => cardBegin.lerp(cardEnd, t).surface,
    'card overlay': (t) => cardBegin.lerp(cardEnd, t).overlay,
    'checkbox surface': (t) => checkboxBegin.lerp(checkboxEnd, t).surface,
    'checkbox overlay': (t) => checkboxBegin.lerp(checkboxEnd, t).overlay,
    'dialog surface': (t) => dialogBegin.lerp(dialogEnd, t).surface,
    'icon button surface': (t) =>
        iconButtonBegin.lerp(iconButtonEnd, t).surface,
    'icon button overlay': (t) =>
        iconButtonBegin.lerp(iconButtonEnd, t).overlay,
    'menu surface': (t) => menuBegin.lerp(menuEnd, t).surface,
    'popover surface': (t) => popoverBegin.lerp(popoverEnd, t).surface,
    'progress surface': (t) => progressBegin.lerp(progressEnd, t).surface,
    'progress overlay': (t) => progressBegin.lerp(progressEnd, t).overlay,
    'progress indicator surface': (t) =>
        progressBegin.lerp(progressEnd, t).indicatorSurface,
    'progress indicator overlay': (t) =>
        progressBegin.lerp(progressEnd, t).indicatorOverlay,
    'radio surface': (t) => radioBegin.lerp(radioEnd, t).surface,
    'radio overlay': (t) => radioBegin.lerp(radioEnd, t).overlay,
    'select trigger surface': (t) =>
        selectTriggerBegin.lerp(selectTriggerEnd, t).surface,
    'select trigger overlay': (t) =>
        selectTriggerBegin.lerp(selectTriggerEnd, t).overlay,
    'select content surface': (t) =>
        selectContentBegin.lerp(selectContentEnd, t).surface,
    'slider track surface': (t) => sliderBegin.lerp(sliderEnd, t).trackSurface,
    'slider track overlay': (t) => sliderBegin.lerp(sliderEnd, t).trackOverlay,
    'slider range surface': (t) => sliderBegin.lerp(sliderEnd, t).rangeSurface,
    'slider range overlay': (t) => sliderBegin.lerp(sliderEnd, t).rangeOverlay,
    'slider thumb surface': (t) => sliderBegin.lerp(sliderEnd, t).thumbSurface,
    'slider thumb overlay': (t) => sliderBegin.lerp(sliderEnd, t).thumbOverlay,
    'slider thumb focus overlay': (t) =>
        sliderBegin.lerp(sliderEnd, t).thumbFocusOverlay,
    'switch surface': (t) => switchBegin.lerp(switchEnd, t).surface,
    'switch overlay': (t) => switchBegin.lerp(switchEnd, t).overlay,
    'switch thumb surface': (t) => switchBegin.lerp(switchEnd, t).thumbSurface,
    'switch thumb overlay': (t) => switchBegin.lerp(switchEnd, t).thumbOverlay,
    'text field surface': (t) => textFieldBegin.lerp(textFieldEnd, t).surface,
    'text field overlay': (t) => textFieldBegin.lerp(textFieldEnd, t).overlay,
  };

  for (final entry in cases.entries) {
    test('${entry.key} interpolates instead of snapping', () {
      expect(
        entry.value(0.25)?.color,
        Color.lerp(Colors.red, Colors.blue, 0.25),
      );
    });
  }
}
