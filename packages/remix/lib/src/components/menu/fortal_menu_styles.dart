part of 'menu.dart';

/// Radix Themes menu content sizes.
enum FortalMenuSize { size1, size2 }

/// Radix Themes menu content variants.
enum FortalMenuVariant { solid, soft }

/// Fortal menu content with Radix-owned size, variant, and contrast behavior.
@MixWidget(target: RemixMenu.new)
RemixMenuStyler fortalMenuStyle({
  FortalMenuVariant variant = .solid,
  FortalMenuSize size = .size2,
  bool highContrast = false,
}) {
  final metrics = _fortalMenuMetrics(size);
  return RemixMenuStyler()
      .overlay(
        FlexBoxStyler()
            .paddingAll(metrics.contentPadding)
            .borderRadiusAll(metrics.contentRadius)
            .color(FortalTokens.colorPanel())
            .decoration(
              BoxDecorationMix.create(boxShadow: FortalTokens.shadow5.mix()),
            )
            .clipBehavior(Clip.antiAlias),
      )
      .containerEffects(
        RemixBoxEffectsMix(backdropBlur: FortalTokens.panelBlur()),
      )
      .item(_fortalMenuItemStyler(variant, metrics, highContrast: highContrast))
      .divider(_fortalMenuDividerStyler(metrics));
}

/// Fortal item recipe for per-item style overrides.
RemixMenuItemStyler fortalMenuItemStyle({
  FortalMenuVariant variant = .solid,
  FortalMenuSize size = .size2,
  bool highContrast = false,
}) => _fortalMenuItemStyler(
  variant,
  _fortalMenuMetrics(size),
  highContrast: highContrast,
);

RemixMenuItemStyler _fortalMenuItemStyler(
  FortalMenuVariant variant,
  _FortalMenuMetrics metrics, {
  required bool highContrast,
}) {
  final base = RemixMenuItemStyler()
      .direction(.horizontal)
      .mainAxisSize(.max)
      .crossAxisAlignment(.center)
      .spacing(FortalTokens.space2())
      .height(metrics.itemHeight)
      .paddingX(metrics.leadingInset)
      .borderRadiusAll(metrics.itemRadius)
      .label(.style(metrics.text.mix()).color(FortalTokens.gray12()))
      .leadingIcon(.color(FortalTokens.gray12()).size(metrics.indicatorSize))
      .trailingIcon(.color(FortalTokens.gray12()).size(metrics.indicatorSize));

  final highlighted = switch (variant) {
    .solid =>
      RemixMenuItemStyler()
          .color(
            highContrast ? FortalTokens.accent12() : FortalTokens.accent9(),
          )
          .label(
            .color(
              highContrast
                  ? FortalTokens.accent1()
                  : FortalTokens.accentContrast(),
            ),
          )
          .leadingIcon(
            .color(
              highContrast
                  ? FortalTokens.accent1()
                  : FortalTokens.accentContrast(),
            ),
          )
          .trailingIcon(
            .color(
              highContrast
                  ? FortalTokens.accent1()
                  : FortalTokens.accentContrast(),
            ),
          ),
    .soft => RemixMenuItemStyler().color(FortalTokens.accentA4()),
  };
  final submenuOpen = RemixMenuItemStyler().color(
    variant == .solid ? FortalTokens.grayA3() : FortalTokens.accentA3(),
  );
  final disabled = RemixMenuItemStyler()
      .color(Colors.transparent)
      .label(.color(FortalTokens.grayA8()))
      .leadingIcon(.color(FortalTokens.grayA8()))
      .trailingIcon(.color(FortalTokens.grayA8()));

  return base
      .onSelected(submenuOpen)
      .onHovered(highlighted)
      .onFocused(highlighted)
      .onPressed(highlighted)
      .onDisabled(disabled);
}

RemixDividerStyler _fortalMenuDividerStyler(_FortalMenuMetrics metrics) =>
    RemixDividerStyler()
        .height(1)
        .marginOnly(
          left: metrics.leadingInset,
          right: metrics.trailingInset,
          top: FortalTokens.space2(),
          bottom: FortalTokens.space2(),
        )
        .color(FortalTokens.grayA6());

class _FortalMenuMetrics {
  const _FortalMenuMetrics({
    required this.contentPadding,
    required this.contentRadius,
    required this.itemHeight,
    required this.itemRadius,
    required this.leadingInset,
    required this.trailingInset,
    required this.indicatorSize,
    required this.text,
  });

  final double contentPadding;
  final Radius contentRadius;
  final double itemHeight;
  final Radius itemRadius;
  final double leadingInset;
  final double trailingInset;
  final double indicatorSize;
  final TextStyleToken text;
}

_FortalMenuMetrics _fortalMenuMetrics(FortalMenuSize size) => switch (size) {
  .size1 => _FortalMenuMetrics(
    contentPadding: FortalTokens.space1(),
    contentRadius: FortalTokens.radius3(),
    itemHeight: FortalTokens.space5(),
    itemRadius: FortalTokens.radius1(),
    leadingInset: FortalTokens.space2(),
    trailingInset: FortalTokens.space2(),
    indicatorSize: FortalTokens.selectIndicatorSize1(),
    text: FortalTokens.text1,
  ),
  .size2 => _FortalMenuMetrics(
    contentPadding: FortalTokens.space2(),
    contentRadius: FortalTokens.radius4(),
    itemHeight: FortalTokens.space6(),
    itemRadius: FortalTokens.radius2(),
    leadingInset: FortalTokens.space3(),
    trailingInset: FortalTokens.space3(),
    indicatorSize: FortalTokens.selectIndicatorSize2(),
    text: FortalTokens.text2,
  ),
};
