part of 'dialog.dart';

/// Fortal dialog size presets matching Radix Themes 3.3.0.
enum FortalDialogSize { size1, size2, size3, size4 }

/// Vertical placement of a Fortal dialog within its viewport.
enum FortalDialogAlign { start, center }

/// Fortal-themed preset for [RemixDialog].
@MixWidget(target: RemixDialog.new)
RemixDialogStyler fortalDialogStyle({
  FortalDialogSize size = FortalDialogSize.size3,
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

  return RemixDialogStyler()
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

/// Fortal-themed preset for [RemixDialog].
