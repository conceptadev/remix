import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../../foundation/carbon_layer.dart';
import '../../foundation/carbon_layout_scope.dart';
import '../../tokens/generated/carbon_tokens.g.dart';

part 'carbon_text_input.g.dart';

const _carbonTextInputHeight = ContextToken(_resolveCarbonTextInputHeight);
const _carbonField = ContextToken(_resolveCarbonField);
const _carbonFieldHover = ContextToken(_resolveCarbonFieldHover);
const _carbonFieldBorder = ContextToken(_resolveCarbonFieldBorder);

double _resolveCarbonTextInputHeight(BuildContext context) =>
    CarbonLayoutScope.sizeOf(context).clampTo(.xs, .lg).height;

Color _resolveCarbonField(BuildContext context) =>
    CarbonLayer.of(context).color(.field).resolve(context);

Color _resolveCarbonFieldHover(BuildContext context) =>
    CarbonLayer.of(context).color(.fieldHover).resolve(context);

Color _resolveCarbonFieldBorder(BuildContext context) =>
    CarbonLayer.of(context).color(.borderStrong).resolve(context);

/// Carbon's single-line text input, generated directly over [RemixTextField].
///
/// The wrapper preserves Remix's editing, focus, pointer, and semantics
/// implementation while replacing its visual contract with Carbon tokens. A
/// null [size] inherits [CarbonLayoutScope], defaults to `md`, and clamps to
/// Carbon text input's supported `xs`–`lg` range.
@MixWidget(
  target: RemixTextField.new,
  widgetParameters: .only({
    'controller',
    'focusNode',
    'label',
    'hintText',
    'helperText',
    'error',
    'keyboardType',
    'textInputAction',
    'textCapitalization',
    'textDirection',
    'obscureText',
    'enabled',
    'readOnly',
    'autofocus',
    'maxLines',
    'minLines',
    'expands',
    'maxLength',
    'maxLengthEnforcement',
    'onChanged',
    'onEditingComplete',
    'onSubmitted',
    'inputFormatters',
    'showCursor',
    'obscuringCharacter',
    'autocorrect',
    'enableSuggestions',
    'onTap',
    'onTapOutside',
    'scrollController',
    'scrollPhysics',
    'autofillHints',
    'restorationId',
    'canRequestFocus',
    'leading',
    'trailing',
    'semanticLabel',
    'semanticHint',
    'excludeSemantics',
  }),
)
TextFieldStyler carbonTextInputStyle({
  CarbonSize? size,
  bool readOnly = false,
}) {
  final height = size == null
      ? _carbonTextInputHeight()
      : size.clampTo(.xs, .lg).height;

  return _carbonTextEntryStyle(
        BoxStyler()
            .height(height)
            .padding(.horizontal(CarbonTokens.spacing05()))
            .color(_carbonField())
            .border(
              BoxBorderMix.bottom(
                BorderSideMix(color: _carbonFieldBorder(), width: 1),
              ),
            ),
      )
      .onHovered(TextFieldStyler().color(_carbonFieldHover()))
      .onFocused(_carbonFocusStyle())
      .variant(ContextVariant.widgetState(.error), _carbonInvalidStyle())
      .onDisabled(readOnly ? _carbonReadOnlyStyle() : _carbonDisabledStyle());
}

/// Carbon's multiline text area, generated over [RemixTextArea] so multiline
/// defaults and accessibility remain shared with the Remix text-field family.
@MixWidget(
  target: RemixTextArea.new,
  widgetParameters: .only({
    'controller',
    'focusNode',
    'label',
    'hintText',
    'helperText',
    'error',
    'keyboardType',
    'textInputAction',
    'textCapitalization',
    'textDirection',
    'enabled',
    'readOnly',
    'autofocus',
    'maxLines',
    'minLines',
    'maxLength',
    'maxLengthEnforcement',
    'onChanged',
    'onEditingComplete',
    'onSubmitted',
    'inputFormatters',
    'showCursor',
    'autocorrect',
    'enableSuggestions',
    'onTap',
    'onTapOutside',
    'scrollController',
    'scrollPhysics',
    'autofillHints',
    'restorationId',
    'canRequestFocus',
    'leading',
    'trailing',
    'semanticLabel',
    'semanticHint',
    'excludeSemantics',
  }),
)
TextFieldStyler carbonTextAreaStyle({bool readOnly = false}) {
  return _carbonTextEntryStyle(
        BoxStyler()
            .minHeight(80)
            .padding(
              .symmetric(
                horizontal: CarbonTokens.spacing05(),
                vertical: CarbonTokens.spacing04(),
              ),
            )
            .color(_carbonField())
            .border(
              BoxBorderMix.bottom(
                BorderSideMix(color: _carbonFieldBorder(), width: 1),
              ),
            ),
      )
      .crossAxisAlignment(.start)
      .onHovered(TextFieldStyler().color(_carbonFieldHover()))
      .onFocused(_carbonFocusStyle())
      .variant(ContextVariant.widgetState(.error), _carbonInvalidStyle())
      .onDisabled(readOnly ? _carbonReadOnlyStyle() : _carbonDisabledStyle());
}

TextFieldStyler _carbonTextEntryStyle(BoxStyler container) {
  return TextFieldStyler()
      .container(container)
      .spacing(CarbonTokens.spacing03())
      .text(
        TextStyler()
            .style(CarbonTokens.bodyCompact01.mix())
            .color(CarbonTokens.textPrimary()),
      )
      .hintText(
        TextStyler()
            .style(CarbonTokens.bodyCompact01.mix())
            .color(CarbonTokens.textPlaceholder()),
      )
      .label(
        TextStyler()
            .style(CarbonTokens.label01.mix())
            .color(CarbonTokens.textSecondary()),
      )
      .helperText(
        TextStyler()
            .style(CarbonTokens.helperText01.mix())
            .color(CarbonTokens.textHelper()),
      )
      // Keep the effects rendering branch mounted before focus. Introducing
      // the effects layer only after focus would replace EditableText and
      // invalidate its just-opened text-input connection.
      .containerEffects(
        RemixBoxEffectsMix(
          outline: BorderSideMix(color: const Color(0x00000000), width: 2),
          outlineOffset: -2,
        ),
      )
      .cursorColor(CarbonTokens.focus())
      .cursorWidth(2);
}

TextFieldStyler _carbonFocusStyle() => .new().containerEffects(
  RemixBoxEffectsMix(
    outline: BorderSideMix(color: CarbonTokens.focus(), width: 2),
    outlineOffset: -2,
  ),
);

TextFieldStyler _carbonInvalidStyle() => .new()
    .border(
      BoxBorderMix.bottom(
        BorderSideMix(color: CarbonTokens.supportError(), width: 2),
      ),
    )
    .containerEffects(
      RemixBoxEffectsMix(
        outline: BorderSideMix(color: CarbonTokens.supportError(), width: 2),
        outlineOffset: -2,
      ),
    )
    .helperText(TextStyler().color(CarbonTokens.textError()));

TextFieldStyler _carbonDisabledStyle() => .new()
    .border(
      BoxBorderMix.bottom(
        BorderSideMix(color: CarbonTokens.borderDisabled(), width: 1),
      ),
    )
    .text(TextStyler().color(CarbonTokens.textDisabled()))
    .hintText(TextStyler().color(CarbonTokens.textDisabled()))
    .label(TextStyler().color(CarbonTokens.textDisabled()))
    .helperText(TextStyler().color(CarbonTokens.textDisabled()));

TextFieldStyler _carbonReadOnlyStyle() => .new()
    .color(const Color(0x00000000))
    .border(BoxBorderMix.none)
    .text(TextStyler().color(CarbonTokens.textPrimary()))
    .hintText(TextStyler().color(CarbonTokens.textPlaceholder()));

/// Carbon password input with an owned, keyboard-accessible visibility toggle.
///
/// The toggle is intentionally part of this component rather than an example
/// concern: Carbon's password input contract includes it, and ownership keeps
/// the obscured state and accessible label synchronized.
class CarbonPasswordInput extends StatefulWidget {
  const CarbonPasswordInput({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hintText,
    this.helperText,
    this.error = false,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.textInputAction,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.autofillHints = const [AutofillHints.password],
    this.semanticLabel,
    this.semanticHint,
    this.size,
    this.showPasswordLabel = 'Show password',
    this.hidePasswordLabel = 'Hide password',
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hintText;
  final String? helperText;
  final bool error;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final Iterable<String>? autofillHints;
  final String? semanticLabel;
  final String? semanticHint;
  final CarbonSize? size;

  /// Accessible label announced while the password is obscured.
  final String showPasswordLabel;

  /// Accessible label announced while the password is visible.
  final String hidePasswordLabel;

  @override
  State<CarbonPasswordInput> createState() => _CarbonPasswordInputState();
}

class _CarbonPasswordInputState extends State<CarbonPasswordInput> {
  var _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final controlSize = (widget.size ?? CarbonLayoutScope.sizeOf(context))
        .clampTo(.xs, .lg)
        .height;
    final toggleLabel = _obscureText
        ? widget.showPasswordLabel
        : widget.hidePasswordLabel;

    return CarbonTextInput(
      controller: widget.controller,
      focusNode: widget.focusNode,
      label: widget.label,
      hintText: widget.hintText,
      helperText: widget.helperText,
      error: widget.error,
      keyboardType: .visiblePassword,
      textInputAction: widget.textInputAction,
      obscureText: _obscureText,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      autocorrect: false,
      enableSuggestions: false,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onSubmitted: widget.onSubmitted,
      autofillHints: widget.autofillHints,
      semanticLabel: widget.semanticLabel,
      semanticHint: widget.semanticHint,
      size: widget.size,
      trailing: RemixIconButton(
        icon: null,
        iconBuilder: (context, spec, _) => CustomPaint(
          size: Size.square(spec.size ?? 16),
          painter: _PasswordVisibilityPainter(
            color: spec.color ?? CarbonTokens.iconPrimary.resolve(context),
            hidden: _obscureText,
          ),
        ),
        semanticLabel: toggleLabel,
        enabled: widget.enabled && !widget.readOnly,
        onPressed: widget.enabled && !widget.readOnly
            ? () => setState(() => _obscureText = !_obscureText)
            : null,
        style: IconButtonStyler()
            .size(controlSize, controlSize)
            .color(const Color(0x00000000))
            .icon(
              IconStyler()
                  .size(CarbonTokens.iconSize01())
                  .color(CarbonTokens.iconPrimary()),
            )
            .onHovered(.color(CarbonTokens.backgroundHover()))
            .onPressed(.color(CarbonTokens.backgroundActive()))
            .onFocusVisible(
              .containerEffects(
                RemixBoxEffectsMix(
                  outline: BorderSideMix(color: CarbonTokens.focus(), width: 2),
                  outlineOffset: -2,
                ),
              ),
            )
            .onDisabled(.icon(IconStyler().color(CarbonTokens.iconDisabled()))),
      ),
    );
  }
}

class _PasswordVisibilityPainter extends CustomPainter {
  const _PasswordVisibilityPainter({required this.color, required this.hidden});

  final Color color;
  final bool hidden;

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    final stroke = ui.Paint()
      ..color = color
      ..style = ui.PaintingStyle.stroke
      ..strokeWidth = 1.5;
    final center = ui.Offset(size.width / 2, size.height / 2);
    final eye = ui.Rect.fromCenter(
      center: center,
      width: size.width - 2,
      height: size.height * 0.58,
    );

    canvas
      ..drawOval(eye, stroke)
      ..drawCircle(center, size.shortestSide * 0.13, stroke);
    if (hidden) {
      canvas.drawLine(
        const ui.Offset(1, 1),
        ui.Offset(size.width - 1, size.height - 1),
        stroke,
      );
    }
  }

  @override
  bool shouldRepaint(_PasswordVisibilityPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.hidden != hidden;
}
