import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/tokens.dart';

part 'avatar.g.dart';

/// The sizes this application offers for an avatar.
enum PlaygroundAvatarSize {
  /// A 32px avatar, for a dense list row.
  small,

  /// A 40px avatar. The default.
  medium,

  /// A 48px avatar, for a profile header.
  large,
}

/// The application's Avatar recipe.
///
/// Remix owns the fallback chain — image, then label, then icon — and the
/// clipping; this recipe supplies the circle, the neutral surface behind it,
/// and the scale of whatever fallback shows through.
///
/// The surface is `muted` with `mutedForeground` initials, so an avatar with
/// no image reads as a placeholder rather than as a filled control. An image
/// covers all of it, which is why the fill only ever shows in the fallback
/// case. The recipe sets no alignment: Remix already centers whichever
/// fallback it renders.
///
/// The shape is a full circle rather than the theme's control radius. An
/// avatar stands for a person or an organisation, and that is a circle in
/// every system this application is likely to sit beside; a theme that wants
/// squircles overrides `borderRadius` in one place.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it.
@MixWidget(name: 'PlaygroundAvatar', target: RemixAvatar.new)
AvatarStyler playgroundAvatarStyle({
  PlaygroundAvatarSize size = .medium,
  AvatarStyler style = const AvatarStyler.create(),
}) {
  final metrics = _metricsFor(size);

  return AvatarStyler()
      .size(metrics.diameter, metrics.diameter)
      .borderRadius(.all(_circular))
      // The clip is what rounds an image: Remix renders `backgroundImage` as
      // a child of the container, not as part of its decoration.
      .clipBehavior(Clip.antiAlias)
      .color(PlaygroundTokens.muted())
      .label(
        .fontSize(
          metrics.labelSize,
        ).fontWeight(FontWeight.w500).color(PlaygroundTokens.mutedForeground()),
      )
      .icon(.size(metrics.iconSize).color(PlaygroundTokens.mutedForeground()))
      .merge(style);
}

/// A radius large enough to round any avatar in this scale into a circle.
const _circular = Radius.circular(999);

/// Geometry and type scale for one [PlaygroundAvatarSize].
typedef _PlaygroundAvatarMetrics = ({
  double diameter,
  double labelSize,
  double iconSize,
});

_PlaygroundAvatarMetrics _metricsFor(PlaygroundAvatarSize size) =>
    switch (size) {
      .small => (diameter: 32.0, labelSize: 12.0, iconSize: 16.0),
      .medium => (diameter: 40.0, labelSize: 14.0, iconSize: 20.0),
      .large => (diameter: 48.0, labelSize: 16.0, iconSize: 24.0),
    };
