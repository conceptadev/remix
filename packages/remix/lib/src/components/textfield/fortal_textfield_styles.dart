part of 'textfield.dart';

/// Fortal text field size presets.
enum FortalTextFieldSize {
  /// Compact text field.
  size1,

  /// Default text field.
  size2,

  /// Large text field.
  size3,
}

/// Fortal text field color variants.
enum FortalTextFieldVariant {
  /// Raised treatment with Radix's level-one shadow.
  classic,

  /// Surface treatment with neutral border and text colors.
  surface,

  /// Soft accent treatment.
  soft,
}

/// Fortal-themed preset for [RemixTextField].
@MixWidget(target: RemixTextField.new)
TextFieldStyler fortalTextFieldStyle({
  FortalTextFieldVariant variant = .surface,
  FortalTextFieldSize size = .size2,
}) {
  final metrics = _fortalTextFieldMetrics(size, bordered: variant != .soft);
  final base = _fortalTextInputBaseStyle(
    container: BoxStyler()
        .height(metrics.height)
        .paddingX(metrics.paddingX)
        .borderRadiusAll(metrics.radius)
        .clipBehavior(.antiAlias),
    spacing: metrics.spacing,
    crossAxisAlignment: .center,
    text: metrics.text,
    focusColor: variant == .soft
        ? FortalTokens.accent8()
        : FortalTokens.focus8(),
  );

  final style = switch (variant) {
    .classic => _fortalApplyClassicTextInput(base),
    .surface => _fortalApplySurfaceTextInput(base),
    .soft => _fortalApplySoftTextInput(base, placeholderOpacity: 0.60),
  };

  return style.variant(
    ContextVariant.widgetState(.error),
    _fortalTextInputErrorStyle(),
  );
}

TextFieldStyler _fortalTextInputBaseStyle({
  required BoxStyler container,
  required double spacing,
  required CrossAxisAlignment crossAxisAlignment,
  required TextStyleToken text,
  required Color focusColor,
}) =>
    TextFieldStyler(
          container: container,
          spacing: spacing,
          crossAxisAlignment: crossAxisAlignment,
          text: .style(text.mix()),
          hintText: .style(text.mix()).textHeightBehavior(
            TextHeightBehaviorMix()
                .applyHeightToFirstAscent(false)
                .applyHeightToLastDescent(true),
          ),
          helperText: .style(FortalTokens.text1.mix()),
          label: .style(FortalTokens.text2.mix()),
          cursorWidth: 1.5,
          containerEffects: RemixBoxEffectsMix(
            behindContent: _fortalTextInputLayer(),
            overContent: _fortalTextInputLayer(),
          ),
        )
        .wrap(.iconTheme(color: FortalTokens.gray11(), size: 16.0))
        .onFocused(
          .containerEffects(fortalFocusOutline(focusColor, offset: -1)),
        );

TextFieldStyler _fortalApplyClassicTextInput(TextFieldStyler base) =>
    _fortalApplyNeutralTextInput(base)
        .color(FortalTokens.colorSurface())
        .containerEffects(
          RemixBoxEffectsMix(
            behindContent: _fortalTextInputLayer(
              shadowToken: FortalTokens.shadow1Layers,
            ),
          ),
        )
        .onDisabled(
          _fortalTextInputDisabledStyle()
              .color(FortalTokens.colorSurface())
              .containerEffects(
                RemixBoxEffectsMix(
                  behindContent: _fortalTextInputLayer(
                    gradients: [
                      RemixLinearGradientMix(
                        colors: [FortalTokens.grayA2(), FortalTokens.grayA2()],
                      ),
                    ],
                    shadowToken: FortalTokens.shadow1Layers,
                  ),
                ),
              ),
        );

TextFieldStyler _fortalApplySurfaceTextInput(TextFieldStyler base) =>
    _fortalApplyNeutralTextInput(base)
        .color(FortalTokens.colorSurface())
        .containerEffects(
          RemixBoxEffectsMix(behindContent: _fortalTextInputLayer()),
        )
        .containerEffects(
          RemixBoxEffectsMix(
            overContent: _fortalTextInputInsetRing(FortalTokens.grayA7()),
          ),
        )
        .onDisabled(
          _fortalTextInputDisabledStyle()
              .color(FortalTokens.colorSurface())
              .containerEffects(
                RemixBoxEffectsMix(
                  behindContent: _fortalTextInputLayer(
                    gradients: [
                      RemixLinearGradientMix(
                        colors: [FortalTokens.grayA2(), FortalTokens.grayA2()],
                      ),
                    ],
                  ),
                ),
              )
              .containerEffects(
                RemixBoxEffectsMix(
                  overContent: _fortalTextInputInsetRing(FortalTokens.grayA6()),
                ),
              ),
        );

TextFieldStyler _fortalApplySoftTextInput(
  TextFieldStyler base, {
  required double placeholderOpacity,
}) => base
    .merge(
      TextFieldStyler(
        text: .fontWeight(FortalTokens.fontWeightRegular()),
        hintText: .fontWeight(FortalTokens.fontWeightRegular()),
        cursorColor: FortalTokens.accent12(),
        helperText: .color(
          FortalTokens.gray11(),
        ).fontWeight(FortalTokens.fontWeightRegular()),
        label: .color(
          FortalTokens.gray12(),
        ).fontWeight(FortalTokens.fontWeightMedium()),
      ),
    )
    .textColor(FortalTokens.accent12())
    .onEnabled(
      .hintText(
        .color(FortalTokens.accent12().withValues(alpha: placeholderOpacity)),
      ),
    )
    .wrap(.iconTheme(color: FortalTokens.accent10()))
    .color(FortalTokens.accentA3())
    .containerEffects(
      RemixBoxEffectsMix(behindContent: _fortalTextInputLayer()),
    )
    .onDisabled(
      _fortalTextInputDisabledStyle()
          .color(FortalTokens.grayA3())
          .containerEffects(
            RemixBoxEffectsMix(behindContent: _fortalTextInputLayer()),
          ),
    );

TextFieldStyler _fortalApplyNeutralTextInput(TextFieldStyler base) =>
    base.merge(
      TextFieldStyler(
        text: .color(FortalTokens.gray12()),
        hintText: .color(FortalTokens.grayA10()),
        cursorColor: FortalTokens.gray12(),
        helperText: .color(FortalTokens.gray11()),
        label: .color(
          FortalTokens.gray12(),
        ).fontWeight(FortalTokens.fontWeightMedium()),
      ),
    );

TextFieldStyler _fortalTextInputDisabledStyle() =>
    TextFieldStyler(
      text: .color(FortalTokens.gray11()),
      hintText: .color(FortalTokens.grayA8()),
      cursorColor: FortalTokens.gray8(),
    ).onFocused(
      .containerEffects(fortalFocusOutline(FortalTokens.gray8(), offset: -1)),
    );

TextFieldStyler _fortalTextInputErrorStyle() => TextFieldStyler(
  helperText: .color(FortalTokens.error11()),
  label: .color(FortalTokens.error11()),
  cursorColor: FortalTokens.error9(),
  containerEffects: RemixBoxEffectsMix(
    overContent: _fortalTextInputLayer(
      shadows: [
        RemixBoxShadowMix(
          kind: .inset,
          color: FortalTokens.errorA7(),
          spreadRadius: 1,
        ),
      ],
    ),
    outline: BorderSideMix(
      color: FortalTokens.error8(),
      width: 2,
      strokeAlign: BorderSide.strokeAlignInside,
    ),
    outlineOffset: -1,
  ),
);

({
  double height,
  double paddingX,
  double spacing,
  Radius radius,
  TextStyleToken text,
})
_fortalTextFieldMetrics(FortalTextFieldSize size, {required bool bordered}) =>
    switch (size) {
      .size1 => (
        height: FortalTokens.space5(),
        paddingX: bordered
            ? FortalTokens.textFieldPadding1()
            : FortalTokens.selectSpace1Half(),
        spacing: FortalTokens.space2(),
        radius: FortalTokens.radius2OrFull(),
        text: FortalTokens.text1,
      ),
      .size2 => (
        height: FortalTokens.space6(),
        paddingX: bordered
            ? FortalTokens.textFieldPadding2()
            : FortalTokens.space2(),
        spacing: FortalTokens.space2(),
        radius: FortalTokens.radius2OrFull(),
        text: FortalTokens.text2,
      ),
      .size3 => (
        height: FortalTokens.space7(),
        paddingX: bordered
            ? FortalTokens.textFieldPadding3()
            : FortalTokens.space3(),
        spacing: FortalTokens.space3(),
        radius: FortalTokens.radius3OrFull(),
        text: FortalTokens.text3,
      ),
    };

RemixBoxEffectLayerMix _fortalTextInputInsetRing(Color color) =>
    _fortalTextInputLayer(
      shadows: [RemixBoxShadowMix(kind: .inset, color: color, spreadRadius: 1)],
    );

RemixBoxEffectLayerMix _fortalTextInputLayer({
  List<RemixLinearGradientMix>? gradients,
  List<RemixBoxShadowMix>? shadows,
  RemixBoxShadowListToken? shadowToken,
}) => RemixBoxEffectLayerMix(
  gradients: gradients,
  shadows: shadows,
  shadowToken: shadowToken,
);
