import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../fortal/fortal.dart';

part 'dialog.g.dart';

/// Fortal dialog size presets matching Radix Themes 3.3.0.
enum FortalDialogSize { size1, size2, size3, size4 }

/// Fortal dialog vertical alignment matching Radix Themes 3.3.0.
enum FortalDialogAlign { start, center }

final _dialogViewportInsets = ContextToken<EdgeInsetsGeometry>((context) {
  final safeArea = MediaQuery.paddingOf(context);
  final viewportHeight = MediaQuery.sizeOf(context).height;
  final horizontal = FortalTokens.space4.resolve(context);
  final vertical = FortalTokens.space6.resolve(context);

  return EdgeInsets.fromLTRB(
    math.max(safeArea.left, horizontal),
    math.max(safeArea.top, vertical),
    math.max(safeArea.right, horizontal),
    math.max(safeArea.bottom, math.max(vertical, viewportHeight * 0.06)),
  );
});

/// Fortal-themed preset for [RemixDialog].
///
/// The generated [FortalDialog] defaults to [FortalDialogSize.size3],
/// [FortalDialogAlign.center], fills up to 600 logical pixels, preserves safe
/// viewport insets, and is modal.
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
      .wrap(
        .modifier(
          PaddingModifierMix.create(padding: Prop.token(_dialogViewportInsets)),
        ).align(alignment: alignment).orderOfModifiers([
          PaddingModifier,
          AlignModifier,
        ]),
      )
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
            .margin(.top(FortalTokens.space5())),
      )
      .width(600)
      .padding(.all(padding))
      .borderRadius(.all(radius))
      .color(FortalTokens.colorPanel())
      .decoration(
        BoxDecorationMix.create(boxShadow: FortalTokens.shadow6.mix()),
      )
      .containerEffects(
        RemixBoxEffectsMix.backdropBlur(FortalTokens.panelBlur()),
      );
}
