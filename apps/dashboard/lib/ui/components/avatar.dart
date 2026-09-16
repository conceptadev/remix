import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';

part 'avatar.g.dart';

/// Radix Themes Avatar size presets.
enum UiAvatarSize {
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
enum UiAvatarVariant { soft, solid }

/// Ui-themed Avatar with the Radix size, variant, and override contract.
///
/// [fallbackLength] selects the pinned one- or two-character fallback
/// typography. Pass `2` when [RemixAvatar.label] contains two initials.
@MixWidget(target: RemixAvatar.new)
AvatarStyler uiAvatarStyle({
  UiAvatarVariant variant = .soft,
  UiAvatarSize size = .size3,
  bool highContrast = false,
  int fallbackLength = 1,
  AvatarStyler style = const AvatarStyler.create(),
}) {
  final base = _uiAvatarBaseStyler(size, fallbackLength: fallbackLength);
  final softContent = highContrast ? UiTokens.accent12() : UiTokens.accentA11();
  final solidContent = highContrast
      ? UiTokens.accent1()
      : UiTokens.accentContrast();
  return (switch (variant) {
    .soft =>
      base
          .color(UiTokens.accentA3())
          .labelColor(softContent)
          .iconColor(softContent),
    .solid =>
      base
          .color(highContrast ? UiTokens.accent12() : UiTokens.accent9())
          .labelColor(solidContent)
          .iconColor(solidContent),
  }).merge(style);
}

AvatarStyler _uiAvatarBaseStyler(
  UiAvatarSize size, {
  required int fallbackLength,
}) {
  final fallbackText = _uiAvatarFallbackText(size, fallbackLength);
  final dimension = _uiAvatarDimension(size);
  return AvatarStyler()
      .clipBehavior(.hardEdge)
      .label(
        TextStyler(
          style: fallbackText.mix(),
        ).fontWeight(UiTokens.fontWeightMedium()),
      )
      .icon(.size(_uiAvatarIconSize(size)).color(UiTokens.accentA11()))
      .size(dimension, dimension)
      .borderRadius(.all(_uiAvatarRadius(size)));
}

double _uiAvatarDimension(UiAvatarSize size) => switch (size) {
  .size1 => UiTokens.space5(),
  .size2 => UiTokens.space6(),
  .size3 => UiTokens.space7(),
  .size4 => UiTokens.space8(),
  .size5 => UiTokens.space9(),
  .size6 => UiTokens.avatarSize6(),
  .size7 => UiTokens.avatarSize7(),
  .size8 => UiTokens.avatarSize8(),
  .size9 => UiTokens.avatarSize9(),
};

double _uiAvatarIconSize(UiAvatarSize size) => switch (size) {
  .size1 => UiTokens.avatarIconSize1(),
  .size2 => UiTokens.avatarIconSize2(),
  .size3 => UiTokens.avatarIconSize3(),
  .size4 => UiTokens.avatarIconSize4(),
  .size5 => UiTokens.avatarIconSize5(),
  .size6 => UiTokens.avatarIconSize6(),
  .size7 => UiTokens.avatarIconSize7(),
  .size8 => UiTokens.avatarIconSize8(),
  .size9 => UiTokens.avatarIconSize9(),
};

Radius _uiAvatarRadius(UiAvatarSize size) => switch (size) {
  .size1 || .size2 => UiTokens.radius2OrFull(),
  .size3 || .size4 => UiTokens.radius3OrFull(),
  .size5 => UiTokens.radius4OrFull(),
  .size6 || .size7 => UiTokens.radius5OrFull(),
  .size8 || .size9 => UiTokens.radius6OrFull(),
};

TextStyleToken _uiAvatarFallbackText(UiAvatarSize size, int fallbackLength) =>
    switch ((size, fallbackLength == 2)) {
      (.size1, false) => UiTokens.avatarFallback1One,
      (.size1, true) => UiTokens.avatarFallback1Two,
      (.size2, false) => UiTokens.avatarFallback2One,
      (.size2, true) => UiTokens.avatarFallback2Two,
      (.size3, false) => UiTokens.avatarFallback3One,
      (.size3, true) => UiTokens.avatarFallback3Two,
      (.size4, false) => UiTokens.avatarFallback4One,
      (.size4, true) => UiTokens.avatarFallback4Two,
      (.size5, _) => UiTokens.avatarFallback5,
      (.size6, _) => UiTokens.avatarFallback6,
      (.size7, _) => UiTokens.avatarFallback7,
      (.size8, _) => UiTokens.avatarFallback8,
      (.size9, _) => UiTokens.avatarFallback9,
    };
