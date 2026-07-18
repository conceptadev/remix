part of 'dialog.dart';

/// Fortal-themed preset for [RemixDialog].
RemixDialogStyler fortalDialogStyler() {
  return RemixDialogStyler()
      .title(
        TextStyler()
            .fontSize(18)
            .fontWeight(.w600)
            .color(FortalTokens.gray12())
            .wrap(
              .padding(EdgeInsetsMix.fromLTRB(0, 0, 0, FortalTokens.space4())),
            ),
      )
      .description(TextStyler().fontSize(14).color(FortalTokens.gray11()))
      .actions(
        FlexBoxStyler()
            .mainAxisAlignment(.end)
            .crossAxisAlignment(.center)
            .spacing(FortalTokens.space3())
            .marginTop(FortalTokens.space5()),
      )
      .padding(.all(FortalTokens.space5()))
      .constraints(BoxConstraintsMix(maxWidth: 450))
      .border(
        .all(
          BorderSideMix()
              .color(FortalTokens.gray6())
              .width(FortalTokens.borderWidth1()),
        ),
      )
      .borderRadius(.all(FortalTokens.radius3()))
      .backgroundColor(FortalTokens.colorPanel())
      // Radix --shadow-6, sourced from the shared mode-aware shadow tokens so
      // the light/dark layer recipes stay defined once in buildFortalShadows.
      .decoration(
        BoxDecorationMix.create(boxShadow: FortalTokens.shadow6.mix()),
      );
}

/// Fortal-themed preset for [RemixDialog].
class FortalDialog extends StatelessWidget {
  const FortalDialog({
    super.key,
    this.color,
    this.radius,
    this.child,
    this.title,
    this.description,
    this.actions,
    this.modal = true,
    this.semanticLabel,
  });

  /// Optional accent color override for this dialog subtree.
  final FortalAccentColor? color;

  /// Optional radius override for this dialog subtree.
  final FortalRadius? radius;

  final Widget? child;

  final String? title;

  final String? description;

  final List<Widget>? actions;

  final bool modal;

  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return FortalOverride(
      color: this.color,
      radius: this.radius,
      child: fortalDialogStyler().call(
        key: this.key,
        title: this.title,
        description: this.description,
        actions: this.actions,
        modal: this.modal,
        semanticLabel: this.semanticLabel,
        child: this.child,
      ),
    );
  }
}
