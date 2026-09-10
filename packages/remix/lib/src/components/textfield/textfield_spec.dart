part of 'textfield.dart';

/// Resolved visual properties for a [RemixTextField].
@MixableSpec(
  target: RemixTextField.new,
  extraStylerMixins: [RemixBoxStylerMixin, LabelStyleMixin],
)
class TextFieldSpec with _$TextFieldSpec {
  /// Styling specification for the input text.
  ///
  /// Controls typography, color, and text-specific properties
  /// for the actual text content entered by the user.
  @override
  final StyleSpec<TextSpec> text;

  /// Styling specification for the hint/placeholder text.
  ///
  /// Defines the appearance of placeholder text shown when
  /// the text field is empty. Typically styled with muted colors.
  @override
  final StyleSpec<TextSpec> hintText;

  /// Horizontal alignment of the text within the input field.
  ///
  /// Determines how text is aligned when it doesn't fill the
  /// entire width of the text field.
  @override
  final TextAlign? textAlign;

  /// Width of the text cursor in logical pixels.
  ///
  /// Controls how thick the blinking cursor appears when
  /// the text field has focus.
  @override
  final double? cursorWidth;

  /// Height of the text cursor in logical pixels.
  ///
  /// If null, the cursor height will match the text line height.
  /// When specified, creates a cursor of fixed height.
  @override
  final double? cursorHeight;

  /// Border radius of the text cursor.
  ///
  /// If null, the cursor will have sharp rectangular corners.
  /// When specified, creates a cursor with rounded corners.
  @override
  final Radius? cursorRadius;

  /// Color of the text cursor.
  ///
  /// If null, the cursor will use the theme's default cursor color.
  /// When specified, overrides the default cursor appearance.
  @override
  final Color? cursorColor;

  /// Whether the cursor opacity should animate.
  ///
  /// When true, the cursor will fade in and out with a blinking animation.
  /// When false, the cursor remains at constant opacity.
  /// If null, uses the platform default behavior.
  @override
  final bool? cursorOpacityAnimates;

  /// How tall the selection highlight should be.
  ///
  /// Controls the vertical sizing behavior of text selection highlights.
  @override
  final BoxHeightStyle? selectionHeightStyle;

  /// How wide the selection highlight should be.
  ///
  /// Controls the horizontal sizing behavior of text selection highlights.
  @override
  final BoxWidthStyle? selectionWidthStyle;

  /// Padding around the scrollable area of the text field.
  ///
  /// Ensures content remains visible when the software keyboard
  /// or other UI elements might otherwise obscure the text field.
  @override
  final EdgeInsets? scrollPadding;

  /// Appearance of the keyboard for this text field.
  ///
  /// Controls whether the keyboard should use light or dark appearance.
  /// If null, uses the system default appearance.
  @override
  final Brightness? keyboardAppearance;

  /// Styling specification for the text field's container.
  ///
  /// Controls the text field's background, borders, padding, constraints, and
  /// other box styling. The input anatomy is rendered separately as a fixed
  /// horizontal row.
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;

  /// Spacing between the leading widget, editor, and trailing widget.
  ///
  /// This is an explicit generated control because the input container's
  /// direction is fixed to a row while its child spacing remains configurable.
  @override
  final double? spacing;

  /// Cross-axis alignment for the input row's editor and accessories.
  ///
  /// Baseline alignment uses [TextBaseline.alphabetic].
  @override
  final CrossAxisAlignment? crossAxisAlignment;

  /// Styling specification for the layout that wraps the label, input
  /// container, and helper text.
  ///
  /// Rendered as a [FlexBox], so its full [FlexBoxSpec] controls the direction,
  /// spacing, alignment, and box styling around the label, field, and helper
  /// text. The base style defaults this layout to a vertical column.
  @override
  final StyleSpec<FlexBoxSpec> layout;

  /// Styling specification for helper text.
  ///
  /// Defines typography and color for supplementary text shown
  /// below the input field to provide additional context or validation feedback.
  @override
  final StyleSpec<TextSpec> helperText;

  /// Styling specification for the text field's label.
  ///
  /// Controls the appearance of the label text that describes
  /// the purpose or expected content of the text field.
  @override
  final StyleSpec<TextSpec> label;

  @override
  @MixableField(setterType: RemixBoxEffectsMix)
  final RemixBoxEffectsSpec? containerEffects;

  /// Creates a TextFieldSpec with optional styling and configuration.
  ///
  /// Provides sensible defaults for all properties to ensure the text field
  /// is functional even when minimal configuration is provided:
  ///
  /// - Text alignment defaults to [TextAlign.start]
  /// - Cursor width defaults to 2.0 logical pixels
  /// - Selection styles default to tight sizing
  /// - Scroll padding defaults to 20.0 on all sides
  /// - The outer layout defaults to a vertical, min-size, start-aligned flex
  ///   with 8 logical pixels between the label, input, and helper
  /// - All other [StyleSpec] properties default to empty specifications
  ///
  /// Example:
  /// ```dart
  /// const spec = TextFieldSpec(
  ///   textAlign: TextAlign.center,
  ///   cursorWidth: 3.0,
  ///   cursorColor: Colors.blue,
  /// );
  /// ```
  const TextFieldSpec({
    StyleSpec<TextSpec>? text,
    StyleSpec<TextSpec>? hintText,
    this.textAlign = TextAlign.start,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.selectionHeightStyle = BoxHeightStyle.tight,
    this.selectionWidthStyle = BoxWidthStyle.tight,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.keyboardAppearance,
    this.cursorOpacityAnimates,
    StyleSpec<BoxSpec>? container,
    this.spacing,
    this.crossAxisAlignment,
    StyleSpec<FlexBoxSpec>? layout,
    StyleSpec<TextSpec>? helperText,
    StyleSpec<TextSpec>? label,
    this.containerEffects,
  }) : text = text ?? const StyleSpec(spec: TextSpec()),
       hintText = hintText ?? const StyleSpec(spec: TextSpec()),
       helperText = helperText ?? const StyleSpec(spec: TextSpec()),
       label = label ?? const StyleSpec(spec: TextSpec()),
       container = container ?? const StyleSpec(spec: BoxSpec()),
       layout = layout ?? _defaultTextFieldLayout;

  // Deliberate: route effects through lerpNullable so shadows/blends animate;
  // the generator's default snap-lerps unrecognized spec types.
  @override
  TextFieldSpec lerp(TextFieldSpec? other, double t) {
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

const _defaultTextFieldLayout = StyleSpec(
  spec: FlexBoxSpec(
    flex: StyleSpec(
      spec: FlexSpec(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
      ),
    ),
  ),
);

/// Backward-compatible name for [TextFieldSpec].
///
/// The generated style API is based on [TextFieldSpec], so resolved values use
/// `TextFieldSpec` as their runtime type.
typedef RemixTextFieldSpec = TextFieldSpec;
