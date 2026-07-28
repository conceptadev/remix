part of 'toggle.dart';

/// Fortal toggle size presets.
enum FortalToggleSize { size1, size2, size3 }

/// Fortal toggle color and border variants.
enum FortalToggleVariant { ghost, outline }

/// Fortal-themed preset for [RemixToggle].
@MixWidget(target: RemixToggle.new)
RemixToggleStyler fortalToggleStyle({
  FortalToggleVariant variant = .ghost,
  FortalToggleSize size = .size2,
  bool highContrast = false,
}) {
  return switch (variant) {
    .ghost => _fortalToggleGhostStyler(size, highContrast: highContrast),
    .outline => _fortalToggleOutlineStyler(size, highContrast: highContrast),
  };
}

RemixToggleStyler _fortalToggleBaseStyler(FortalToggleSize size) {
  return RemixToggleStyler()
      .container(.mainAxisSize(.min))
      .foregroundColor(FortalTokens.gray12())
      .labelFontWeight(FortalTokens.fontWeightMedium())
      .merge(_fortalToggleSizeStyler(size));
}

RemixToggleStyler _fortalToggleFocusStyler() {
  return RemixToggleStyler().borderAll(
    color: FortalTokens.focusA8(),
    width: FortalTokens.focusRingWidth(),
    strokeAlign: BorderSide.strokeAlignInside,
  );
}

RemixToggleStyler _fortalToggleDisabledStyler({bool outlined = false}) {
  final style = RemixToggleStyler()
      .backgroundColor(FortalTokens.grayA3())
      .foregroundColor(FortalTokens.gray8());
  return outlined
      ? style.borderAll(
          color: FortalTokens.grayA6(),
          width: FortalTokens.borderWidth1(),
          strokeAlign: BorderSide.strokeAlignInside,
        )
      : style;
}

RemixToggleStyler _fortalToggleGhostStyler(
  FortalToggleSize size, {
  required bool highContrast,
}) {
  return _fortalToggleBaseStyler(size)
      .backgroundColor(Colors.transparent)
      .onHovered(RemixToggleStyler().backgroundColor(FortalTokens.grayA3()))
      .onPressed(RemixToggleStyler().backgroundColor(FortalTokens.grayA4()))
      .onSelected(
        RemixToggleStyler()
            .backgroundColor(FortalTokens.accent3())
            .foregroundColor(
              highContrast ? FortalTokens.accent12() : FortalTokens.accent11(),
            )
            .onHovered(
              RemixToggleStyler().backgroundColor(FortalTokens.accent4()),
            )
            .onPressed(
              RemixToggleStyler().backgroundColor(FortalTokens.accent5()),
            ),
      )
      .onFocused(_fortalToggleFocusStyler())
      .onDisabled(_fortalToggleDisabledStyler());
}

RemixToggleStyler _fortalToggleOutlineStyler(
  FortalToggleSize size, {
  required bool highContrast,
}) {
  return _fortalToggleBaseStyler(size)
      .backgroundColor(Colors.transparent)
      .borderAll(
        color: FortalTokens.gray7(),
        width: FortalTokens.borderWidth1(),
        strokeAlign: BorderSide.strokeAlignInside,
      )
      .onHovered(RemixToggleStyler().backgroundColor(FortalTokens.grayA3()))
      .onPressed(RemixToggleStyler().backgroundColor(FortalTokens.grayA4()))
      .onSelected(
        RemixToggleStyler()
            .backgroundColor(FortalTokens.accentA3())
            .foregroundColor(
              highContrast ? FortalTokens.accent12() : FortalTokens.accent11(),
            )
            .borderAll(color: FortalTokens.accentA5())
            .onHovered(
              RemixToggleStyler().backgroundColor(FortalTokens.accentA4()),
            )
            .onPressed(
              RemixToggleStyler().backgroundColor(FortalTokens.accentA5()),
            ),
      )
      .onFocused(_fortalToggleFocusStyler())
      .onDisabled(_fortalToggleDisabledStyler(outlined: true));
}

RemixToggleStyler _fortalToggleSizeStyler(FortalToggleSize size) {
  return switch (size) {
    .size1 => RemixToggleStyler(
      container: FlexBoxStyler()
          .paddingX(FortalTokens.space2())
          .paddingY(FortalTokens.space1())
          .borderRadiusAll(FortalTokens.radius2())
          .spacing(FortalTokens.toggleGap1()),
      label: .style(FortalTokens.text1.mix()),
      icon: .size(FortalTokens.space3()),
    ),
    .size2 => RemixToggleStyler(
      container: FlexBoxStyler()
          .paddingX(FortalTokens.space3())
          .paddingY(FortalTokens.space2())
          .borderRadiusAll(FortalTokens.radius2())
          .spacing(FortalTokens.space1()),
      label: .style(FortalTokens.text2.mix()),
      icon: .size(FortalTokens.space4()),
    ),
    .size3 => RemixToggleStyler(
      container: FlexBoxStyler()
          .paddingX(FortalTokens.space4())
          .paddingY(FortalTokens.space2())
          .borderRadiusAll(FortalTokens.radius3())
          .spacing(FortalTokens.toggleGap3()),
      label: .style(FortalTokens.text3.mix()),
      icon: .size(FortalTokens.spinnerSize3()),
    ),
  };
}

/// Fortal-themed preset for [RemixToggle].
