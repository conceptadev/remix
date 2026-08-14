import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../fortal/fortal.dart';
import 'typography_shared.dart';

/// Fortal-themed heading style on the Radix nine-step scale.
///
/// Radix's `--heading-font-size-adjust` is `1`, so headings use the raw token
/// size; only the line box differs from body text. Each ratio below is the
/// pinned Radix heading line height over its font size, so both scale together
/// and the ratio stays constant across theme scaling.
///
/// This is a plain recipe rather than a `@MixWidget`: a generated widget only
/// renders the styler, and [FortalHeading] must additionally publish a native
/// heading node that generation cannot supply.
TextStyler fortalHeadingStyle({
  FortalTextSize size = .size6,
  FortalTextWeight weight = .bold,
  TextAlign? align,
  bool softWrap = true,
  bool truncate = false,
  bool accent = false,
  bool highContrast = false,
}) {
  final lineHeight = switch (size) {
    .size1 => 16.0 / 12.0,
    .size2 => 18.0 / 14.0,
    .size3 => 22.0 / 16.0,
    .size4 => 24.0 / 18.0,
    .size5 => 26.0 / 20.0,
    .size6 => 30.0 / 24.0,
    .size7 => 36.0 / 28.0,
    .size8 => 40.0 / 35.0,
    .size9 => 1.0,
  };

  var style = TextStyler(
    style: fortalTextSizeToken(size).mix(),
  ).height(lineHeight).fontWeight(fortalTextWeightToken(weight)());
  // Neutral headings pin `gray12` from the tokens rather than inheriting the
  // ambient foreground, matching fortalTextStyle's token-default contract.
  style = accent
      ? fortalAccentForeground(style, highContrast: highContrast)
      : style.color(FortalTokens.gray12());
  style = style.inherit(false);

  return fortalApplyTextFlow(
    style,
    align: align,
    softWrap: softWrap,
    truncate: truncate,
  );
}

/// Token-backed visual heading with an independent native heading level.
///
/// [headingLevel] drives the accessibility level only; changing it never
/// changes the visual [size], matching Radix.
class FortalHeading extends StatelessWidget {
  const FortalHeading(
    this.text, {
    super.key,
    this.headingLevel = 1,
    this.size = FortalTextSize.size6,
    this.weight = FortalTextWeight.bold,
    this.align,
    this.softWrap = true,
    this.truncate = false,
    this.accent = false,
    this.highContrast = false,
    this.semanticLabel,
    this.excludeSemantics = false,
  }) : assert(text != ''),
       assert(headingLevel >= 1 && headingLevel <= 6),
       assert(semanticLabel == null || semanticLabel != '');

  final String text;
  final int headingLevel;
  final FortalTextSize size;
  final FortalTextWeight weight;
  final TextAlign? align;
  final bool softWrap;
  final bool truncate;
  final bool accent;
  final bool highContrast;
  final String? semanticLabel;
  final bool excludeSemantics;

  @override
  Widget build(BuildContext context) {
    final content = fortalHeadingStyle(
      size: size,
      weight: weight,
      align: align,
      softWrap: softWrap,
      truncate: truncate,
      accent: accent,
      highContrast: highContrast,
    )(text);

    if (excludeSemantics) return ExcludeSemantics(child: content);

    return Semantics(
      header: true,
      headingLevel: headingLevel,
      label: semanticLabel ?? text,
      excludeSemantics: true,
      child: content,
    );
  }
}
