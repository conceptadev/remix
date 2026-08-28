import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/tokens.dart';

part 'switch.g.dart';

/// The control densities this application offers for a switch.
///
/// A switch is wider than it is tall, so these name the track height; the
/// width follows from it at a fixed ratio.
enum PlaygroundSwitchSize {
  /// A 16px track.
  small,

  /// A 20px track. The default.
  medium,

  /// A 24px track.
  large,
}

/// The application's Switch recipe.
///
/// Remix owns the rendering, the toggle behavior, the switch accessibility
/// role, and — importantly — the thumb's travel: it aligns the thumb to the
/// leading edge when off and the trailing edge when on. This recipe supplies
/// only the two boxes' geometry and their colors.
///
/// `RemixSwitch` requires a `semanticLabel` because a switch has no visible
/// text of its own. That is a Remix rule, not a recipe choice.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it. State fragments merge by state, not
/// by depth: an override that must beat the recipe's on-track has to be
/// declared as a selected fragment too (`SwitchStyler().onSelected(...)`).
@MixWidget(target: RemixSwitch.new)
SwitchStyler playgroundSwitchStyle({
  PlaygroundSwitchSize size = .medium,
  SwitchStyler style = const SwitchStyler.create(),
}) {
  final metrics = _metricsFor(size);

  return SwitchStyler()
      .size(metrics.trackHeight * _trackRatio, metrics.trackHeight)
      .padding(.all(_thumbInset))
      .borderRadius(.all(_pill))
      .trackColor(PlaygroundTokens.muted())
      .thumb(
        BoxStyler()
            .size(metrics.thumbSize, metrics.thumbSize)
            .borderRadius(.all(_pill))
            .color(PlaygroundTokens.background()),
      )
      .onSelected(SwitchStyler().trackColor(PlaygroundTokens.primary()))
      .onFocusVisible(_focusVisibleStyle())
      .onDisabled(_disabledStyle())
      .merge(style);
}

/// Track width as a multiple of its height.
///
/// Under 2 the thumb has nowhere to travel and the control stops reading as a
/// switch; well over 2 it reads as a slider.
const _trackRatio = 1.8;

/// Gap between the track edge and the thumb, on every side.
const _thumbInset = 2.0;

/// A radius large enough to round any track or thumb in this scale.
const _pill = Radius.circular(999);

/// Width of the keyboard focus ring.
const _focusRingWidth = 2.0;

/// Distance between the track edge and its focus ring.
const _focusRingOffset = 2.0;

/// Opacity applied to the whole control while disabled.
const _disabledOpacity = 0.5;

/// Geometry for one [PlaygroundSwitchSize].
///
/// The thumb is the track height minus the inset on both sides, so it always
/// sits flush inside the track.
typedef _PlaygroundSwitchMetrics = ({double trackHeight, double thumbSize});

_PlaygroundSwitchMetrics _metricsFor(PlaygroundSwitchSize size) {
  final trackHeight = switch (size) {
    .small => 16.0,
    .medium => 20.0,
    .large => 24.0,
  };

  return (trackHeight: trackHeight, thumbSize: trackHeight - _thumbInset * 2);
}

/// The keyboard focus ring.
///
/// An outline rather than a border: `RemixBoxEffects` paints it outside the
/// track without taking layout space, so focusing a switch never reflows the
/// row it sits in.
SwitchStyler _focusVisibleStyle() => SwitchStyler().trackEffects(
  RemixBoxEffectsMix(
    outline: BorderSideMix(
      color: PlaygroundTokens.focusRing(),
      width: _focusRingWidth,
      strokeAlign: BorderSide.strokeAlignInside,
    ),
    outlineOffset: _focusRingOffset,
  ),
);

/// Declared last so it wins over every other state fragment.
///
/// A disabled switch keeps whatever track its state gives it and simply
/// fades; the focus ring is cleared because a disabled control that still
/// draws a focus ring reads as actionable.
SwitchStyler _disabledStyle() => SwitchStyler()
    .trackEffects(
      RemixBoxEffectsMix.outline(BorderSideMix(style: BorderStyle.none)),
    )
    .wrap(WidgetModifierConfig.opacity(_disabledOpacity));
