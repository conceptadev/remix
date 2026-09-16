import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';

part 'segmented_control.g.dart';

double _resolveSegmentedControlActiveLetterSpacing3(BuildContext context) {
  final fontSize = UiTokens.text3.resolve(context).fontSize!;
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
      UiTokens.grayA3.resolve(context),
      UiTokens.colorSurface.resolve(context),
    );

const _segmentedControlTrackBackground = ContextToken<Color>(
  _resolveSegmentedControlTrackBackground,
);

/// The disabled root swaps only `background-color` to `gray-3`; the `gray-a3`
/// background-image layer persists in the source, so it stays in the blend.
Color _resolveSegmentedControlDisabledTrackBackground(BuildContext context) =>
    Color.alphaBlend(
      UiTokens.grayA3.resolve(context),
      UiTokens.gray3.resolve(context),
    );

const _segmentedControlDisabledTrackBackground = ContextToken<Color>(
  _resolveSegmentedControlDisabledTrackBackground,
);

/// Radix Themes SegmentedControl size presets.
enum UiSegmentedControlSize { size1, size2, size3 }

/// Radix Themes SegmentedControl variants.
enum UiSegmentedControlVariant { surface, classic }

/// Ui recipe for [RemixSegmentedControl].
///
/// Content icons use size-matched 12/16/20 token defaults rather than the
/// ambient icon size. Control and item styles may override these defaults.
///
/// Paints the selected item in place. It does not reproduce Radix's sliding
/// indicator, duplicate-label crossfade, inactive separators, or max-content
/// overflow. Changing an item's label with the selection can therefore cause a
/// small intrinsic-width shift.
@MixWidget(target: RemixSegmentedControl.new)
SegmentedControlStyler uiSegmentedControlStyle({
  UiSegmentedControlVariant variant = .surface,
  UiSegmentedControlSize size = .size2,
  SegmentedControlStyler style = const SegmentedControlStyler.create(),
}) {
  final metrics = _uiSegmentedControlMetrics(size);
  final item = _uiSegmentedControlItemStyle(variant, metrics);

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
      )
      .merge(style);
}

SegmentedControlItemStyler _uiSegmentedControlItemStyle(
  UiSegmentedControlVariant variant,
  _UiSegmentedControlMetrics metrics,
) {
  final base = SegmentedControlItemStyler()
      .minHeight(metrics.height)
      .padding(.horizontal(metrics.paddingX))
      .spacing(metrics.itemGap)
      .label(
        TextStyler()
            .style(metrics.text.mix())
            .color(UiTokens.gray12())
            .fontWeight(UiTokens.fontWeightRegular())
            .letterSpacing(0)
            .wordSpacing(0)
            // Radix keeps `min-width: max-content` on the track, so a label
            // never wraps and the track overflows a narrow parent instead.
            // The equal-segment layout shrinks to fit, so pin one line and
            // ellipsize to preserve the same single-line behavior.
            .maxLines(1)
            .overflow(TextOverflow.ellipsis),
      )
      .icon(IconStyler().color(UiTokens.gray12()).size(metrics.iconSize))
      .containerEffects(
        RemixBoxEffectsMix(
          behindContent: RemixBoxEffectLayerMix(),
          overContent: RemixBoxEffectLayerMix(),
        ),
      );
  final selected = _uiSegmentedControlSelectedItem(variant, metrics);
  final disabled = SegmentedControlItemStyler()
      .label(TextStyler().color(UiTokens.grayA8()))
      .icon(IconStyler().color(UiTokens.grayA8()));
  final disabledSelected = disabled
      .color(const Color(0x00000000))
      .borderRadius(.all(metrics.radius))
      .containerEffects(
        RemixBoxEffectsMix(
          behindContent: _uiSegmentedControlFill(UiTokens.grayA3()),
          overContent: RemixBoxEffectLayerMix(shadows: const []),
        ),
      );

  return base
      .onHovered(.color(UiTokens.grayA2()))
      .onSelected(
        selected
            .onHovered(.color(const Color(0x00000000)))
            .onDisabled(disabledSelected),
      )
      .onFocusVisible(
        SegmentedControlItemStyler()
            .borderRadius(.all(metrics.radius))
            .containerEffects(uiFocusOutline(UiTokens.focus8(), offset: -1)),
      )
      .onDisabled(disabled.onSelected(disabledSelected));
}

SegmentedControlItemStyler _uiSegmentedControlSelectedItem(
  UiSegmentedControlVariant variant,
  _UiSegmentedControlMetrics metrics,
) {
  final overContent = switch (variant) {
    .surface => RemixBoxEffectLayerMix(
      shadows: [
        RemixBoxShadowMix(
          color: UiTokens.grayA4(),
          spreadRadius: 1,
          shapeInset: 1,
        ),
      ],
    ),
    .classic => RemixBoxEffectLayerMix(
      shadowToken: UiTokens.segmentedControlClassicIndicatorShadows,
    ),
  };

  return SegmentedControlItemStyler()
      .color(const Color(0x00000000))
      .borderRadius(.all(metrics.radius))
      .label(
        TextStyler()
            .fontWeight(UiTokens.fontWeightMedium())
            .letterSpacing(metrics.activeLetterSpacing)
            .wordSpacing(0),
      )
      .containerEffects(
        RemixBoxEffectsMix(
          behindContent: _uiSegmentedControlFill(
            UiTokens.segmentedControlIndicatorBackground(),
            inset: 1,
          ),
          overContent: overContent,
        ),
      );
}

RemixBoxEffectLayerMix _uiSegmentedControlFill(Color color, {double? inset}) =>
    RemixBoxEffectLayerMix(
      gradients: [
        RemixLinearGradientMix(colors: [color, color]),
      ],
      gradientInsets: inset == null ? const [] : [inset],
    );

class _UiSegmentedControlMetrics {
  const _UiSegmentedControlMetrics({
    required this.height,
    required this.paddingX,
    required this.itemGap,
    required this.radius,
    required this.text,
    required this.activeLetterSpacing,
    required this.iconSize,
  });

  final double height;
  final double paddingX;
  final double itemGap;
  final Radius radius;
  final TextStyleToken text;
  final double activeLetterSpacing;
  final double iconSize;
}

_UiSegmentedControlMetrics _uiSegmentedControlMetrics(
  UiSegmentedControlSize size,
) => switch (size) {
  .size1 => _UiSegmentedControlMetrics(
    height: UiTokens.space5(),
    paddingX: UiTokens.space3(),
    itemGap: UiTokens.space1(),
    radius: UiTokens.radius2OrFull(),
    text: UiTokens.text1,
    activeLetterSpacing: UiTokens.tabActiveLetterSpacing1(),
    iconSize: UiTokens.space3(),
  ),
  .size2 => _UiSegmentedControlMetrics(
    height: UiTokens.space6(),
    paddingX: UiTokens.space4(),
    itemGap: UiTokens.space2(),
    radius: UiTokens.radius2OrFull(),
    text: UiTokens.text2,
    activeLetterSpacing: UiTokens.tabActiveLetterSpacing2(),
    iconSize: UiTokens.space4(),
  ),
  .size3 => _UiSegmentedControlMetrics(
    height: UiTokens.space7(),
    paddingX: UiTokens.space4(),
    itemGap: UiTokens.space3(),
    radius: UiTokens.radius3OrFull(),
    text: UiTokens.text3,
    // The pinned `-0.01em` is derived from the resolved size-3 text token so
    // it remains exact at every Ui scaling without adding an eighth token.
    activeLetterSpacing: _segmentedControlActiveLetterSpacing3(),
    iconSize: UiTokens.spinnerSize3(),
  ),
};
