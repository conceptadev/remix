import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/tokens.dart';

part 'checkbox.g.dart';

/// The application's Checkbox recipe.
///
/// Everything visual about a checkbox lives in this function: the box
/// geometry, the indicator, the label, and the
/// hover/checked/indeterminate/focus/disabled fragments. Remix keeps
/// ownership of rendering, the tristate transition, pointer and keyboard
/// behavior, the minimum tap target, and the checkbox accessibility
/// semantics — this recipe never reimplements any of that.
///
/// `@MixWidget(target: RemixCheckbox.new)` generates `PlaygroundCheckbox`
/// into `checkbox.g.dart`: an adapter whose constructor is this function's
/// parameters plus every safe `RemixCheckbox` parameter, and whose `build`
/// calls `RemixCheckbox(style: playgroundCheckboxStyle(...), ...)`. Unlike
/// Button there is no `variant` parameter, so the generator emits no named
/// constructors: a checkbox has one look, and its meaningful axes are the
/// runtime states below.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it:
///
/// ```dart
/// PlaygroundCheckbox(
///   selected: subscribed,
///   label: 'Email me',
///   style: CheckboxStyler().onSelected(
///     CheckboxStyler().color(const Color(0xFF7C3AED)),
///   ),
///   onChanged: (value) => setState(() => subscribed = value),
/// )
/// ```
///
/// State fragments merge by state, not by depth: an override that must beat
/// the recipe's checked fill has to be declared as a selected fragment too
/// (`CheckboxStyler().onSelected(...)`).
///
/// There is deliberately no pressed fragment. A button needs one because
/// nothing else about it changes on tap; a checkbox flips its own state, and
/// that is the feedback.
@MixWidget(target: RemixCheckbox.new)
CheckboxStyler playgroundCheckboxStyle({
  CheckboxStyler style = const CheckboxStyler.create(),
}) {
  // Built once and used for both fragments: an indeterminate checkbox is a
  // checkbox that is *not unchecked*, so it carries the checked surface and
  // only its glyph differs. Reusing the value also keeps the two fragments
  // equal, which matters because stylers compare by value.
  final checked = _checkedStyle();

  return _base()
      // The outline has to survive the hover fill, exactly as it does on the
      // radio beside it: `accent` on `border` is 1.09:1 in the shipped light
      // theme, so tinting the box alone leaves an unchecked checkbox with no
      // visible edge while the pointer is on it.
      .onHovered(
        CheckboxStyler()
            .color(PlaygroundTokens.accent())
            .border(
              .color(PlaygroundTokens.mutedForeground()).width(_borderWidth),
            ),
      )
      .onSelected(checked)
      .onIndeterminate(checked)
      .onFocusVisible(_focusVisibleStyle())
      .onDisabled(_disabledStyle())
      .merge(style);
}

/// The application's Checkbox recipe for one option in a checkbox group.
///
/// `RemixCheckboxGroup` is behavioral: it owns the selected set and the
/// group-wide enabled and required configuration, and carries no styler of
/// its own. Without this second adapter every option in a group would need
/// the recipe attached by hand, and one missed option in a loop would render
/// unstyled beside its styled siblings.
///
/// It delegates to [playgroundCheckboxStyle] rather than restating it:
/// a group option is the same checkbox, so editing the recipe above restyles
/// both.
@MixWidget(target: RemixCheckboxGroupItem.new)
CheckboxStyler playgroundCheckboxGroupItemStyle({
  CheckboxStyler style = const CheckboxStyler.create(),
}) => playgroundCheckboxStyle(style: style);

/// Alpha applied to the checked fill while hovered.
const _hoverAlpha = 0.9;

/// The checked fill, dimmed, resolved from the active scope.
///
/// The obvious spelling would be `PlaygroundTokens.primary().withValues(alpha: 0.9)`,
/// but that records a Mix *directive*, and directives accumulate through every
/// later merge. A caller who replaced the hover fill would still get this
/// recipe's alpha applied on top of their own color. A `ContextToken` does the
/// arithmetic during resolution instead, so the state fragment holds one plain
/// color that a caller can replace outright.
///
/// Declared as a top-level final because `ContextToken` equality is resolver
/// identity: rebuilding one per call would make two identical recipes compare
/// unequal.
final _primaryHoverFill = ContextToken<Color>(
  (context) =>
      PlaygroundTokens.primary.resolve(context).withValues(alpha: _hoverAlpha),
);

/// The largest corner radius a checkbox box may take.
///
/// `PlaygroundTokens.radius` is authored for 32-40px controls. Applied
/// unclamped to a 16px box, a pill radius draws a circle, which reads as a
/// radio button. Clamping rather than hardcoding keeps the theme in charge in
/// the other direction, so `radius: Radius.zero` still yields square
/// checkboxes.
const _maxBoxRadius = 4.0;

/// The theme's corner radius, clamped to [_maxBoxRadius]. See
/// [_primaryHoverFill] for why this is a top-level final rather than a
/// per-call closure.
final _boxRadius = ContextToken<Radius>((context) {
  final radius = PlaygroundTokens.radius.resolve(context);

  return Radius.elliptical(
    math.min(radius.x, _maxBoxRadius),
    math.min(radius.y, _maxBoxRadius),
  );
});

/// Width of the box outline, in every state.
const _borderWidth = 1.0;

/// Width of the keyboard focus ring.
const _focusRingWidth = 2.0;

/// Distance between the control edge and its focus ring.
const _focusRingOffset = 2.0;

/// Opacity applied to the whole control while disabled.
const _disabledOpacity = 0.5;

/// Side of the box, matching shadcn's `h-4 w-4`.
const _box = 16.0;

/// Side of the check or dash drawn inside the box.
const _indicator = 10.0;

/// Gap between the box and its label.
const _gap = 8.0;

/// Label size, matching body copy.
const _labelSize = 14.0;

/// The unchecked box, the indicator geometry, and the label.
///
/// The indicator gets a size but no color here: Remix renders no indicator at
/// all while unchecked, so the only states that can show one set their own
/// content color.
CheckboxStyler _base() => CheckboxStyler()
    .size(_box, _box)
    .alignment(.center)
    .borderRadius(.all(_boxRadius()))
    .color(PlaygroundTokens.background())
    .border(.color(PlaygroundTokens.border()).width(_borderWidth))
    .indicator(.size(_indicator))
    .labelSpacing(_gap)
    .label(.fontSize(_labelSize).color(PlaygroundTokens.foreground()));

/// The checked and indeterminate surface.
///
/// The border is repainted in the fill color rather than removed: dropping it
/// would shrink the painted box by two logical pixels at the moment of
/// checking, so the control would visibly twitch.
CheckboxStyler _checkedStyle() => _filled(PlaygroundTokens.primary())
    .indicator(.color(PlaygroundTokens.primaryForeground()))
    // Declared as a hover fragment inside the checked fragment so a hovered,
    // checked box dims its own fill. A top-level hover fragment could not do
    // this: it does not know which fill it is dimming.
    .onHovered(_filled(_primaryHoverFill()));

/// One fill applied to both the box and its outline.
CheckboxStyler _filled(Color fill) =>
    CheckboxStyler().color(fill).border(.color(fill).width(_borderWidth));

/// The keyboard focus ring.
///
/// An outline rather than a border: `RemixBoxEffects` paints it outside the
/// box without taking layout space, so focusing a checkbox never reflows the
/// row it sits in.
CheckboxStyler _focusVisibleStyle() => CheckboxStyler().containerEffects(
  .outline(
    .color(
      PlaygroundTokens.focusRing(),
    ).width(_focusRingWidth).strokeAlign(BorderSide.strokeAlignInside),
  ).outlineOffset(_focusRingOffset),
);

/// Declared last so it wins over every other state fragment.
///
/// A disabled checkbox keeps whatever surface its state gives it and simply
/// fades; the focus ring is cleared because a disabled control that still
/// draws a focus ring reads as actionable.
CheckboxStyler _disabledStyle() => CheckboxStyler()
    .containerEffects(.outline(.style(.none)))
    .wrap(.opacity(_disabledOpacity));
