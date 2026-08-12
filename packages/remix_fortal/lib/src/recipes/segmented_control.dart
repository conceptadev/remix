import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../fortal/fortal.dart';

part 'segmented_control.g.dart';

double _resolveSegmentedControlActiveLetterSpacing3(BuildContext context) {
  final fontSize = FortalTokens.text3.resolve(context).fontSize!;
  return -0.01 * fontSize;
}

const _segmentedControlActiveLetterSpacing3 = ContextToken<double>(
  _resolveSegmentedControlActiveLetterSpacing3,
);

/// Radix layers the track as `color-surface` under a `gray-a3`
/// background-image. One BoxDecoration cannot stack two background fills, so
/// the recipe pre-blends the pair; a foreground overlay would instead paint
/// over the selected indicator fill, breaking the source z-order.
Color _resolveSegmentedControlTrackBackground(BuildContext context) =>
    Color.alphaBlend(
      FortalTokens.grayA3.resolve(context),
      FortalTokens.colorSurface.resolve(context),
    );

const _segmentedControlTrackBackground = ContextToken<Color>(
  _resolveSegmentedControlTrackBackground,
);

/// The disabled root swaps only `background-color` to `gray-3`; the `gray-a3`
/// background-image layer persists in the source, so it stays in the blend.
Color _resolveSegmentedControlDisabledTrackBackground(BuildContext context) =>
    Color.alphaBlend(
      FortalTokens.grayA3.resolve(context),
      FortalTokens.gray3.resolve(context),
    );

const _segmentedControlDisabledTrackBackground = ContextToken<Color>(
  _resolveSegmentedControlDisabledTrackBackground,
);

/// Radix Themes SegmentedControl size presets.
enum FortalSegmentedControlSize { size1, size2, size3 }

/// Radix Themes SegmentedControl variants.
enum FortalSegmentedControlVariant { surface, classic }

/// Fortal recipe for [RemixSegmentedControl].
///
/// Paints the selected item in place. It does not reproduce Radix's sliding
/// indicator, duplicate-label crossfade, inactive separators, or max-content
/// overflow. Changing an item's label with the selection can therefore cause a
/// small intrinsic-width shift.
@MixWidget(target: RemixSegmentedControl.new)
SegmentedControlStyler fortalSegmentedControlStyle({
  FortalSegmentedControlVariant variant = .surface,
  FortalSegmentedControlSize size = .size2,
}) {
  final metrics = _fortalSegmentedControlMetrics(size);
  final item = _fortalSegmentedControlItemStyle(variant, metrics);

  return SegmentedControlStyler()
      .mainAxisSize(.min)
      .minHeight(metrics.height)
      .borderRadius(.all(metrics.radius))
      .color(_segmentedControlTrackBackground())
      .clipBehavior(.antiAlias)
      .item(item)
      .onDisabled(
        SegmentedControlStyler().color(
          _segmentedControlDisabledTrackBackground(),
        ),
      );
}

SegmentedControlItemStyler _fortalSegmentedControlItemStyle(
  FortalSegmentedControlVariant variant,
  _FortalSegmentedControlMetrics metrics,
) {
  final base = SegmentedControlItemStyler()
      .minHeight(metrics.height)
      .padding(.horizontal(metrics.paddingX))
      .spacing(metrics.itemGap)
      .label(
        TextStyler()
            .style(metrics.text.mix())
            .color(FortalTokens.gray12())
            .fontWeight(FortalTokens.fontWeightRegular())
            .letterSpacing(0)
            .wordSpacing(0)
            // Radix keeps `min-width: max-content` on the track, so a label
            // never wraps and the track overflows a narrow parent instead.
            // The equal-segment layout shrinks to fit, so pin one line and
            // ellipsize to preserve the same single-line behavior.
            .maxLines(1)
            .overflow(TextOverflow.ellipsis),
      )
      .icon(IconStyler().color(FortalTokens.gray12()))
      .containerEffects(
        RemixBoxEffectsMix(
          behindContent: RemixBoxEffectLayerMix(),
          overContent: RemixBoxEffectLayerMix(),
        ),
      );
  final selected = _fortalSegmentedControlSelectedItem(variant, metrics);
  final disabled = SegmentedControlItemStyler()
      .label(TextStyler().color(FortalTokens.grayA8()))
      .icon(IconStyler().color(FortalTokens.grayA8()));
  final disabledSelected = disabled
      .color(const Color(0x00000000))
      .borderRadius(.all(metrics.radius))
      .containerEffects(
        RemixBoxEffectsMix(
          behindContent: _fortalSegmentedControlFill(FortalTokens.grayA3()),
          overContent: RemixBoxEffectLayerMix(shadows: const []),
        ),
      );

  return base
      .onHovered(.color(FortalTokens.grayA2()))
      .onSelected(
        selected
            .onHovered(.color(const Color(0x00000000)))
            .onDisabled(disabledSelected),
      )
      .onFocusVisible(
        SegmentedControlItemStyler()
            .borderRadius(.all(metrics.radius))
            .containerEffects(
              fortalFocusOutline(FortalTokens.focus8(), offset: -1),
            ),
      )
      .onDisabled(disabled.onSelected(disabledSelected));
}

SegmentedControlItemStyler _fortalSegmentedControlSelectedItem(
  FortalSegmentedControlVariant variant,
  _FortalSegmentedControlMetrics metrics,
) {
  final overContent = switch (variant) {
    .surface => RemixBoxEffectLayerMix(
      shadows: [
        RemixBoxShadowMix(
          color: FortalTokens.grayA4(),
          spreadRadius: 1,
          shapeInset: 1,
        ),
      ],
    ),
    .classic => RemixBoxEffectLayerMix(
      shadowToken: FortalTokens.segmentedControlClassicIndicatorShadows,
    ),
  };

  return SegmentedControlItemStyler()
      .color(const Color(0x00000000))
      .borderRadius(.all(metrics.radius))
      .label(
        TextStyler()
            .fontWeight(FortalTokens.fontWeightMedium())
            .letterSpacing(metrics.activeLetterSpacing)
            .wordSpacing(0),
      )
      .containerEffects(
        RemixBoxEffectsMix(
          behindContent: _fortalSegmentedControlFill(
            FortalTokens.segmentedControlIndicatorBackground(),
            inset: 1,
          ),
          overContent: overContent,
        ),
      );
}

RemixBoxEffectLayerMix _fortalSegmentedControlFill(
  Color color, {
  double? inset,
}) => RemixBoxEffectLayerMix(
  gradients: [
    RemixLinearGradientMix(colors: [color, color]),
  ],
  gradientInsets: inset == null ? const [] : [inset],
);

class _FortalSegmentedControlMetrics {
  const _FortalSegmentedControlMetrics({
    required this.height,
    required this.paddingX,
    required this.itemGap,
    required this.radius,
    required this.text,
    required this.activeLetterSpacing,
  });

  final double height;
  final double paddingX;
  final double itemGap;
  final Radius radius;
  final TextStyleToken text;
  final double activeLetterSpacing;
}

_FortalSegmentedControlMetrics _fortalSegmentedControlMetrics(
  FortalSegmentedControlSize size,
) => switch (size) {
  .size1 => _FortalSegmentedControlMetrics(
    height: FortalTokens.space5(),
    paddingX: FortalTokens.space3(),
    itemGap: FortalTokens.space1(),
    radius: FortalTokens.radius2OrFull(),
    text: FortalTokens.text1,
    activeLetterSpacing: FortalTokens.tabActiveLetterSpacing1(),
  ),
  .size2 => _FortalSegmentedControlMetrics(
    height: FortalTokens.space6(),
    paddingX: FortalTokens.space4(),
    itemGap: FortalTokens.space2(),
    radius: FortalTokens.radius2OrFull(),
    text: FortalTokens.text2,
    activeLetterSpacing: FortalTokens.tabActiveLetterSpacing2(),
  ),
  .size3 => _FortalSegmentedControlMetrics(
    height: FortalTokens.space7(),
    paddingX: FortalTokens.space4(),
    itemGap: FortalTokens.space3(),
    radius: FortalTokens.radius3OrFull(),
    text: FortalTokens.text3,
    // The pinned `-0.01em` is derived from the resolved size-3 text token so
    // it remains exact at every Fortal scaling without adding an eighth token.
    activeLetterSpacing: _segmentedControlActiveLetterSpacing3(),
  ),
};
