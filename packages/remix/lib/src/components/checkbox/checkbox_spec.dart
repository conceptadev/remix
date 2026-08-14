part of 'checkbox.dart';

/// Defines the structure and styling properties for a checkbox component.
///
/// CheckboxSpec is the resolved specification that describes how a checkbox
/// should be styled and structured. It follows the Spec pattern used
/// throughout the Remix framework, where:
///
/// 1. **Style classes** (like [CheckboxStyler]) define styling APIs
/// 2. **Spec classes** (like [CheckboxSpec]) hold resolved styling properties
/// 3. **Widget classes** (like [RemixCheckbox]) consume specs to render UI
///
/// The CheckboxSpec contains [StyleSpec] properties for the visual pieces of
/// the checkbox: the container (checkbox box), indicator icon (checkmark), and
/// optional label.
///
/// ## Architecture Overview
///
/// ```
/// CheckboxStyler -> CheckboxSpec -> RemixCheckbox Widget
/// (Define styles)      (Hold props)    (Render UI)
/// ```
///
/// ## Visual Structure
///
/// A checkbox component consists of these styled elements:
/// ```
/// [container] (the checkbox box)  [label]
///   └── [indicator] (checkmark icon)
/// ```
///
/// ## Usage
///
/// Specs are typically not created directly by users. Instead, they are
/// built internally when applying styles:
///
/// ```dart
/// // Style creates and populates the spec
/// final style = CheckboxStyler()
///   .indicatorColor(Colors.blue)
///   .size(20, 20);
///
/// // Widget receives the resolved spec
/// RemixCheckbox(selected: false, onChanged: (_) {}, style: style)
/// ```
///
/// ## Properties
///
/// Each [StyleSpec] property corresponds to a visual element:
/// - [container]: The checkbox box styling (background, border, size, padding)
/// - [indicator]: The checkmark icon styling (color, size)
/// - [label]: The optional visible label styling
/// - [labelSpacing]: The gap between the checkbox box and visible label
///
/// See also:
/// - [CheckboxStyler] for the styling API
/// - [RemixCheckbox] for the widget implementation
/// - [Spec] for the base specification pattern
@MixableSpec(
  target: RemixCheckbox.new,
  extraStylerMixins: [RemixBoxStylerMixin, LabelStyleMixin],
)
class CheckboxSpec with _$CheckboxSpec {
  /// Styling specification for the checkbox box container.
  ///
  /// Defines the appearance of the checkbox box itself, including
  /// background color, border, size, and shape. This is the visual
  /// element that users click to toggle the checkbox state.
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;

  /// Styling specification for the checkbox indicator icon.
  ///
  /// Controls the checkmark or other indicator symbol shown when
  /// the checkbox is in the checked state. Defines color, size,
  /// and other icon-specific properties.
  @override
  final StyleSpec<IconSpec> indicator;

  /// Styling specification for the optional visible checkbox label.
  @override
  final StyleSpec<TextSpec> label;

  /// Gap between the checkbox box and its optional visible label.
  @override
  final double labelSpacing;

  @override
  @MixableField(setterType: RemixBoxEffectsMix)
  final RemixBoxEffectsSpec? containerEffects;

  /// Creates a CheckboxSpec with optional styling specifications.
  ///
  /// If any [StyleSpec] is not provided, a default specification
  /// with empty styling is used. This ensures all properties are
  /// always initialized and ready for use by the widget.
  ///
  /// The default specifications provide a foundation that can be
  /// extended through the styling system without requiring
  /// complete specification of every visual property.
  ///
  /// Example:
  /// ```dart
  /// const spec = CheckboxSpec(
  ///   container: StyleSpec(spec: BoxSpec()),
  ///   indicator: StyleSpec(spec: IconSpec()),
  /// );
  /// ```
  const CheckboxSpec({
    StyleSpec<BoxSpec>? container,
    StyleSpec<IconSpec>? indicator,
    StyleSpec<TextSpec>? label,
    double? labelSpacing,
    this.containerEffects,
  }) : container = container ?? const StyleSpec(spec: BoxSpec()),
       indicator = indicator ?? const StyleSpec(spec: IconSpec()),
       label = label ?? const StyleSpec(spec: TextSpec()),
       labelSpacing = labelSpacing ?? 8;

  // Deliberate: route effects through lerpNullable so shadows/blends animate;
  // the generator's default snap-lerps unrecognized spec types.
  @override
  CheckboxSpec lerp(CheckboxSpec? other, double t) {
    if (other == null) return this;
    final generated = super.lerp(other, t);
    return generated.copyWith(
      containerEffects: RemixBoxEffectsSpec.lerpNullable(
        containerEffects,
        other.containerEffects,
        t,
      ),
    );
  }
}

/// Backward-compatible name for [CheckboxSpec].
///
/// The generated style API is based on [CheckboxSpec], so resolved values use
/// `CheckboxSpec` as their runtime type.
typedef RemixCheckboxSpec = CheckboxSpec;
