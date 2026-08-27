// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'callout.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// The application's Callout recipe.
///
/// A callout is a block of text, usually with a leading icon, that says
/// something about the surrounding page. Remix owns the layout and the icon
/// slot; this recipe owns the surface, the outline, and the content colors.
///
/// There are no interaction fragments. A callout is not a control — anything
/// actionable inside it is a separate button or link with its own recipe.
///
/// The destructive tone paints no fill. A tinted danger surface would need a
/// `destructive`-derived background this theme does not define, and a solid
/// `destructive` fill would read as a pressed button rather than as a notice;
/// the outline and the icon carry the meaning instead.
///
/// Both tones set their sentence in `foreground`, which is why the text color
/// lives in [_base] rather than in either tone. `destructive` is a fill color
/// chosen to sit under `destructiveForeground`, not a text color: on the dark
/// theme's page it measures 4.1:1, under the 4.5:1 WCAG floor for body copy.
/// The border and the glyph are non-text, where the floor is 3:1, so they are
/// where the tone shows. A theme that adds a dedicated danger *text* step
/// would move the text color back into [_variantStyle].
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it. Because [variant] is a non-nullable
/// enum, the generator also emits one named constructor per enum value:
///
/// ```dart
/// PlaygroundCallout.destructive(
///   icon: warningGlyph,
///   text: 'This deletes the workspace for everyone.',
/// )
/// ```
class PlaygroundCallout extends StatelessWidget {
  const PlaygroundCallout({
    super.key,
    this.variant = .neutral,
    this.style = const CalloutStyler.create(),
    this.text,
    this.icon,
    this.child,
  });

  /// A neutral aside on a `muted` surface.
  const PlaygroundCallout.neutral({
    super.key,
    this.style = const CalloutStyler.create(),
    this.text,
    this.icon,
    this.child,
  }) : variant = PlaygroundCalloutVariant.neutral;

  /// A problem the reader has to act on.
  const PlaygroundCallout.destructive({
    super.key,
    this.style = const CalloutStyler.create(),
    this.text,
    this.icon,
    this.child,
  }) : variant = PlaygroundCalloutVariant.destructive;

  final PlaygroundCalloutVariant variant;

  final CalloutStyler style;

  final String? text;

  final IconData? icon;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return RemixCallout(
      key: this.key,
      style: playgroundCalloutStyle(variant: this.variant, style: this.style),
      text: this.text,
      icon: this.icon,
      child: this.child,
    );
  }
}
