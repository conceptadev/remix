part of 'callout.dart';

/// Radix Themes Callout size presets.
enum FortalCalloutSize { size1, size2, size3 }

/// Radix Themes Callout variants.
enum FortalCalloutVariant { soft, surface, outline }

/// Fortal-themed Callout with the Radix size, variant, and override contract.
@MixWidget(target: RemixCallout.new)
RemixCalloutStyler fortalCalloutStyle({
  FortalCalloutVariant variant = .soft,
  FortalCalloutSize size = .size2,
  bool highContrast = false,
}) {
  final base = _fortalCalloutBaseStyler(size).foregroundColor(
    highContrast ? FortalTokens.accent12() : FortalTokens.accentA11(),
  );
  return switch (variant) {
    .soft => base.color(FortalTokens.accentA3()),
    .surface =>
      base
          .color(FortalTokens.accentA2())
          .containerEffects(
            RemixBoxEffectsMix(
              behindContent: RemixBoxEffectLayerMix(
                shadows: [
                  RemixBoxShadowMix(
                    kind: RemixBoxShadowKind.inset,
                    color: FortalTokens.accentA6(),
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ),
    .outline => base.containerEffects(
      RemixBoxEffectsMix(
        behindContent: RemixBoxEffectLayerMix(
          shadows: [
            RemixBoxShadowMix(
              kind: RemixBoxShadowKind.inset,
              color: FortalTokens.accentA7(),
              spreadRadius: 1,
            ),
          ],
        ),
      ),
    ),
  };
}

RemixCalloutStyler _fortalCalloutBaseStyler(FortalCalloutSize size) {
  final radius = _fortalCalloutRadius(size);
  return RemixCalloutStyler(
    container: .direction(.horizontal)
        .mainAxisSize(.min)
        .crossAxisAlignment(.start)
        .spacing(_fortalCalloutGap(size))
        .padding(EdgeInsetsGeometryMix.all(_fortalCalloutPadding(size))),
    text: .style(_fortalCalloutText(size).mix()),
    icon: .size(_fortalCalloutIconSize(size)),
  ).borderRadiusAll(radius);
}

double _fortalCalloutPadding(FortalCalloutSize size) => switch (size) {
  .size1 => FortalTokens.space3(),
  .size2 => FortalTokens.space4(),
  .size3 => FortalTokens.space5(),
};

double _fortalCalloutGap(FortalCalloutSize size) => switch (size) {
  .size1 => FortalTokens.space2(),
  .size2 => FortalTokens.space3(),
  .size3 => FortalTokens.space4(),
};

TextStyleToken _fortalCalloutText(FortalCalloutSize size) => switch (size) {
  .size1 || .size2 => FortalTokens.text2,
  .size3 => FortalTokens.text3,
};

double _fortalCalloutIconSize(FortalCalloutSize size) => switch (size) {
  .size1 || .size2 => FortalTokens.space4(),
  .size3 => FortalTokens.spinnerSize3(),
};

Radius _fortalCalloutRadius(FortalCalloutSize size) => switch (size) {
  .size1 => FortalTokens.radius3(),
  .size2 => FortalTokens.radius4(),
  .size3 => FortalTokens.radius5(),
};
