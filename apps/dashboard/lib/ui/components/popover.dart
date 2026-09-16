import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';

part 'popover.g.dart';

/// Ui popover size presets matching Radix Themes 3.3.0.
enum UiPopoverSize { size1, size2, size3, size4 }

/// Ui-themed preset for [RemixPopover].
///
/// The generated [UiPopover] defaults to [UiPopoverSize.size2], a
/// 480-pixel maximum width, and no arrow.
@MixWidget(target: RemixPopover.new)
PopoverStyler uiPopoverStyle({
  UiPopoverSize size = UiPopoverSize.size2,
  PopoverStyler style = const PopoverStyler.create(),
}) {
  final radius = switch (size) {
    UiPopoverSize.size1 || UiPopoverSize.size2 => UiTokens.radius4(),
    UiPopoverSize.size3 || UiPopoverSize.size4 => UiTokens.radius5(),
  };
  final padding = switch (size) {
    UiPopoverSize.size1 => UiTokens.space3(),
    UiPopoverSize.size2 => UiTokens.space4(),
    UiPopoverSize.size3 => UiTokens.space5(),
    UiPopoverSize.size4 => UiTokens.space6(),
  };

  return PopoverStyler()
      .maxWidth(480)
      .padding(.all(padding))
      .borderRadius(.all(radius))
      .color(UiTokens.colorPanel())
      .decoration(BoxDecorationMix.create(boxShadow: UiTokens.shadow5.mix()))
      .containerEffects(RemixBoxEffectsMix.backdropBlur(UiTokens.panelBlur()))
      .merge(style);
}
