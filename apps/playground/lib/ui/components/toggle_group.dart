import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/tokens.dart';

part 'toggle_group.g.dart';

/// The visual weights this application offers for a toggle group.
///
/// The same two the single toggle offers, because a group is a row of them.
enum PlaygroundToggleGroupVariant {
  /// No fill and no border until an option is hovered or on.
  ghost,

  /// A hairline `border` around every option, so the set is visible while off.
  outline,
}

/// The control densities this application offers for a toggle group.
enum PlaygroundToggleGroupSize {
  /// 32px minimum height.
  small,

  /// 36px minimum height. The default.
  medium,

  /// 40px minimum height.
  large,
}

/// The application's ToggleGroup recipe.
///
/// A toggle group is a set of toggles that share one selection. Remix owns the
/// rendering, the roving focus and arrow-key traversal, the single- or
/// multi-select rules, and the group accessibility semantics; this recipe
/// owns the strip's layout and every option's appearance.
///
/// One recipe covers both, because `ToggleGroupSpec` carries the option's
/// style as a field: the group's `item` is the default every
/// `RemixToggleGroupItem` resolves against. That is what makes an option in a
/// loop impossible to leave unstyled, and it is why this file has one
/// `@MixWidget` rather than two.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it. Because [variant] is a non-nullable
/// enum, the generator also emits one named constructor per enum value.
@MixWidget(target: RemixToggleGroup.new)
ToggleGroupStyler playgroundToggleGroupStyle({
  PlaygroundToggleGroupVariant variant = .ghost,
  PlaygroundToggleGroupSize size = .medium,
  ToggleGroupStyler style = const ToggleGroupStyler.create(),
}) => ToggleGroupStyler()
    .direction(.horizontal)
    .mainAxisSize(.min)
    .spacing(_gap)
    .item(_itemStyle(_metricsFor(size), variant))
    .merge(style);

/// Gap between adjacent options.
///
/// Present rather than zero: the options are separate controls that happen to
/// sit together, not segments of one control. A segmented control is the
/// component for the latter.
const _gap = 4.0;

/// Width of the outline the `outline` variant draws.
const _borderWidth = 1.0;

/// Width of the keyboard focus ring.
const _focusRingWidth = 2.0;

/// Opacity applied to an option while disabled.
const _disabledOpacity = 0.5;

/// A fill that paints nothing, used while an option is off.
const _noFill = Color(0x00000000);

/// Geometry and type scale for one [PlaygroundToggleGroupSize].
typedef _PlaygroundToggleGroupMetrics = ({
  double minHeight,
  double paddingX,
  double gap,
  double labelSize,
  double iconSize,
});

_PlaygroundToggleGroupMetrics _metricsFor(PlaygroundToggleGroupSize size) =>
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

/// One option: the same off/hover/on/focus/disabled story a lone toggle tells.
ToggleGroupItemStyler _itemStyle(
  _PlaygroundToggleGroupMetrics metrics,
  PlaygroundToggleGroupVariant variant,
) {
  var style = _content(PlaygroundTokens.foreground())
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

  if (variant == .outline) {
    style = style.border(
      .all(
        BorderSideMix(color: PlaygroundTokens.border(), width: _borderWidth),
      ),
    );
  }

  return style
      .onHovered(ToggleGroupItemStyler().color(PlaygroundTokens.muted()))
      .onSelected(
        _content(
          PlaygroundTokens.accentForeground(),
        ).color(PlaygroundTokens.accent()),
      )
      .onFocusVisible(_focusVisibleStyle())
      .onDisabled(_disabledStyle());
}

/// Applies one content color to the label and the icons.
ToggleGroupItemStyler _content(Color foreground) =>
    ToggleGroupItemStyler().label(.color(foreground)).icon(.color(foreground));

/// The keyboard focus ring.
///
/// A *foreground* decoration rather than the box border: `ToggleGroupItemSpec`
/// has no `containerEffects` layer to paint an outline into, and Flutter
/// insets a container's content by its border widths — so adding a real border
/// on focus would nudge the label.
ToggleGroupItemStyler _focusVisibleStyle() =>
    ToggleGroupItemStyler().foregroundDecoration(
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
ToggleGroupItemStyler _disabledStyle() => ToggleGroupItemStyler()
    .foregroundDecoration(
      BoxDecorationMix.border(.all(BorderSideMix(style: BorderStyle.none))),
    )
    .wrap(WidgetModifierConfig.opacity(_disabledOpacity));
