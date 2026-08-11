import 'package:flutter/material.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../fortal/fortal.dart';

part 'avatar.g.dart';

/// Radix Themes Avatar size presets.
enum FortalAvatarSize {
  size1,
  size2,
  size3,
  size4,
  size5,
  size6,
  size7,
  size8,
  size9,
}

/// Radix Themes Avatar variants.
enum FortalAvatarVariant { soft, solid }

/// Fortal-themed Avatar with the Radix size, variant, and override contract.
///
/// [fallbackLength] selects the pinned one- or two-character fallback
/// typography. Pass `2` when [RemixAvatar.label] contains two initials.
@MixWidget(target: RemixAvatar.new)
AvatarStyler fortalAvatarStyle({
  FortalAvatarVariant variant = .soft,
  FortalAvatarSize size = .size3,
  bool highContrast = false,
  int fallbackLength = 1,
}) {
  final base = _fortalAvatarBaseStyler(size, fallbackLength: fallbackLength);
  final softContent = highContrast
      ? FortalTokens.accent12()
      : FortalTokens.accentA11();
  final solidContent = highContrast
      ? FortalTokens.accent1()
      : FortalTokens.accentContrast();
  return switch (variant) {
    .soft =>
      base
          .color(FortalTokens.accentA3())
          .labelColor(softContent)
          .iconColor(softContent),
    .solid =>
      base
          .color(
            highContrast ? FortalTokens.accent12() : FortalTokens.accent9(),
          )
          .labelColor(solidContent)
          .iconColor(solidContent),
  };
}

AvatarStyler _fortalAvatarBaseStyler(
  FortalAvatarSize size, {
  required int fallbackLength,
}) {
  final fallbackText = _fortalAvatarFallbackText(size, fallbackLength);
  final dimension = _fortalAvatarDimension(size);
  return AvatarStyler()
      .clipBehavior(.hardEdge)
      .label(
        TextStyler(
          style: fallbackText.mix(),
        ).fontWeight(FortalTokens.fontWeightMedium()),
      )
      .icon(.size(_fortalAvatarIconSize(size)).color(FortalTokens.accentA11()))
      .size(dimension, dimension)
      .borderRadius(.all(_fortalAvatarRadius(size)));
}

double _fortalAvatarDimension(FortalAvatarSize size) => switch (size) {
  .size1 => FortalTokens.space5(),
  .size2 => FortalTokens.space6(),
  .size3 => FortalTokens.space7(),
  .size4 => FortalTokens.space8(),
  .size5 => FortalTokens.space9(),
  .size6 => FortalTokens.avatarSize6(),
  .size7 => FortalTokens.avatarSize7(),
  .size8 => FortalTokens.avatarSize8(),
  .size9 => FortalTokens.avatarSize9(),
};

double _fortalAvatarIconSize(FortalAvatarSize size) => switch (size) {
  .size1 => FortalTokens.avatarIconSize1(),
  .size2 => FortalTokens.avatarIconSize2(),
  .size3 => FortalTokens.avatarIconSize3(),
  .size4 => FortalTokens.avatarIconSize4(),
  .size5 => FortalTokens.avatarIconSize5(),
  .size6 => FortalTokens.avatarIconSize6(),
  .size7 => FortalTokens.avatarIconSize7(),
  .size8 => FortalTokens.avatarIconSize8(),
  .size9 => FortalTokens.avatarIconSize9(),
};

Radius _fortalAvatarRadius(FortalAvatarSize size) => switch (size) {
  .size1 || .size2 => FortalTokens.radius2OrFull(),
  .size3 || .size4 => FortalTokens.radius3OrFull(),
  .size5 => FortalTokens.radius4OrFull(),
  .size6 || .size7 => FortalTokens.radius5OrFull(),
  .size8 || .size9 => FortalTokens.radius6OrFull(),
};

TextStyleToken _fortalAvatarFallbackText(
  FortalAvatarSize size,
  int fallbackLength,
) => switch ((size, fallbackLength == 2)) {
  (.size1, false) => FortalTokens.avatarFallback1One,
  (.size1, true) => FortalTokens.avatarFallback1Two,
  (.size2, false) => FortalTokens.avatarFallback2One,
  (.size2, true) => FortalTokens.avatarFallback2Two,
  (.size3, false) => FortalTokens.avatarFallback3One,
  (.size3, true) => FortalTokens.avatarFallback3Two,
  (.size4, false) => FortalTokens.avatarFallback4One,
  (.size4, true) => FortalTokens.avatarFallback4Two,
  (.size5, _) => FortalTokens.avatarFallback5,
  (.size6, _) => FortalTokens.avatarFallback6,
  (.size7, _) => FortalTokens.avatarFallback7,
  (.size8, _) => FortalTokens.avatarFallback8,
  (.size9, _) => FortalTokens.avatarFallback9,
};
