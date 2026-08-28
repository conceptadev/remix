import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/tokens.dart';

part 'segmented_control.g.dart';

/// The control densities this application offers for a segmented control.
///
/// These name the outer track, which is what lines up with a button beside
/// it. Each segment is shorter by the track inset on both sides.
///
/// These are compact, web-oriented defaults. A touch-first application should
/// raise them to meet platform hit-target guidance.
enum PlaygroundSegmentedControlSize {
  /// A 32px track.
  small,

  /// A 36px track. The default.
  medium,

  /// A 40px track.
  large,
}

/// The application's SegmentedControl recipe.
///
/// A segmented control is one control divided into parts, which is what
/// separates it from a toggle group: the segments share a track, exactly one
/// is chosen, and the chosen one is *lifted* out of the track rather than
/// tinted on top of it. Remix owns the rendering, the equal-width layout, the
/// roving focus, and the group accessibility semantics.
///
/// One recipe covers the track and the segments, because
/// `SegmentedControlSpec` carries the segment's style as a field: the
/// control's `item` is the default every `RemixSegmentedControlItem` resolves
/// against, so a segment in a loop cannot be left unstyled.
///
/// It takes no variant. The whole point of the component is one shape — a
/// recessed track with a raised current segment — and a second look would be
/// a toggle group wearing the wrong name.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it.
@MixWidget(target: RemixSegmentedControl.new)
SegmentedControlStyler playgroundSegmentedControlStyle({
  PlaygroundSegmentedControlSize size = .medium,
  SegmentedControlStyler style = const SegmentedControlStyler.create(),
}) {
  final metrics = _metricsFor(size);

  return SegmentedControlStyler()
      // The track is `muted`, the recessed surface the segments sit in. The
      // chosen segment is `background`, so it reads as sitting on top of the
      // page rather than painted onto the track.
      .color(PlaygroundTokens.muted())
      .borderRadius(.all(PlaygroundTokens.radius()))
      .padding(.all(_trackInset))
      .mainAxisSize(.min)
      .spacing(_segmentGap)
      .item(_itemStyle(metrics))
      .merge(style);
}

/// Gap between the track edge and its segments, on every side.
const _trackInset = 3.0;

/// Gap between adjacent segments.
///
/// Zero: the segments are parts of one control, and a visible gap would make
/// them read as separate buttons that happen to share a background.
const _segmentGap = 0.0;

/// How much tighter a segment's corners are than the track's.
///
/// A segment inset by [_trackInset] on every side needs a correspondingly
/// smaller radius, or its corners stand proud of the track's.
const _segmentRadiusInset = _trackInset;

/// Width of the chosen segment's outline.
const _borderWidth = 1.0;

/// Width of the keyboard focus ring.
///
/// It carries no offset, unlike the button's. Segments sit flush against each
/// other inside a 3px track inset, so a ring pushed outward would cross into
/// the neighbouring segment.
const _focusRingWidth = 2.0;

/// Opacity applied to a segment while disabled.
const _disabledOpacity = 0.5;

/// A fill that paints nothing, used by an unchosen segment.
const _noFill = Color(0x00000000);

/// Geometry and type scale for one [PlaygroundSegmentedControlSize].
typedef _PlaygroundSegmentedControlMetrics = ({
  double minHeight,
  double paddingX,
  double gap,
  double labelSize,
  double iconSize,
});

_PlaygroundSegmentedControlMetrics _metricsFor(
  PlaygroundSegmentedControlSize size,
) => switch (size) {
  .small => (
    minHeight: 26.0,
    paddingX: 10.0,
    gap: 6.0,
    labelSize: 13.0,
    iconSize: 14.0,
  ),
  .medium => (
    minHeight: 30.0,
    paddingX: 12.0,
    gap: 6.0,
    labelSize: 14.0,
    iconSize: 16.0,
  ),
  .large => (
    minHeight: 34.0,
    paddingX: 16.0,
    gap: 8.0,
    labelSize: 14.0,
    iconSize: 16.0,
  ),
};

/// One segment: quiet until chosen, then lifted onto its own surface.
///
/// Every segment's label is `foreground`, chosen or not. The tempting
/// spelling is `mutedForeground` until chosen, but that pairing measures
/// 4.35:1 on the `muted` track in the light theme — under the 4.5:1 WCAG
/// floor for text this size. The chosen segment is marked by its raised
/// surface and a heavier weight instead, and weight survives where a colour
/// difference would not.
SegmentedControlItemStyler _itemStyle(
  _PlaygroundSegmentedControlMetrics metrics,
) => _content(PlaygroundTokens.foreground())
    .color(_noFill)
    .alignment(.center)
    .minHeight(metrics.minHeight)
    .padding(.horizontal(metrics.paddingX))
    .spacing(metrics.gap)
    .borderRadius(.all(_segmentRadius()))
    .label(.fontSize(metrics.labelSize).fontWeight(FontWeight.w400))
    .icon(.size(metrics.iconSize))
    // Hover tints the surface rather than the label: the label is already at
    // full strength, and a second text colour would compete with the chosen
    // segment for "this is the current section".
    .onHovered(SegmentedControlItemStyler().color(PlaygroundTokens.accent()))
    // Three cues, because the fill alone is not one: `background` on a
    // `muted` track measures 1.09:1 in the light theme, so a reader looking
    // for "which section am I in" would be reading a 1.09:1 difference and a
    // font weight. The outline is what actually draws the segment.
    .onSelected(
      SegmentedControlItemStyler()
          .color(PlaygroundTokens.background())
          .border(
            .all(
              BorderSideMix(
                color: PlaygroundTokens.border(),
                width: _borderWidth,
              ),
            ),
          )
          .label(.fontWeight(FontWeight.w500)),
    )
    .onFocusVisible(_focusVisibleStyle())
    .onDisabled(_disabledStyle());

/// The track's radius, pulled in by the inset the segments sit behind.
///
/// Declared as a top-level final because `ContextToken` equality is resolver
/// identity: rebuilding one per call would make two identical recipes compare
/// unequal.
final _segmentRadius = ContextToken<Radius>((context) {
  final radius = PlaygroundTokens.radius.resolve(context);

  return Radius.elliptical(
    (radius.x - _segmentRadiusInset).clamp(0.0, double.infinity),
    (radius.y - _segmentRadiusInset).clamp(0.0, double.infinity),
  );
});

/// Applies one content color to the label and the icons.
SegmentedControlItemStyler _content(Color foreground) =>
    SegmentedControlItemStyler()
        .label(.color(foreground))
        .icon(.color(foreground));

/// The keyboard focus ring.
///
/// An outline rather than a border: `RemixBoxEffects` paints it outside the
/// segment without taking layout space, so focusing one never widens the
/// track.
SegmentedControlItemStyler _focusVisibleStyle() =>
    SegmentedControlItemStyler().containerEffects(
      RemixBoxEffectsMix(
        outline: BorderSideMix(
          color: PlaygroundTokens.focusRing(),
          width: _focusRingWidth,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
      ),
    );

/// Declared last so it wins over every other state fragment.
SegmentedControlItemStyler _disabledStyle() => SegmentedControlItemStyler()
    .containerEffects(
      RemixBoxEffectsMix.outline(BorderSideMix(style: BorderStyle.none)),
    )
    .wrap(WidgetModifierConfig.opacity(_disabledOpacity));
