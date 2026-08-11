import 'package:flutter/material.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../fortal/fortal.dart';

part 'popover.g.dart';

/// Fortal popover size presets matching Radix Themes 3.3.0.
enum FortalPopoverSize { size1, size2, size3, size4 }

/// Fortal-themed preset for [RemixPopover].
///
/// The generated [FortalPopover] defaults to [FortalPopoverSize.size2], a
/// 480-pixel maximum width, and no arrow.
@MixWidget(target: RemixPopover.new)
PopoverStyler fortalPopoverStyle({
  FortalPopoverSize size = FortalPopoverSize.size2,
}) {
  final radius = switch (size) {
    FortalPopoverSize.size1 ||
    FortalPopoverSize.size2 => FortalTokens.radius4(),
    FortalPopoverSize.size3 ||
    FortalPopoverSize.size4 => FortalTokens.radius5(),
  };
  final padding = switch (size) {
    FortalPopoverSize.size1 => FortalTokens.space3(),
    FortalPopoverSize.size2 => FortalTokens.space4(),
    FortalPopoverSize.size3 => FortalTokens.space5(),
    FortalPopoverSize.size4 => FortalTokens.space6(),
  };

  return PopoverStyler()
      .maxWidth(480)
      .padding(.all(padding))
      .borderRadius(.all(radius))
      .color(FortalTokens.colorPanel())
      .decoration(
        BoxDecorationMix.create(boxShadow: FortalTokens.shadow5.mix()),
      )
      .containerEffects(
        RemixBoxEffectsMix.backdropBlur(FortalTokens.panelBlur()),
      );
}
