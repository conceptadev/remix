import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';

part 'dialog.g.dart';

/// Ui dialog size presets matching Radix Themes 3.3.0.
enum UiDialogSize { size1, size2, size3, size4 }

/// Ui dialog vertical alignment matching Radix Themes 3.3.0.
enum UiDialogAlign { start, center }

final _dialogViewportInsets = ContextToken<EdgeInsetsGeometry>((context) {
  final safeArea = MediaQuery.paddingOf(context);
  final viewportHeight = MediaQuery.sizeOf(context).height;
  final horizontal = UiTokens.space4.resolve(context);
  final vertical = UiTokens.space6.resolve(context);

  return EdgeInsets.fromLTRB(
    math.max(safeArea.left, horizontal),
    math.max(safeArea.top, vertical),
    math.max(safeArea.right, horizontal),
    math.max(safeArea.bottom, math.max(vertical, viewportHeight * 0.06)),
  );
});

/// Ui-themed preset for [RemixDialog].
///
/// The generated [UiDialog] defaults to [UiDialogSize.size3],
/// [UiDialogAlign.center], fills up to 600 logical pixels, preserves safe
/// viewport insets, and is modal.
@MixWidget(target: RemixDialog.new)
DialogStyler uiDialogStyle({
  UiDialogSize size = UiDialogSize.size3,
  UiDialogAlign align = UiDialogAlign.center,
  DialogStyler style = const DialogStyler.create(),
}) {
  final radius = switch (size) {
    UiDialogSize.size1 || UiDialogSize.size2 => UiTokens.radius4(),
    UiDialogSize.size3 || UiDialogSize.size4 => UiTokens.radius5(),
  };
  final padding = switch (size) {
    UiDialogSize.size1 => UiTokens.space3(),
    UiDialogSize.size2 => UiTokens.space4(),
    UiDialogSize.size3 => UiTokens.space5(),
    UiDialogSize.size4 => UiTokens.space6(),
  };
  final alignment = switch (align) {
    UiDialogAlign.start => Alignment.topCenter,
    UiDialogAlign.center => Alignment.center,
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
        .style(UiTokens.text5.mix())
            .fontWeight(UiTokens.fontWeightBold())
            .color(UiTokens.gray12())
            .wrap(.padding(EdgeInsetsMix.fromLTRB(0, 0, 0, UiTokens.space3()))),
      )
      .description(
        TextStyler(style: UiTokens.text3.mix()).color(UiTokens.gray12()),
      )
      .actions(
        FlexBoxStyler()
            .mainAxisAlignment(.end)
            .spacing(UiTokens.space3())
            .margin(.top(UiTokens.space5())),
      )
      .width(600)
      .padding(.all(padding))
      .borderRadius(.all(radius))
      .color(UiTokens.colorPanel())
      .decoration(BoxDecorationMix.create(boxShadow: UiTokens.shadow6.mix()))
      .containerEffects(RemixBoxEffectsMix.backdropBlur(UiTokens.panelBlur()))
      .merge(style);
}
