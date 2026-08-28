import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/tokens.dart';

part 'icon_button.g.dart';

/// The visual weights this application offers for an icon button.
///
/// The same five the labelled button offers, so a toolbar can mix the two
/// without the icon-only control looking like a different family.
enum PlaygroundIconButtonVariant {
  /// Highest emphasis: a solid `primary` fill.
  primary,

  /// Medium emphasis: a solid `secondary` fill.
  secondary,

  /// Low emphasis with a hairline `border`.
  outline,

  /// Low emphasis with no fill and no border.
  ghost,

  /// Highest emphasis for irreversible actions.
  destructive,
}

/// The control densities this application offers for an icon button.
///
/// Square at the same 32/36/40px the labelled button is tall, so the two line
/// up in a row. These are compact, web-oriented defaults; a touch-first
/// application should raise them to meet platform hit-target guidance.
enum PlaygroundIconButtonSize {
  /// A 32px square.
  small,

  /// A 36px square. The default.
  medium,

  /// A 40px square.
  large,
}

/// The application's IconButton recipe.
///
/// Everything visual about an icon button lives in this function: geometry,
/// the five variants, and the hover/pressed/focus/disabled fragments. Remix
/// keeps ownership of rendering, pointer and keyboard behavior, accessibility
/// semantics, and the loading/disabled interaction rules — this recipe never
/// reimplements any of that.
///
/// It restates the button's metrics and dimming rather than sharing them.
/// That is deliberate: the two components have separate update stories, and a
/// shared table would make every change to one a change to the other. A
/// five-line record is cheaper to duplicate than to couple.
///
/// `RemixIconButton` requires a `semanticLabel` because an icon has no
/// accessible name of its own. That is a Remix rule, not a recipe choice, and
/// it is why the generated widget has one required named argument beyond the
/// icon.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it. Because [variant] is a non-nullable
/// enum, the generator also emits one named constructor per enum value.
///
/// State fragments merge by state, not by depth: an override that must beat
/// the recipe's hover fill has to be declared as a hover fragment too
/// (`IconButtonStyler().onHovered(...)`).
@MixWidget(target: RemixIconButton.new)
IconButtonStyler playgroundIconButtonStyle({
  PlaygroundIconButtonVariant variant = .primary,
  PlaygroundIconButtonSize size = .medium,
  IconButtonStyler style = const IconButtonStyler.create(),
}) {
  return _base(_metricsFor(size))
      .merge(_variantStyle(variant))
      .onFocusVisible(_focusVisibleStyle())
      .onDisabled(_disabledStyle())
      .merge(style);
}

/// Alpha applied to a variant's own fill while hovered.
const _hoverAlpha = 0.9;

/// Alpha applied to the active fill while pressed.
const _pressedAlpha = 0.8;

/// A fill derived from [source] at [alpha], resolved from the active scope.
///
/// The obvious spelling would be `PlaygroundTokens.primary().withValues(alpha: 0.9)`,
/// but that records a Mix *directive*, and directives accumulate through every
/// later merge. A caller who replaced the hover fill would still get this
/// recipe's alpha applied on top of their own color. A `ContextToken` does the
/// arithmetic during resolution instead, so each state fragment holds one
/// plain color that a caller can replace outright.
///
/// Declared as top-level finals because `ContextToken` equality is resolver
/// identity: rebuilding one per call would make two identical recipes compare
/// unequal.
ContextToken<Color> _dimmed(ColorToken source, double alpha) =>
    ContextToken<Color>(
      (context) => source.resolve(context).withValues(alpha: alpha),
    );

final _primaryHoverFill = _dimmed(PlaygroundTokens.primary, _hoverAlpha);
final _primaryPressedFill = _dimmed(PlaygroundTokens.primary, _pressedAlpha);
final _secondaryHoverFill = _dimmed(PlaygroundTokens.secondary, _hoverAlpha);
final _secondaryPressedFill = _dimmed(
  PlaygroundTokens.secondary,
  _pressedAlpha,
);
final _destructiveHoverFill = _dimmed(
  PlaygroundTokens.destructive,
  _hoverAlpha,
);
final _destructivePressedFill = _dimmed(
  PlaygroundTokens.destructive,
  _pressedAlpha,
);
final _accentPressedFill = _dimmed(PlaygroundTokens.accent, _pressedAlpha);

/// Opacity of the loading spinner, so it reads as secondary to the icon.
const _spinnerOpacity = 0.65;

/// One full spinner revolution.
const _spinnerDuration = Duration(milliseconds: 800);

/// Width of the outline the `outline` variant draws.
const _borderWidth = 1.0;

/// Width of the keyboard focus ring.
const _focusRingWidth = 2.0;

/// Distance between the control edge and its focus ring.
const _focusRingOffset = 2.0;

/// Opacity applied to the whole control while disabled.
const _disabledOpacity = 0.5;

/// A fill that paints nothing, used by `outline` and `ghost`.
const _noFill = Color(0x00000000);

/// Geometry for one [PlaygroundIconButtonSize].
typedef _PlaygroundIconButtonMetrics = ({double edge, double iconSize});

_PlaygroundIconButtonMetrics _metricsFor(PlaygroundIconButtonSize size) =>
    switch (size) {
      .small => (edge: 32.0, iconSize: 16.0),
      .medium => (edge: 36.0, iconSize: 16.0),
      .large => (edge: 40.0, iconSize: 18.0),
    };

/// Layout and spinner defaults shared by every variant.
///
/// The box is square and centered, so the control's footprint does not change
/// with the glyph inside it.
IconButtonStyler _base(_PlaygroundIconButtonMetrics metrics) =>
    IconButtonStyler()
        .size(metrics.edge, metrics.edge)
        .alignment(.center)
        .borderRadius(.all(PlaygroundTokens.radius()))
        .icon(.size(metrics.iconSize))
        .spinner(
          .size(
            metrics.iconSize,
          ).opacity(_spinnerOpacity).duration(_spinnerDuration),
        );

IconButtonStyler _variantStyle(PlaygroundIconButtonVariant variant) =>
    switch (variant) {
      .primary => _filled(
        fill: PlaygroundTokens.primary(),
        foreground: PlaygroundTokens.primaryForeground(),
        hoverFill: _primaryHoverFill(),
        pressedFill: _primaryPressedFill(),
      ),
      .secondary => _filled(
        fill: PlaygroundTokens.secondary(),
        foreground: PlaygroundTokens.secondaryForeground(),
        hoverFill: _secondaryHoverFill(),
        pressedFill: _secondaryPressedFill(),
      ),
      .destructive => _filled(
        fill: PlaygroundTokens.destructive(),
        foreground: PlaygroundTokens.destructiveForeground(),
        hoverFill: _destructiveHoverFill(),
        pressedFill: _destructivePressedFill(),
      ),
      .outline => _quiet(bordered: true),
      .ghost => _quiet(bordered: false),
    };

/// A solid variant: its own fill, dimmed on hover and further on press.
IconButtonStyler _filled({
  required Color fill,
  required Color foreground,
  required Color hoverFill,
  required Color pressedFill,
}) => _content(IconButtonStyler().color(fill), foreground)
    .onHovered(IconButtonStyler().color(hoverFill))
    .onPressed(IconButtonStyler().color(pressedFill));

/// A transparent variant: `accent` is what makes interaction visible.
IconButtonStyler _quiet({required bool bordered}) {
  var style = _content(
    IconButtonStyler().color(_noFill),
    PlaygroundTokens.foreground(),
  );
  if (bordered) {
    style = style.border(
      .all(
        BorderSideMix(color: PlaygroundTokens.border(), width: _borderWidth),
      ),
    );
  }

  return style
      .onHovered(
        _content(
          IconButtonStyler().color(PlaygroundTokens.accent()),
          PlaygroundTokens.accentForeground(),
        ),
      )
      // Content color is re-applied on press, not only on hover: a touch
      // device never reports hover, so a press that changed the fill alone
      // would paint the accent surface under the default foreground.
      .onPressed(
        _content(
          IconButtonStyler().color(_accentPressedFill()),
          PlaygroundTokens.accentForeground(),
        ),
      );
}

/// Applies one content color to the icon and the spinner.
IconButtonStyler _content(IconButtonStyler style, Color foreground) =>
    style.icon(.color(foreground)).spinner(.color(foreground));

/// The keyboard focus ring.
///
/// An outline rather than a border: `RemixBoxEffects` paints it outside the
/// box without taking layout space, so focusing a control never reflows the
/// row it sits in.
IconButtonStyler _focusVisibleStyle() => IconButtonStyler().containerEffects(
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
/// A disabled control keeps whatever fill its variant gives it and simply
/// fades; the focus ring is cleared because a disabled button that still
/// draws a focus ring reads as actionable.
IconButtonStyler _disabledStyle() => IconButtonStyler()
    .containerEffects(
      RemixBoxEffectsMix.outline(BorderSideMix(style: BorderStyle.none)),
    )
    .wrap(WidgetModifierConfig.opacity(_disabledOpacity));
