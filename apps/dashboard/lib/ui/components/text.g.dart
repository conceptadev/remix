// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Ui-themed body text on the Radix nine-step scale.
///
/// Omitted [size] and [weight] resolve to the Radix root run (`text3`,
/// regular) from the active [UiScope]'s tokens rather than the ambient
/// `DefaultTextStyle`. This deliberately deviates from Radix's CSS `1em`
/// inheritance: a token default cannot be silently replaced by a host-installed
/// text run (a `Material` surface, or a host with no run at all), which keeps
/// Ui text a function of the theme alone. Set [accent] to take the
/// surrounding [UiScope]'s accent colour; leaving it false uses the
/// neutral `gray12` foreground.
class UiText extends StatelessWidget {
  const UiText(
    this.text, {
    super.key,
    this.size,
    this.weight,
    this.align,
    this.softWrap = true,
    this.truncate = false,
    this.accent = false,
    this.highContrast = false,
    this.style = const TextStyler.create(),
  });

  final UiTextSize? size;

  final UiTextWeight? weight;

  final TextAlign? align;

  final bool softWrap;

  final bool truncate;

  final bool accent;

  final bool highContrast;

  final TextStyler style;

  final String text;

  @override
  Widget build(BuildContext context) {
    return uiTextStyle(
      size: this.size,
      weight: this.weight,
      align: this.align,
      softWrap: this.softWrap,
      truncate: this.truncate,
      accent: this.accent,
      highContrast: this.highContrast,
      style: this.style,
    ).call(this.text, key: this.key);
  }
}
