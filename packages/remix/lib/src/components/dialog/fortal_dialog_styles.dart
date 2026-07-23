part of 'dialog.dart';

/// Fortal dialog size presets matching Radix Themes 3.3.0.
enum FortalDialogSize { size1, size2, size3, size4 }

/// Vertical placement of a Fortal dialog within its viewport.
enum FortalDialogAlign { start, center }

/// Fortal-themed preset for [RemixDialog].
RemixDialogStyler fortalDialogStyler({
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
class FortalDialog extends StatelessWidget {
  const FortalDialog({
    super.key,
    this.size = FortalDialogSize.size3,
    this.align = FortalDialogAlign.center,
    this.width = double.infinity,
    this.minWidth,
    this.maxWidth = 600,
    this.height,
    this.minHeight,
    this.maxHeight,
    this.child,
    this.title,
    this.description,
    this.actions,
    this.modal = true,
    this.semanticLabel,
  });

  final FortalDialogSize size;

  final FortalDialogAlign align;

  final double? width;

  final double? minWidth;

  final double? maxWidth;

  final double? height;

  final double? minHeight;

  final double? maxHeight;

  final Widget? child;

  final String? title;

  final String? description;

  final List<Widget>? actions;

  final bool modal;

  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final horizontalInset = MixScope.tokenOf(FortalTokens.space4, context);
    final verticalInset = MixScope.tokenOf(FortalTokens.space6, context);
    final viewportHeight = MediaQuery.maybeOf(context)?.size.height ?? 0;
    final proportionalBottomInset = viewportHeight * 0.06;

    return fortalDialogStyler(size: size).call(
      key: key,
      title: title,
      description: description,
      actions: actions,
      modal: modal,
      semanticLabel: semanticLabel,
      alignment: switch (align) {
        FortalDialogAlign.start => RemixDialogAlignment.start,
        FortalDialogAlign.center => RemixDialogAlignment.center,
      },
      width: width,
      minWidth: minWidth,
      maxWidth: maxWidth,
      height: height,
      minHeight: minHeight,
      maxHeight: maxHeight,
      insetPadding: EdgeInsets.fromLTRB(
        horizontalInset,
        verticalInset,
        horizontalInset,
        proportionalBottomInset > verticalInset
            ? proportionalBottomInset
            : verticalInset,
      ),
      child: child,
    );
  }
}
