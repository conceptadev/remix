part of 'button.dart';

/// Defines the structure and styling properties for a button component.
///
/// ButtonSpec is the resolved specification that describes how a button
/// should be styled and structured. It follows the Spec pattern used
/// throughout the Remix framework, where:
///
/// 1. **Style classes** (like [ButtonStyler]) define styling APIs
/// 2. **Spec classes** (like [ButtonSpec]) hold resolved styling properties
/// 3. **Widget classes** (like [RemixButton]) consume specs to render UI
///
/// The ButtonSpec contains [StyleSpec] properties for each visual element
/// of the button: container layout, text label, icon, and loading spinner.
/// These properties are built by [ButtonStyler] and consumed by
/// [RemixButton] to create the final rendered widget.
///
/// ## Architecture Overview
///
/// ```
/// ButtonStyler -> ButtonSpec -> RemixButton Widget
/// (Define styles)    (Hold props)   (Render UI)
/// ```
///
/// ## Usage
///
/// Specs are typically not created directly by users. Instead, they are
/// built internally when applying styles:
///
/// ```dart
/// // Style creates and populates the spec
/// final style = ButtonStyler()
///   .backgroundColor(Colors.blue)
///   .foregroundColor(Colors.white)
///   .iconSize(20.0);
///
/// // Widget receives the resolved spec
/// RemixButton(
///   style: style,
///   onPressed: () {},
///   child: Text('Click me'),
/// )
/// ```
///
/// ## Properties
///
/// Each [StyleSpec] property corresponds to a visual element:
/// - [container]: Layout and visual styling (flex, background, borders)
/// - [label]: Text styling for the button's label
/// - [icon]: Icon styling when an icon is present
/// - [spinner]: Loading spinner styling during async operations
///
/// See also:
/// - [ButtonStyler] for the styling API
/// - [RemixButton] for the widget implementation
/// - [Spec] for the base specification pattern
@MixableSpec(
  extraStylerMixins: [
    RemixBoxStylerMixin,
    LabelStyleMixin,
    IconStyleMixin,
    SpinnerStyleMixin,
  ],
)
class ButtonSpec with _$ButtonSpec {
  /// Styling specification for the button's container.
  ///
  /// Controls the button's layout, background, borders, padding,
  /// and other visual container properties. Uses [FlexBoxSpec]
  /// to support flexible layout arrangements.
  @MixableField(forwardStyler: true)
  @override
  final StyleSpec<FlexBoxSpec> container;

  /// Styling specification for the button's text label.
  ///
  /// Defines typography, color, and text-specific properties
  /// when the button displays text content.
  @override
  final StyleSpec<TextSpec> label;

  /// Styling specification for the button's icon.
  ///
  /// Controls icon size, color, and positioning when an icon
  /// is displayed alongside or instead of text.
  @override
  final StyleSpec<IconSpec> icon;

  /// Styling specification for the button's loading spinner.
  ///
  /// Defines the appearance of the spinner shown during
  /// asynchronous operations when the button is in loading state.
  @override
  final StyleSpec<RemixSpinnerSpec> spinner;

  @override
  @MixableField(setterType: RemixBoxEffectsMix)
  final RemixBoxEffectsSpec? containerEffects;

  /// Placement used when exactly one legacy icon is present.
  @override
  final IconAlignment? iconAlignment;

  /// Creates a ButtonSpec with optional styling specifications.
  ///
  /// If any [StyleSpec] is not provided, a default specification
  /// with empty styling is used. This ensures all properties are
  /// always initialized and ready for use by the widget.
  ///
  /// Example:
  /// ```dart
  /// const spec = ButtonSpec(
  ///   container: StyleSpec(spec: FlexBoxSpec()),
  ///   label: StyleSpec(spec: TextSpec()),
  /// );
  /// ```
  const ButtonSpec({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? label,
    StyleSpec<IconSpec>? icon,
    StyleSpec<RemixSpinnerSpec>? spinner,
    this.containerEffects,
    this.iconAlignment,
  }) : container = container ?? const StyleSpec(spec: FlexBoxSpec()),
       label = label ?? const StyleSpec(spec: TextSpec()),
       icon = icon ?? const StyleSpec(spec: IconSpec()),
       spinner = spinner ?? const StyleSpec(spec: RemixSpinnerSpec());

  @override
  RemixButtonSpec lerp(RemixButtonSpec? other, double t) {
    final generated = super.lerp(other, t);
    if (other == null) return generated;
    return generated.copyWith(
      containerEffects: RemixBoxEffectsSpec.lerpNullable(
        containerEffects,
        other.containerEffects,
        t,
      ),
    );
  }
}

/// Backward-compatible name for [ButtonSpec].
///
/// The generated button style API is based on [ButtonSpec], so resolved
/// values use `ButtonSpec` as their runtime type.
typedef RemixButtonSpec = ButtonSpec;
