import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/tokens.dart';

part 'slider.g.dart';

/// The control densities this application offers for a slider.
///
/// These name the rail's thickness; the thumb scales with it so the two stay
/// in proportion at every size.
///
/// These are compact, web-oriented defaults. A touch-first application should
/// raise them to meet platform hit-target guidance.
enum PlaygroundSliderSize {
  /// A 4px rail.
  small,

  /// A 6px rail. The default.
  medium,

  /// An 8px rail.
  large,
}

/// The application's Slider recipe.
///
/// Remix owns the rendering, the drag and keyboard behavior, the mapping from
/// a 0-1 value onto the filled range, and the slider accessibility semantics;
/// this recipe supplies the rail, the filled range, and the thumb.
///
/// The rail is `muted` and the range is `primary`, the same pairing the
/// progress bar uses — a slider is a progress bar you can grab, and reading
/// them as one family is worth more than distinguishing them by color.
///
/// `semanticFormatterCallback` is deliberately not forwarded to the generated
/// `PlaygroundSlider`. Its type is
/// `NakedSliderSemanticFormatterCallback`, which comes from
/// `package:naked_ui` — a package this layer does not depend on. Reach for
/// `RemixSlider` directly on the rare call site that needs to reword the
/// announced value.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it. State fragments merge by state, not
/// by depth: an override that must beat the recipe's hover thumb has to be
/// declared as a hover fragment too (`SliderStyler().onHovered(...)`).
@MixWidget(
  target: RemixSlider.new,
  widgetParameters: .only({
    'value',
    'onChanged',
    'onChangeStart',
    'onChangeEnd',
    'min',
    'max',
    'enabled',
    'enableFeedback',
    'focusNode',
    'autofocus',
    'snapDivisions',
    'semanticLabel',
    'excludeSemantics',
  }),
)
SliderStyler playgroundSliderStyle({
  PlaygroundSliderSize size = .medium,
  SliderStyler style = const SliderStyler.create(),
}) {
  final metrics = _metricsFor(size);

  return SliderStyler()
      .thickness(metrics.rail)
      .trackColor(PlaygroundTokens.muted())
      .rangeColor(PlaygroundTokens.primary())
      .thumbSize(Size.square(metrics.thumb))
      .thumbColor(PlaygroundTokens.background())
      .thumb(
        BoxStyler()
            .borderRadius(.all(_circular))
            // The thumb is a light disc on a light rail, so its own outline is
            // what separates it from the range it sits on.
            .border(
              .all(
                BorderSideMix(
                  color: PlaygroundTokens.primary(),
                  width: _thumbBorderWidth,
                ),
              ),
            ),
      )
      // A thumb is a grab target, so it answers the pointer. The outline
      // keeps identifying it; only the fill moves, which is why hovering does
      // not make the thumb harder to find on a light rail.
      .onHovered(SliderStyler().thumbColor(PlaygroundTokens.accent()))
      .onFocusVisible(_focusVisibleStyle())
      .onDisabled(_disabledStyle())
      .merge(style);
}

/// A radius large enough to round any thumb in this scale into a circle.
const _circular = Radius.circular(999);

/// Width of the thumb's outline.
const _thumbBorderWidth = 2.0;

/// Width of the keyboard focus ring.
const _focusRingWidth = 2.0;

/// Distance between the thumb edge and its focus ring.
const _focusRingOffset = 2.0;

/// Opacity applied to the whole control while disabled.
const _disabledOpacity = 0.5;

/// Geometry for one [PlaygroundSliderSize].
///
/// The thumb is a fixed multiple of the rail, which keeps the grab target
/// growing with the control instead of staying a constant size on a thicker
/// rail.
typedef _PlaygroundSliderMetrics = ({double rail, double thumb});

_PlaygroundSliderMetrics _metricsFor(PlaygroundSliderSize size) {
  final rail = switch (size) {
    .small => 4.0,
    .medium => 6.0,
    .large => 8.0,
  };

  return (rail: rail, thumb: rail * _thumbRatio);
}

/// Thumb diameter as a multiple of the rail thickness.
const _thumbRatio = 2.5;

/// The keyboard focus ring, drawn around the thumb.
///
/// `thumbFocusEffects` rather than `thumbEffects`: Remix paints the former
/// only while the slider has visible focus, which is the state a ring is for.
SliderStyler _focusVisibleStyle() => SliderStyler().thumbFocusEffects(
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
/// A disabled slider keeps its rail and range and simply fades; there is no
/// ring to clear because the focus effects are already conditional on focus.
SliderStyler _disabledStyle() =>
    SliderStyler().wrap(WidgetModifierConfig.opacity(_disabledOpacity));
