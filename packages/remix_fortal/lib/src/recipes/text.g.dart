// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Fortal-themed body text on the Radix nine-step scale.
///
/// Omitted [size] and [weight] inherit the ambient `DefaultTextStyle`, matching
/// Radix, where Text without a size prop renders at the inherited `1em`.
/// Set [accent] to take the surrounding [FortalScope]'s accent colour; leaving
/// it false preserves the inherited foreground.
class FortalText extends StatelessWidget {
  const FortalText(
    this.text, {
    super.key,
    this.size,
    this.weight,
    this.align,
    this.softWrap = true,
    this.truncate = false,
    this.accent = false,
    this.highContrast = false,
  });

  final FortalTextSize? size;

  final FortalTextWeight? weight;

  final TextAlign? align;

  final bool softWrap;

  final bool truncate;

  final bool accent;

  final bool highContrast;

  final String text;

  @override
  Widget build(BuildContext context) {
    return fortalTextStyle(
      size: this.size,
      weight: this.weight,
      align: this.align,
      softWrap: this.softWrap,
      truncate: this.truncate,
      accent: this.accent,
      highContrast: this.highContrast,
    ).call(this.text, key: this.key);
  }
}
