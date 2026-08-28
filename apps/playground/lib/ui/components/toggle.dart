import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/tokens.dart';

part 'toggle.g.dart';

/// The visual weights this application offers for a toggle.
enum PlaygroundToggleVariant {
  /// No fill and no border until the toggle is hovered or on.
  ghost,

  /// A hairline `border`, so the control is visible while off.
  outline,
}

/// The control densities this application offers for a toggle.
///
/// The same 32/36/40px heights the button uses, because a toggle usually sits
/// in a row beside one.
///
/// These are compact, web-oriented defaults. A touch-first application should
/// raise them to meet platform hit-target guidance.
enum PlaygroundToggleSize {
  /// 32px minimum height.
  small,

  /// 36px minimum height. The default.
  medium,

  /// 40px minimum height.
  large,
}

/// The application's Toggle recipe.
///
/// A toggle is a button that stays pressed. Remix owns the rendering, the
/// pointer and keyboard behavior, and the on/off semantics; this recipe owns
/// the geometry and the off/hover/on/focus/disabled fragments.
///
/// The on state is `accent`, the token whose whole job is "this transparent
/// control is doing something", while hover is the quieter `muted`. Keeping
/// them different is what lets a reader tell a toggle they are pointing at
/// from one that is switched on.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it. Because [variant] is a non-nullable
/// enum, the generator also emits one named constructor per enum value.
///
/// State fragments merge by state, not by depth: an override that must beat
/// the recipe's on fill has to be declared as a selected fragment too
/// (`ToggleStyler().onSelected(...)`).
@MixWidget(target: RemixToggle.new)
ToggleStyler playgroundToggleStyle({
  PlaygroundToggleVariant variant = .ghost,
  PlaygroundToggleSize size = .medium,
  ToggleStyler style = const ToggleStyler.create(),
}) {
  return _base(_metricsFor(size))
      .merge(_variantStyle(variant))
      .onHovered(ToggleStyler().color(PlaygroundTokens.muted()))
      .onSelected(
        _content(PlaygroundTokens.accentForeground())
            .color(PlaygroundTokens.accent())
            // The outline, not the fill, is what says "on". `muted` and
            // `accent` are 1.155:1 apart in the light theme, so hover and on
            // would otherwise be the same shade to most readers — and a state
            // told apart by colour alone is one a lot of people cannot read.
            .border(.all(_edge(PlaygroundTokens.primary()))),
      )
      .onFocusVisible(_focusVisibleStyle())
      .onDisabled(_disabledStyle())
      .merge(style);
}

/// Width of the outline every toggle draws, in every state.
const _borderWidth = 1.0;

/// Width of the keyboard focus ring.
const _focusRingWidth = 2.0;

/// Opacity applied to the whole control while disabled.
const _disabledOpacity = 0.5;

/// A fill that paints nothing, used while the toggle is off.
const _noFill = Color(0x00000000);

/// Geometry and type scale for one [PlaygroundToggleSize].
typedef _PlaygroundToggleMetrics = ({
  double minHeight,
  double paddingX,
  double gap,
  double labelSize,
  double iconSize,
});

_PlaygroundToggleMetrics _metricsFor(PlaygroundToggleSize size) =>
    switch (size) {
      .small => (
        minHeight: 32.0,
        paddingX: 10.0,
        gap: 6.0,
        labelSize: 14.0,
        iconSize: 16.0,
      ),
      .medium => (
        minHeight: 36.0,
        paddingX: 12.0,
        gap: 8.0,
        labelSize: 14.0,
        iconSize: 16.0,
      ),
      .large => (
        minHeight: 40.0,
        paddingX: 16.0,
        gap: 8.0,
        labelSize: 16.0,
        iconSize: 18.0,
      ),
    };

/// Layout, typography, and the off appearance shared by both variants.
ToggleStyler _base(_PlaygroundToggleMetrics metrics) =>
    _content(PlaygroundTokens.foreground())
        .color(_noFill)
        .direction(.horizontal)
        .mainAxisSize(.min)
        .mainAxisAlignment(.center)
        .crossAxisAlignment(.center)
        .minHeight(metrics.minHeight)
        .padding(.horizontal(metrics.paddingX))
        .spacing(metrics.gap)
        .borderRadius(.all(PlaygroundTokens.radius()))
        .label(.fontSize(metrics.labelSize).fontWeight(FontWeight.w500))
        .icon(.size(metrics.iconSize));

/// The outline is present in every state and every variant, and only its
/// colour changes: Flutter insets a container's content by its border widths,
/// so an outline that appeared on selection would nudge the label sideways.
/// `ghost` simply paints its copy in nothing.
ToggleStyler _variantStyle(PlaygroundToggleVariant variant) =>
    ToggleStyler().border(
      .all(
        _edge(switch (variant) {
          .ghost => _noFill,
          .outline => PlaygroundTokens.border(),
        }),
      ),
    );

/// One outline side, at the width every state shares.
BorderSideMix _edge(Color color) =>
    BorderSideMix(color: color, width: _borderWidth);

/// Applies one content color to the label and the icons.
ToggleStyler _content(Color foreground) =>
    ToggleStyler().label(.color(foreground)).icon(.color(foreground));

/// The keyboard focus ring.
///
/// A *foreground* decoration rather than the box border: `ToggleSpec` has no
/// `containerEffects` layer to paint an outline into, and Flutter insets a
/// container's content by its border widths — so adding a real border on
/// focus would nudge the label. A foreground decoration paints over the
/// control and takes no layout space, which is what a ring needs.
ToggleStyler _focusVisibleStyle() => ToggleStyler().foregroundDecoration(
  BoxDecorationMix(
    border: .all(
      BorderSideMix(
        color: PlaygroundTokens.focusRing(),
        width: _focusRingWidth,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
    ),
    borderRadius: .all(PlaygroundTokens.radius()),
  ),
);

/// Declared last so it wins over every other state fragment.
///
/// A disabled toggle keeps whatever surface its state gives it and simply
/// fades; the focus ring is cleared because a disabled control that still
/// draws a focus ring reads as actionable.
ToggleStyler _disabledStyle() => ToggleStyler()
    .foregroundDecoration(
      BoxDecorationMix.border(.all(BorderSideMix(style: BorderStyle.none))),
    )
    .wrap(WidgetModifierConfig.opacity(_disabledOpacity));
