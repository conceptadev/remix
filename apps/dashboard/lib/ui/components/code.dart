import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';
import 'typography.dart';

/// Radix Themes Code variants.
enum UiCodeVariant { solid, soft, outline, ghost }

/// Ui-themed inline code on the Radix nine-step scale.
///
/// Geometry is em-relative to the resolved font size, so this recipe takes a
/// [context]. An omitted [size] anchors to the root `text3` token — not the
/// ambient `DefaultTextStyle` — while keeping upstream's separate unsized
/// factors, so a host text run cannot change Code's geometry.
BadgeStyler uiCodeStyle(
  BuildContext context, {
  UiTextSize? size,
  UiCodeVariant variant = .soft,
  UiTextWeight? weight,
  bool softWrap = true,
  bool truncate = false,
  bool accent = false,
  bool highContrast = false,
  BadgeStyler style = const BadgeStyler.create(),
}) {
  final base = uiResolveTextToken(context, size ?? UiTextSize.size3);
  final baseFontSize = base.fontSize!;

  // Radix nests two adjustments: --code-font-size-adjust is 0.95, and
  // --code-variant-font-size-adjust multiplies it by 0.95 again for every
  // variant except ghost, which keeps the outer value.
  final decorated = variant != .ghost;
  final fontSize = baseFontSize * (decorated ? 0.95 * 0.95 : 0.95);
  // An explicit size keeps its token's absolute line box; the unsized path
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
      .letterSpacing(letterSpacing)
      .inherit(false);
  if (weight != null) {
    textStyle = textStyle.fontWeight(uiTextWeightToken(weight)());
  }
  textStyle = uiApplyTextFlow(
    textStyle,
    softWrap: softWrap,
    truncate: truncate,
  );

  Color? fill;
  Color? foreground;
  final accent1 = uiResolveColor(context, UiTokens.accent1);
  final accent12 = uiResolveColor(context, UiTokens.accent12);
  final accentA3 = uiResolveColor(context, UiTokens.accentA3);
  final accentA9 = uiResolveColor(context, UiTokens.accentA9);
  final accentA11 = uiResolveColor(context, UiTokens.accentA11);
  final accentContrast = uiResolveColor(context, UiTokens.accentContrast);
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
      // opts into the local accent. Apply only that intended ambient field
      // after Mix composition so an explicit recipe colour or foreground can
      // override it without creating an invalid Flutter TextStyle.
      if (accent) {
        foreground = highContrast ? accent12 : accentA11;
      } else {
        textStyle = textStyle.merge(
          TextStyler.create(
            style: Prop<TextStyle>.directives([
              _AmbientCodeForegroundDirective(
                DefaultTextStyle.of(context).style,
              ),
            ]),
          ),
        );
      }
  }
  if (foreground != null) textStyle = textStyle.color(foreground);

  var recipe = BadgeStyler()
      .label(textStyle)
      .borderRadius(
        BorderRadiusGeometryMix.circular(
          (0.5 + 0.2 * fontSize) * uiRadiusFactor(context),
        ),
      );
  if (decorated) {
    recipe = recipe.padding(
      EdgeInsetsGeometryMix.symmetric(
        horizontal: 0.25 * fontSize,
        vertical: 0.10 * fontSize,
      ),
    );
  }
  if (fill != null) recipe = recipe.color(fill);

  if (variant == .outline) {
    final ringWidth = math.max(1.0, 0.033 * fontSize);
    recipe = recipe.containerEffects(
      RemixBoxEffectsMix.behindContent(
        RemixBoxEffectLayerMix(
          shadows: [
            RemixBoxShadowMix(
              kind: .inset,
              color: uiResolveColor(
                context,
                highContrast ? UiTokens.accentA7 : UiTokens.accentA8,
              ),
              spreadRadius: ringWidth,
            ),
            if (highContrast)
              RemixBoxShadowMix(
                kind: .inset,
                color: uiResolveColor(context, UiTokens.grayA11),
                spreadRadius: ringWidth,
              ),
          ],
        ),
      ),
    );
  }

  return recipe.merge(style);
}

final class _AmbientCodeForegroundDirective extends Directive<TextStyle> {
  _AmbientCodeForegroundDirective(TextStyle ambient)
    : color = ambient.color,
      foreground = ambient.foreground;

  final Color? color;
  final Paint? foreground;

  @override
  String get key => 'ui_code_ambient_foreground';

  @override
  TextStyle apply(TextStyle style) {
    final hasAmbientFallback = _ambientCodeForegroundFallbacks[style] ?? false;
    if (!hasAmbientFallback &&
        (style.color != null || style.foreground != null)) {
      return style;
    }
    if (color == null && foreground == null) return style;

    late final TextStyle result;
    if (foreground case final paint?) {
      result = style.copyWith(foreground: paint);
    } else if (style.foreground != null) {
      // Mix concatenates directives when recipes merge. If an earlier fallback
      // supplied a Paint, copyWith cannot clear it in favour of a Color. Keep
      // the equivalent Paint representation so the later recipe still wins
      // without producing an invalid TextStyle(color:, foreground:).
      result = style.copyWith(foreground: Paint()..color = color!);
    } else {
      result = style.copyWith(color: color);
    }

    // Expando keeps provenance out of TextStyle's visual and diagnostic
    // fields, works with assertions disabled, and does not retain resolved
    // styles after Mix finishes applying the directive list.
    _ambientCodeForegroundFallbacks[result] = true;
    return result;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _AmbientCodeForegroundDirective &&
          other.color == color &&
          other.foreground == foreground;

  @override
  int get hashCode => Object.hash(color, foreground);
}

final _ambientCodeForegroundFallbacks = Expando<bool>(
  'ui_code_ambient_foreground',
);

/// Token-backed standalone code text with the Radix Code variants.
///
/// Code carries no accessibility role: Flutter has no code semantics, and
/// inventing one would misreport the content.
class UiCode extends StatelessWidget {
  const UiCode(
    this.text, {
    super.key,
    this.size,
    this.variant = UiCodeVariant.soft,
    this.weight,
    this.softWrap = true,
    this.truncate = false,
    this.accent = false,
    this.highContrast = false,
    this.style = const BadgeStyler.create(),
  }) : assert(text != '');

  const UiCode.solid(
    this.text, {
    super.key,
    this.size,
    this.weight,
    this.softWrap = true,
    this.truncate = false,
    this.accent = false,
    this.highContrast = false,
    this.style = const BadgeStyler.create(),
  }) : variant = UiCodeVariant.solid,
       assert(text != '');

  const UiCode.soft(
    this.text, {
    super.key,
    this.size,
    this.weight,
    this.softWrap = true,
    this.truncate = false,
    this.accent = false,
    this.highContrast = false,
    this.style = const BadgeStyler.create(),
  }) : variant = UiCodeVariant.soft,
       assert(text != '');

  const UiCode.outline(
    this.text, {
    super.key,
    this.size,
    this.weight,
    this.softWrap = true,
    this.truncate = false,
    this.accent = false,
    this.highContrast = false,
    this.style = const BadgeStyler.create(),
  }) : variant = UiCodeVariant.outline,
       assert(text != '');

  const UiCode.ghost(
    this.text, {
    super.key,
    this.size,
    this.weight,
    this.softWrap = true,
    this.truncate = false,
    this.accent = false,
    this.highContrast = false,
    this.style = const BadgeStyler.create(),
  }) : variant = UiCodeVariant.ghost,
       assert(text != '');

  final String text;
  final UiTextSize? size;
  final UiCodeVariant variant;
  final UiTextWeight? weight;
  final bool softWrap;
  final bool truncate;
  final bool accent;
  final bool highContrast;
  final BadgeStyler style;

  @override
  Widget build(BuildContext context) => uiCodeStyle(
    context,
    size: size,
    variant: variant,
    weight: weight,
    softWrap: softWrap,
    truncate: truncate,
    accent: accent,
    highContrast: highContrast,
    style: style,
  )(label: text);
}
