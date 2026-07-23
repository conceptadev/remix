part of 'textfield.dart';

/// Defines the structure and styling properties for a text field component.
///
/// RemixTextFieldSpec is the resolved specification that describes how a text field
/// should be styled, structured, and behave. It follows the Spec pattern used
/// throughout the Remix framework, where:
///
/// 1. **Style classes** (like [RemixTextFieldStyler]) define styling APIs
/// 2. **Spec classes** (like [RemixTextFieldSpec]) hold resolved styling properties
/// 3. **Widget classes** (like [RemixTextField]) consume specs to render UI
///
/// The RemixTextFieldSpec contains both styling properties ([StyleSpec] instances)
/// for visual elements and configuration properties for text field behavior
/// such as cursor appearance, text alignment, and selection handling.
///
/// ## Architecture Overview
///
/// ```
/// RemixTextFieldStyler -> RemixTextFieldSpec -> RemixTextField Widget
/// (Define styles)       (Hold props)     (Render UI)
/// ```
///
/// ## Property Categories
///
/// **Visual Styling**: [text], [hintText], [container], [helperText], [label]
/// **Text Behavior**: [textAlign]
/// **Cursor Configuration**: [cursorWidth], [cursorHeight], [cursorRadius], [cursorColor], [cursorOpacityAnimates]
/// **Selection Styling**: [selectionHeightStyle], [selectionWidthStyle]
/// **Input Configuration**: [scrollPadding], [keyboardAppearance]
///
/// ## Usage
///
/// Specs are typically not created directly by users. Instead, they are
/// built internally when applying styles:
///
/// ```dart
/// // Style creates and populates the spec
/// final style = RemixTextFieldStyler()
///   .color(Colors.black)
///   .cursorColor(Colors.blue)
///   .spacing(8.0);
///
/// // Widget receives the resolved spec
/// RemixTextField(style: style)
/// ```
///
/// See also:
/// - [RemixTextFieldStyler] for the styling API
/// - [RemixTextField] for the widget implementation
/// - [Spec] for the base specification pattern
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin, LabelStyleMixin])
class RemixTextFieldSpec with _$RemixTextFieldSpec {
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
  /// Controls the text field's layout, background, borders, padding,
  /// and other visual container properties. Uses [FlexBoxSpec]
  /// to support flexible layout arrangements.
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<FlexBoxSpec> container;

  /// Styling specification for the vertical layout that wraps the label,
  /// input container, and helper text.
  ///
  /// Rendered as a [ColumnBox], so its [FlexBoxSpec] controls the vertical
  /// spacing between the label, field, and helper text, as well as any
  /// horizontal spacing (padding/alignment) around them.
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

  /// Creates a RemixTextFieldSpec with optional styling and configuration.
  ///
  /// Provides sensible defaults for all properties to ensure the text field
  /// is functional even when minimal configuration is provided:
  ///
  /// - Text alignment defaults to [TextAlign.start]
  /// - Cursor width defaults to 2.0 logical pixels
  /// - Selection styles default to tight sizing
  /// - Scroll padding defaults to 20.0 on all sides
  /// - All [StyleSpec] properties default to empty specifications
  ///
  /// Example:
  /// ```dart
  /// const spec = RemixTextFieldSpec(
  ///   textAlign: TextAlign.center,
  ///   cursorWidth: 3.0,
  ///   cursorColor: Colors.blue,
  /// );
  /// ```
  const RemixTextFieldSpec({
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
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<FlexBoxSpec>? layout,
    StyleSpec<TextSpec>? helperText,
    StyleSpec<TextSpec>? label,
    this.containerEffects,
  }) : text = text ?? const StyleSpec(spec: TextSpec()),
       hintText = hintText ?? const StyleSpec(spec: TextSpec()),
       helperText = helperText ?? const StyleSpec(spec: TextSpec()),
       label = label ?? const StyleSpec(spec: TextSpec()),
       container = container ?? const StyleSpec(spec: FlexBoxSpec()),
       layout = layout ?? const StyleSpec(spec: FlexBoxSpec());

  @override
  RemixTextFieldSpec lerp(RemixTextFieldSpec? other, double t) {
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
