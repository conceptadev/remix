import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../fortal/fortal.dart';
import 'typography_shared.dart';

/// Radix Themes Code variants.
enum FortalCodeVariant { solid, soft, outline, ghost }

/// Fortal-themed inline code on the Radix nine-step scale.
///
/// Geometry is em-relative to the resolved font size, so this recipe takes a
/// [context]: an explicit [size] resolves its text token, and an omitted one
/// inherits the ambient `DefaultTextStyle` exactly as Radix's `1em` does.
BadgeStyler fortalCodeStyle(
  BuildContext context, {
  FortalTextSize? size,
  FortalCodeVariant variant = .soft,
  FortalTextWeight? weight,
  bool softWrap = true,
  bool truncate = false,
  bool accent = false,
  bool highContrast = false,
}) {
  final base = size == null
      ? DefaultTextStyle.of(context).style
      : fortalResolveTextToken(context, size);
  final baseFontSize = fortalResolvedFontSize(base);

  // Radix nests two adjustments: --code-font-size-adjust is 0.95, and
  // --code-variant-font-size-adjust multiplies it by 0.95 again for every
  // variant except ghost, which keeps the outer value.
  final decorated = variant != FortalCodeVariant.ghost;
  final fontSize = baseFontSize * (decorated ? 0.95 * 0.95 : 0.95);
  // An explicit size keeps its token's absolute line box; the inherited path
  // uses the pinned unitless 1.25.
  final lineHeight = size == null
      ? 1.25
      : (baseFontSize * (base.height ?? 1)) / fontSize;
  final letterSpacing = (base.letterSpacing ?? 0) - (0.007 * fontSize);

  var textStyle = TextStyler()
      .fontFamily('Menlo')
      .fontFamilyFallback(const [
        'Consolas',
        'Bitstream Vera Sans Mono',
        'monospace',
        'Apple Color Emoji',
        'Segoe UI Emoji',
      ])
      .fontSize(fontSize)
      .height(lineHeight)
      .letterSpacing(letterSpacing);
  if (weight != null) {
    textStyle = textStyle.fontWeight(fortalTextWeightToken(weight)());
  }
  textStyle = fortalApplyTextFlow(
    textStyle,
    softWrap: softWrap,
    truncate: truncate,
  );

  Color? fill;
  Color? foreground;
  final accent1 = fortalResolveColor(context, FortalTokens.accent1);
  final accent12 = fortalResolveColor(context, FortalTokens.accent12);
  final accentA3 = fortalResolveColor(context, FortalTokens.accentA3);
  final accentA9 = fortalResolveColor(context, FortalTokens.accentA9);
  final accentA11 = fortalResolveColor(context, FortalTokens.accentA11);
  final accentContrast = fortalResolveColor(
    context,
    FortalTokens.accentContrast,
  );
  switch (variant) {
    case .solid:
      fill = highContrast ? accent12 : accentA9;
      foreground = highContrast ? accent1 : accentContrast;
    case .soft:
      fill = accentA3;
      foreground = highContrast ? accent12 : accentA11;
    case .outline:
      foreground = highContrast ? accent12 : accentA11;
    case .ghost:
      // Ghost is transparent and inherits the ambient colour unless the caller
      // opts into the local accent.
      if (accent) foreground = highContrast ? accent12 : accentA11;
  }
  if (foreground != null) textStyle = textStyle.color(foreground);

  var style = BadgeStyler()
      .label(textStyle)
      .borderRadius(
        BorderRadiusGeometryMix.circular(
          (0.5 + 0.2 * fontSize) * fortalRadiusFactor(context),
        ),
      );
  if (decorated) {
    style = style.padding(
      EdgeInsetsGeometryMix.symmetric(
        horizontal: 0.25 * fontSize,
        vertical: 0.10 * fontSize,
      ),
    );
  }
  if (fill != null) style = style.color(fill);

  if (variant == FortalCodeVariant.outline) {
    final ringWidth = math.max(1.0, 0.033 * fontSize);
    style = style.containerEffects(
      RemixBoxEffectsMix(
        behindContent: RemixBoxEffectLayerMix(
          shadows: [
            RemixBoxShadowMix(
              kind: .inset,
              color: fortalResolveColor(
                context,
                highContrast ? FortalTokens.accentA7 : FortalTokens.accentA8,
              ),
              spreadRadius: ringWidth,
            ),
            if (highContrast)
              RemixBoxShadowMix(
                kind: .inset,
                color: fortalResolveColor(context, FortalTokens.grayA11),
                spreadRadius: ringWidth,
              ),
          ],
        ),
      ),
    );
  }

  return style;
}

/// Token-backed standalone code text with the Radix Code variants.
///
/// Code carries no accessibility role: Flutter has no code semantics, and
/// inventing one would misreport the content.
class FortalCode extends StatelessWidget {
  const FortalCode(
    this.text, {
    super.key,
    this.size,
    this.variant = FortalCodeVariant.soft,
    this.weight,
    this.softWrap = true,
    this.truncate = false,
    this.accent = false,
    this.highContrast = false,
  }) : assert(text != '');

  const FortalCode.solid(
    this.text, {
    super.key,
    this.size,
    this.weight,
    this.softWrap = true,
    this.truncate = false,
    this.accent = false,
    this.highContrast = false,
  }) : variant = FortalCodeVariant.solid,
       assert(text != '');

  const FortalCode.soft(
    this.text, {
    super.key,
    this.size,
    this.weight,
    this.softWrap = true,
    this.truncate = false,
    this.accent = false,
    this.highContrast = false,
  }) : variant = FortalCodeVariant.soft,
       assert(text != '');

  const FortalCode.outline(
    this.text, {
    super.key,
    this.size,
    this.weight,
    this.softWrap = true,
    this.truncate = false,
    this.accent = false,
    this.highContrast = false,
  }) : variant = FortalCodeVariant.outline,
       assert(text != '');

  const FortalCode.ghost(
    this.text, {
    super.key,
    this.size,
    this.weight,
    this.softWrap = true,
    this.truncate = false,
    this.accent = false,
    this.highContrast = false,
  }) : variant = FortalCodeVariant.ghost,
       assert(text != '');

  final String text;
  final FortalTextSize? size;
  final FortalCodeVariant variant;
  final FortalTextWeight? weight;
  final bool softWrap;
  final bool truncate;
  final bool accent;
  final bool highContrast;

  @override
  Widget build(BuildContext context) => fortalCodeStyle(
    context,
    size: size,
    variant: variant,
    weight: weight,
    softWrap: softWrap,
    truncate: truncate,
    accent: accent,
    highContrast: highContrast,
  )(label: text);
}
