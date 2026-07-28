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
RemixTextFieldStyler fortalTextFieldStyle({
  FortalTextFieldVariant variant = .surface,
  FortalTextFieldSize size = .size2,
}) {
  final style = switch (variant) {
    .classic => _fortalTextFieldClassicStyler(size),
    .surface => _fortalTextFieldSurfaceStyler(size),
    .soft => _fortalTextFieldSoftStyler(size),
  };
  return style.variant(
    ContextVariant.widgetState(.error),
    _fortalTextFieldErrorStyler(),
  );
}

RemixTextFieldStyler _fortalTextFieldBaseStyler(
  FortalTextFieldSize size, {
  required bool bordered,
}) {
  final metrics = _fortalTextFieldMetrics(size, bordered: bordered);
  return RemixTextFieldStyler(
        container: .height(metrics.height)
            .paddingX(metrics.paddingX)
            .spacing(metrics.spacing)
            .crossAxisAlignment(.center)
            .borderRadiusAll(metrics.radius)
            .clipBehavior(.antiAlias),
        text: .style(metrics.text.mix()),
        hintText: .style(metrics.text.mix()).textHeightBehavior(
          TextHeightBehaviorMix()
              .applyHeightToFirstAscent(false)
              .applyHeightToLastDescent(true),
        ),
        helperText: .style(FortalTokens.text1.mix()),
        label: .style(FortalTokens.text2.mix()),
        cursorWidth: 1.5,
        containerEffects: RemixBoxEffectsMix(
          behindContent: _fortalTextFieldLayer(),
          overContent: _fortalTextFieldLayer(),
        ),
      )
      .wrap(.iconTheme(color: FortalTokens.gray11(), size: 16.0))
      .onFocused(
        .containerEffects(
          RemixBoxEffectsMix(
            outline: BorderSideMix(
              color: FortalTokens.focus8(),
              width: 2,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
            outlineOffset: -1,
          ),
        ),
      );
}

RemixTextFieldStyler _fortalTextFieldClassicStyler(FortalTextFieldSize size) {
  return _fortalTextFieldNeutralText(
        _fortalTextFieldBaseStyler(size, bordered: true),
      )
      .color(FortalTokens.colorSurface())
      .containerEffects(
        RemixBoxEffectsMix(
          behindContent: _fortalTextFieldLayer(
            shadowToken: FortalTokens.shadow1Layers,
          ),
        ),
      )
      .onDisabled(
        _fortalTextFieldDisabledText()
            .color(FortalTokens.colorSurface())
            .containerEffects(
              RemixBoxEffectsMix(
                behindContent: _fortalTextFieldLayer(
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
}

RemixTextFieldStyler _fortalTextFieldSurfaceStyler([
  FortalTextFieldSize size = .size2,
]) {
  return _fortalTextFieldNeutralText(
        _fortalTextFieldBaseStyler(size, bordered: true),
      )
      .color(FortalTokens.colorSurface())
      .containerEffects(
        RemixBoxEffectsMix(behindContent: _fortalTextFieldLayer()),
      )
      .containerEffects(
        RemixBoxEffectsMix(
          overContent: _fortalTextFieldInsetRing(FortalTokens.grayA7()),
        ),
      )
      .onDisabled(
        _fortalTextFieldDisabledText()
            .color(FortalTokens.colorSurface())
            .containerEffects(
              RemixBoxEffectsMix(
                behindContent: _fortalTextFieldLayer(
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
                overContent: _fortalTextFieldInsetRing(FortalTokens.grayA6()),
              ),
            ),
      );
}

RemixTextFieldStyler _fortalTextFieldSoftStyler([
  FortalTextFieldSize size = .size2,
]) {
  return _fortalTextFieldBaseStyler(size, bordered: false)
      .merge(
        RemixTextFieldStyler(
          text: .fontWeight(FortalTokens.fontWeightRegular()),
          hintText: .color(
            FortalTokens.accentA11(),
          ).fontWeight(FortalTokens.fontWeightRegular()),
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
      .wrap(.iconTheme(color: FortalTokens.accent10()))
      .color(FortalTokens.accentA3())
      .containerEffects(
        RemixBoxEffectsMix(behindContent: _fortalTextFieldLayer()),
      )
      .onDisabled(
        _fortalTextFieldDisabledText()
            .color(FortalTokens.grayA3())
            .containerEffects(
              RemixBoxEffectsMix(behindContent: _fortalTextFieldLayer()),
            ),
      );
}

RemixTextFieldStyler _fortalTextFieldNeutralText(RemixTextFieldStyler base) =>
    base.merge(
      RemixTextFieldStyler(
        text: .color(FortalTokens.gray12()),
        hintText: .color(FortalTokens.grayA10()),
        cursorColor: FortalTokens.gray12(),
        helperText: .color(FortalTokens.gray11()),
        label: .color(
          FortalTokens.gray12(),
        ).fontWeight(FortalTokens.fontWeightMedium()),
      ),
    );

RemixTextFieldStyler _fortalTextFieldDisabledText() =>
    RemixTextFieldStyler(
      text: .color(FortalTokens.gray11()),
      hintText: .color(FortalTokens.grayA8()),
      cursorColor: FortalTokens.gray8(),
    ).onFocused(
      .containerEffects(
        RemixBoxEffectsMix(
          outline: BorderSideMix(
            color: FortalTokens.gray8(),
            width: 2,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
          outlineOffset: -1,
        ),
      ),
    );

RemixTextFieldStyler _fortalTextFieldErrorStyler() {
  return RemixTextFieldStyler(
    helperText: .color(FortalTokens.error11()),
    label: .color(FortalTokens.error11()),
    cursorColor: FortalTokens.error9(),
    containerEffects: RemixBoxEffectsMix(
      overContent: _fortalTextFieldLayer(
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
}

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

RemixBoxEffectLayerMix _fortalTextFieldInsetRing(Color color) =>
    _fortalTextFieldLayer(
      shadows: [RemixBoxShadowMix(kind: .inset, color: color, spreadRadius: 1)],
    );

RemixBoxEffectLayerMix _fortalTextFieldLayer({
  List<RemixLinearGradientMix>? gradients,
  List<RemixBoxShadowMix>? shadows,
  RemixBoxShadowListToken? shadowToken,
}) => RemixBoxEffectLayerMix(
  gradients: gradients,
  shadows: shadows,
  shadowToken: shadowToken,
);

/// Fortal-themed preset for [RemixTextField].
