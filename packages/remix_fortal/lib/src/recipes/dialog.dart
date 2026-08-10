import 'package:flutter/material.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../fortal/fortal.dart';

part 'dialog.g.dart';

/// Fortal dialog size presets matching Radix Themes 3.3.0.
enum FortalDialogSize { size1, size2, size3, size4 }

/// Fortal dialog vertical alignment matching Radix Themes 3.3.0.
enum FortalDialogAlign { start, center }

/// Fortal-themed preset for [RemixDialog].
///
/// The generated [FortalDialog] defaults to [FortalDialogSize.size3],
/// [FortalDialogAlign.center], a 600-pixel maximum width, and a modal dialog.
@MixWidget(target: RemixDialog.new)
DialogStyler fortalDialogStyle({
  FortalDialogSize size = FortalDialogSize.size3,
  FortalDialogAlign align = FortalDialogAlign.center,
}) {
  final radius = switch (size) {
    FortalDialogSize.size1 || FortalDialogSize.size2 => FortalTokens.radius4(),
    FortalDialogSize.size3 || FortalDialogSize.size4 => FortalTokens.radius5(),
  };
  final padding = switch (size) {
    FortalDialogSize.size1 => FortalTokens.space3(),
    FortalDialogSize.size2 => FortalTokens.space4(),
    FortalDialogSize.size3 => FortalTokens.space5(),
    FortalDialogSize.size4 => FortalTokens.space6(),
  };
  final alignment = switch (align) {
    FortalDialogAlign.start => Alignment.topCenter,
    FortalDialogAlign.center => Alignment.center,
  };

  return DialogStyler()
      .wrap(.align(alignment: alignment))
      .title(
        .style(FortalTokens.text5.mix())
            .fontWeight(FortalTokens.fontWeightBold())
            .color(FortalTokens.gray12())
            .wrap(
              .padding(EdgeInsetsMix.fromLTRB(0, 0, 0, FortalTokens.space3())),
            ),
      )
      .description(
        TextStyler(
          style: FortalTokens.text3.mix(),
        ).color(FortalTokens.gray12()),
      )
      .actions(
        FlexBoxStyler()
            .mainAxisAlignment(.end)
            .crossAxisAlignment(.center)
            .spacing(FortalTokens.space3())
            .marginTop(FortalTokens.space5()),
      )
      .maxWidth(600)
      .padding(.all(padding))
      .borderRadius(.all(radius))
      .color(FortalTokens.colorPanel())
      .decoration(
        BoxDecorationMix.create(boxShadow: FortalTokens.shadow6.mix()),
      )
      .containerEffects(
        RemixBoxEffectsMix(backdropBlur: FortalTokens.panelBlur()),
      );
}
