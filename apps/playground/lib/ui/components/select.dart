import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/tokens.dart';

part 'select.g.dart';

/// The control densities this application offers for a select.
///
/// The same 32/36/40px heights the text field uses, because the trigger is a
/// field: it shows the current value and it sits in the same forms.
enum PlaygroundSelectSize {
  /// 32px minimum height.
  small,

  /// 36px minimum height. The default.
  medium,

  /// 40px minimum height.
  large,
}

/// The application's Select recipe.
///
/// Remix owns the rendering, the overlay, keyboard traversal, the open and
/// close behavior, and the listbox accessibility semantics; this recipe
/// supplies the trigger, the floating panel, and the option rows.
///
/// One recipe covers all three, because `SelectSpec` carries them as fields:
/// `trigger`, `content` with `menuContainer`, and `item`. An option in a loop
/// therefore cannot be left unstyled.
///
/// The trigger is styled as a field rather than as a button — same border,
/// same radius, same heights as the text field — because that is what it is.
/// The panel matches the menu's, so a select and a menu opened side by side
/// do not read as two systems.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it. State fragments merge by state, not
/// by depth: an override that must beat the trigger's focus ring has to be
/// declared as a focus fragment too.
@MixWidget(target: RemixSelect.new)
SelectStyler playgroundSelectStyle({
  PlaygroundSelectSize size = .medium,
  SelectStyler style = const SelectStyler.create(),
}) {
  final metrics = _metricsFor(size);

  return SelectStyler()
      .trigger(_triggerStyle(metrics))
      .content(_contentStyle())
      .menuContainer(FlexBoxStyler().direction(.vertical).mainAxisSize(.min))
      .item(_itemStyle(metrics))
      .merge(style);
}

/// Width of the trigger and panel outlines.
const _borderWidth = 1.0;

/// Horizontal inset inside the trigger and inside an option row.
const _paddingX = 12.0;

/// Gap between a row's text and its icons.
const _gap = 8.0;

/// Size of the trigger's chevron and an option's check mark.
const _iconSize = 16.0;

/// Inset between the panel edge and its rows.
const _panelPadding = 4.0;

/// The narrowest a panel gets, so a one-word list is still a target.
const _panelMinWidth = 160.0;

/// The tallest a panel gets before it scrolls.
///
/// Bounded on purpose: an unbounded list of options grows past the viewport
/// and takes its own dismissal affordances with it.
const _panelMaxHeight = 320.0;

/// Minimum height of one option row.
const _rowHeight = 32.0;

/// Vertical inset inside an option row.
const _rowPaddingY = 6.0;

/// Opacity of the placeholder, on top of its `mutedForeground` color.
///
/// Remix multiplies this into the placeholder's own color rather than
/// replacing it, which is why the recipe sets both.
const _placeholderOpacity = 1.0;

/// Width of the keyboard focus ring.
const _focusRingWidth = 2.0;

/// Distance between the trigger edge and its focus ring.
const _focusRingOffset = 2.0;

/// Opacity applied to the whole control while disabled.
const _disabledOpacity = 0.5;

/// The lift that separates the panel from whatever it covers.
final _shadow = RemixBoxShadowMix(
  color: const Color(0x1A000000),
  offset: const Offset(0, 4),
  blurRadius: 12,
);

/// Geometry and type scale for one [PlaygroundSelectSize].
typedef _PlaygroundSelectMetrics = ({double minHeight, double textSize});

_PlaygroundSelectMetrics _metricsFor(PlaygroundSelectSize size) =>
    switch (size) {
      .small => (minHeight: 32.0, textSize: 14.0),
      .medium => (minHeight: 36.0, textSize: 14.0),
      .large => (minHeight: 40.0, textSize: 16.0),
    };

/// The closed control: a field showing the current value and a chevron.
SelectTriggerStyler _triggerStyle(
  _PlaygroundSelectMetrics metrics,
) => SelectTriggerStyler()
    .direction(.horizontal)
    .crossAxisAlignment(.center)
    .mainAxisAlignment(.spaceBetween)
    .minHeight(metrics.minHeight)
    .padding(.horizontal(_paddingX))
    .spacing(_gap)
    .color(PlaygroundTokens.background())
    .border(
      .all(
        BorderSideMix(color: PlaygroundTokens.border(), width: _borderWidth),
      ),
    )
    .borderRadius(.all(PlaygroundTokens.radius()))
    .label(.fontSize(metrics.textSize).color(PlaygroundTokens.foreground()))
    // The placeholder is not a value: it has to read as the quieter of
    // the two, or a select with nothing chosen looks answered.
    .placeholder(
      .fontSize(metrics.textSize).color(PlaygroundTokens.mutedForeground()),
    )
    .placeholderOpacity(_placeholderOpacity)
    .icon(.size(_iconSize).color(PlaygroundTokens.mutedForeground()))
    .onHovered(SelectTriggerStyler().color(PlaygroundTokens.accent()))
    .onFocusVisible(
      SelectTriggerStyler().containerEffects(
        RemixBoxEffectsMix(
          outline: BorderSideMix(
            color: PlaygroundTokens.focusRing(),
            width: _focusRingWidth,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
          outlineOffset: _focusRingOffset,
        ),
      ),
    )
    .onDisabled(
      SelectTriggerStyler()
          .containerEffects(
            RemixBoxEffectsMix.outline(BorderSideMix(style: BorderStyle.none)),
          )
          .wrap(WidgetModifierConfig.opacity(_disabledOpacity)),
    );

/// The floating panel the options live in.
SelectContentStyler _contentStyle() => SelectContentStyler()
    .color(PlaygroundTokens.background())
    .border(
      .all(
        BorderSideMix(color: PlaygroundTokens.border(), width: _borderWidth),
      ),
    )
    .borderRadius(.all(PlaygroundTokens.radius()))
    .padding(.all(_panelPadding))
    .minWidth(_panelMinWidth)
    .maxHeight(_panelMaxHeight)
    .containerEffects(
      RemixBoxEffectsMix(
        behindContent: RemixBoxEffectLayerMix(shadows: [_shadow]),
      ),
    );

/// One option row.
///
/// `accent` marks the row under the pointer *and* the row the arrow keys are
/// on, because a select is as often driven by the keyboard as by the mouse.
/// The chosen option is marked by its check icon, which Remix renders.
SelectMenuItemStyler _itemStyle(_PlaygroundSelectMetrics metrics) =>
    SelectMenuItemStyler()
        .direction(.horizontal)
        .crossAxisAlignment(.center)
        .minHeight(_rowHeight)
        .padding(.symmetric(horizontal: _paddingX, vertical: _rowPaddingY))
        .spacing(_gap)
        .borderRadius(.all(PlaygroundTokens.radius()))
        .label(.fontSize(metrics.textSize).color(PlaygroundTokens.foreground()))
        .icon(.size(_iconSize).color(PlaygroundTokens.foreground()))
        .onHovered(_highlighted())
        .onFocused(_highlighted())
        .onDisabled(
          SelectMenuItemStyler().wrap(
            WidgetModifierConfig.opacity(_disabledOpacity),
          ),
        );

/// The option under the pointer or the keyboard cursor.
SelectMenuItemStyler _highlighted() => SelectMenuItemStyler()
    .color(PlaygroundTokens.accent())
    .label(.color(PlaygroundTokens.accentForeground()))
    .icon(.color(PlaygroundTokens.accentForeground()));
