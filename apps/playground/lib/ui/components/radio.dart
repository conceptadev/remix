import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/tokens.dart';

part 'radio.g.dart';

/// The control densities this application offers for a radio.
///
/// The same box edges the checkbox uses, so a form that mixes the two lines
/// up. These are box edges, not hit targets: Remix keeps a minimum pointer,
/// focus, and semantics target around whatever the recipe draws.
enum PlaygroundRadioSize {
  /// A 16px circle.
  small,

  /// An 18px circle. The default.
  medium,

  /// A 20px circle.
  large,
}

/// The application's Radio recipe.
///
/// Remix owns the rendering, the single-selection behavior, arrow-key
/// traversal within the group, and the radio accessibility role; this recipe
/// supplies the circle, the dot, and the state fragments.
///
/// `RemixRadioGroup` — the behavioral coordinator that owns `groupValue` and
/// the change callback — carries no styler and therefore no recipe. Compose it
/// directly around these:
///
/// ```dart
/// RemixRadioGroup<String>(
///   groupValue: plan,
///   onChanged: (value) => setState(() => plan = value),
///   child: Column(children: const [
///     PlaygroundRadio(value: 'free', semanticLabel: 'Free'),
///     PlaygroundRadio(value: 'pro', semanticLabel: 'Pro'),
///   ]),
/// )
/// ```
///
/// Unlike the checkbox, a radio draws no glyph: the mark is a filled dot
/// inside the ring, which is what tells the two controls apart at a glance
/// even before their shapes register.
///
/// `RemixRadio` requires a `semanticLabel` because it renders no text of its
/// own — the visible label beside it belongs to the caller's layout.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it. State fragments merge by state, not
/// by depth: an override that must beat the recipe's selected ring has to be
/// declared as a selected fragment too (`RadioStyler().onSelected(...)`).
@MixWidget(target: RemixRadio.new)
RadioStyler playgroundRadioStyle({
  PlaygroundRadioSize size = .medium,
  RadioStyler style = const RadioStyler.create(),
}) {
  final metrics = _metricsFor(size);

  return RadioStyler()
      .size(metrics.diameter, metrics.diameter)
      .alignment(.center)
      .borderRadius(.all(_circular))
      .color(PlaygroundTokens.background())
      .border(.color(PlaygroundTokens.border()).width(_borderWidth))
      .indicator(
        BoxStyler()
            .size(metrics.dot, metrics.dot)
            .borderRadius(.all(_circular)),
      )
      .onHovered(.color(PlaygroundTokens.accent()))
      .onSelected(_selectedStyle())
      .onFocusVisible(_focusVisibleStyle())
      .onDisabled(_disabledStyle())
      .merge(style);
}

/// Alpha applied to the selected ring while hovered.
const _hoverAlpha = 0.9;

/// The selected ring color, dimmed, resolved from the active scope.
///
/// The obvious spelling would be `PlaygroundTokens.primary().withValues(alpha: 0.9)`,
/// but that records a Mix *directive*, and directives accumulate through every
/// later merge. A caller who replaced the hover color would still get this
/// recipe's alpha applied on top of their own. A `ContextToken` does the
/// arithmetic during resolution instead, so the state fragment holds one plain
/// color that a caller can replace outright.
///
/// Declared as a top-level final because `ContextToken` equality is resolver
/// identity: rebuilding one per call would make two identical recipes compare
/// unequal.
final _primaryHover = ContextToken<Color>(
  (context) =>
      PlaygroundTokens.primary.resolve(context).withValues(alpha: _hoverAlpha),
);

/// A radius large enough to round any radio in this scale into a circle.
const _circular = Radius.circular(999);

/// Width of the ring, in every state.
const _borderWidth = 1.0;

/// Width of the ring once the option is chosen.
///
/// Thicker than the resting ring so a selected radio reads at a glance even
/// where the dot is small.
const _selectedBorderWidth = 1.5;

/// Width of the keyboard focus ring.
const _focusRingWidth = 2.0;

/// Distance between the control edge and its focus ring.
const _focusRingOffset = 2.0;

/// Opacity applied to the whole control while disabled.
const _disabledOpacity = 0.5;

/// Geometry for one [PlaygroundRadioSize].
typedef _PlaygroundRadioMetrics = ({double diameter, double dot});

_PlaygroundRadioMetrics _metricsFor(PlaygroundRadioSize size) => switch (size) {
  .small => (diameter: 16.0, dot: 6.0),
  .medium => (diameter: 18.0, dot: 7.0),
  .large => (diameter: 20.0, dot: 8.0),
};

/// The chosen option: a `primary` ring around a `primary` dot.
///
/// The surface stays `background` rather than filling with `primary`. A filled
/// circle would be a checkbox's mark; leaving the middle open is what makes
/// the dot the thing the eye lands on.
RadioStyler _selectedStyle() => RadioStyler()
    .border(.color(PlaygroundTokens.primary()).width(_selectedBorderWidth))
    .indicatorColor(PlaygroundTokens.primary())
    // Declared inside the selected fragment so a hovered, chosen radio dims
    // its own ring. The top-level hover fragment tints the *surface*, which is
    // the right feedback while unchosen and the wrong one once the ring is
    // carrying the meaning.
    .onHovered(
      RadioStyler()
          .border(.color(_primaryHover()).width(_selectedBorderWidth))
          .indicatorColor(_primaryHover()),
    );

/// The keyboard focus ring.
///
/// An outline rather than a border: `RemixBoxEffects` paints it outside the
/// circle without taking layout space, so focusing a radio never reflows the
/// row it sits in — and the recipe's own ring is already a border.
RadioStyler _focusVisibleStyle() => RadioStyler().containerEffects(
  .outline(
    .color(
      PlaygroundTokens.focusRing(),
    ).width(_focusRingWidth).strokeAlign(BorderSide.strokeAlignInside),
  ).outlineOffset(_focusRingOffset),
);

/// Declared last so it wins over every other state fragment.
///
/// A disabled radio keeps whatever ring its state gives it and simply fades;
/// the focus ring is cleared because a disabled control that still draws a
/// focus ring reads as actionable.
RadioStyler _disabledStyle() => RadioStyler()
    .containerEffects(.outline(.style(.none)))
    .wrap(.opacity(_disabledOpacity));
