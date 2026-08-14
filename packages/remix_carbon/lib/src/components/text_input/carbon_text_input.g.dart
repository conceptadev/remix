// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carbon_text_input.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Carbon's single-line text input, generated directly over [RemixTextField].
///
/// The wrapper preserves Remix's editing, focus, pointer, and semantics
/// implementation while replacing its visual contract with Carbon tokens. A
/// null [size] inherits [CarbonLayoutScope], defaults to `md`, and clamps to
/// Carbon text input's supported `xs`–`lg` range.
class CarbonTextInput extends StatelessWidget {
  const CarbonTextInput({
    super.key,
    this.size,
    this.readOnly = false,
    this.controller,
    this.focusNode,
    this.label,
    this.hintText,
    this.helperText,
    this.error = false,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = .none,
    this.textDirection,
    this.obscureText = false,
    this.enabled = true,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.showCursor,
    this.obscuringCharacter = '•',
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.onTap,
    this.onTapOutside,
    this.scrollController,
    this.scrollPhysics,
    this.autofillHints,
    this.restorationId,
    this.canRequestFocus = true,
    this.leading,
    this.trailing,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
  });

  final CarbonSize? size;

  final bool readOnly;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final String? label;

  final String? hintText;

  final String? helperText;

  final bool error;

  final TextInputType? keyboardType;

  final TextInputAction? textInputAction;

  final TextCapitalization textCapitalization;

  final TextDirection? textDirection;

  final bool obscureText;

  final bool enabled;

  final bool autofocus;

  final int? maxLines;

  final int? minLines;

  final bool expands;

  final int? maxLength;

  final MaxLengthEnforcement? maxLengthEnforcement;

  final ValueChanged<String>? onChanged;

  final VoidCallback? onEditingComplete;

  final ValueChanged<String>? onSubmitted;

  final List<TextInputFormatter>? inputFormatters;

  final bool? showCursor;

  final String obscuringCharacter;

  final bool autocorrect;

  final bool enableSuggestions;

  final GestureTapCallback? onTap;

  final TapRegionCallback? onTapOutside;

  final ScrollController? scrollController;

  final ScrollPhysics? scrollPhysics;

  final Iterable<String>? autofillHints;

  final String? restorationId;

  final bool canRequestFocus;

  final Widget? leading;

  final Widget? trailing;

  final String? semanticLabel;

  final String? semanticHint;

  final bool excludeSemantics;

  @override
  Widget build(BuildContext context) {
    return RemixTextField(
      key: this.key,
      style: carbonTextInputStyle(size: this.size, readOnly: this.readOnly),
      controller: this.controller,
      focusNode: this.focusNode,
      label: this.label,
      hintText: this.hintText,
      helperText: this.helperText,
      error: this.error,
      keyboardType: this.keyboardType,
      textInputAction: this.textInputAction,
      textCapitalization: this.textCapitalization,
      textDirection: this.textDirection,
      obscureText: this.obscureText,
      enabled: this.enabled,
      readOnly: this.readOnly,
      autofocus: this.autofocus,
      maxLines: this.maxLines,
      minLines: this.minLines,
      expands: this.expands,
      maxLength: this.maxLength,
      maxLengthEnforcement: this.maxLengthEnforcement,
      onChanged: this.onChanged,
      onEditingComplete: this.onEditingComplete,
      onSubmitted: this.onSubmitted,
      inputFormatters: this.inputFormatters,
      showCursor: this.showCursor,
      obscuringCharacter: this.obscuringCharacter,
      autocorrect: this.autocorrect,
      enableSuggestions: this.enableSuggestions,
      onTap: this.onTap,
      onTapOutside: this.onTapOutside,
      scrollController: this.scrollController,
      scrollPhysics: this.scrollPhysics,
      autofillHints: this.autofillHints,
      restorationId: this.restorationId,
      canRequestFocus: this.canRequestFocus,
      leading: this.leading,
      trailing: this.trailing,
      semanticLabel: this.semanticLabel,
      semanticHint: this.semanticHint,
      excludeSemantics: this.excludeSemantics,
    );
  }
}

/// Carbon's multiline text area, generated over [RemixTextArea] so multiline
/// defaults and accessibility remain shared with the Remix text-field family.
class CarbonTextArea extends StatelessWidget {
  const CarbonTextArea({
    super.key,
    this.readOnly = false,
    this.controller,
    this.focusNode,
    this.label,
    this.hintText,
    this.helperText,
    this.error = false,
    this.keyboardType = TextInputType.multiline,
    this.textInputAction = TextInputAction.newline,
    this.textCapitalization = .none,
    this.textDirection,
    this.enabled = true,
    this.autofocus = false,
    this.maxLines,
    this.minLines = 2,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.showCursor,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.onTap,
    this.onTapOutside,
    this.scrollController,
    this.scrollPhysics,
    this.autofillHints,
    this.restorationId,
    this.canRequestFocus = true,
    this.leading,
    this.trailing,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
  });

  final bool readOnly;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final String? label;

  final String? hintText;

  final String? helperText;

  final bool error;

  final TextInputType? keyboardType;

  final TextInputAction? textInputAction;

  final TextCapitalization textCapitalization;

  final TextDirection? textDirection;

  final bool enabled;

  final bool autofocus;

  final int? maxLines;

  final int? minLines;

  final int? maxLength;

  final MaxLengthEnforcement? maxLengthEnforcement;

  final ValueChanged<String>? onChanged;

  final VoidCallback? onEditingComplete;

  final ValueChanged<String>? onSubmitted;

  final List<TextInputFormatter>? inputFormatters;

  final bool? showCursor;

  final bool autocorrect;

  final bool enableSuggestions;

  final GestureTapCallback? onTap;

  final TapRegionCallback? onTapOutside;

  final ScrollController? scrollController;

  final ScrollPhysics? scrollPhysics;

  final Iterable<String>? autofillHints;

  final String? restorationId;

  final bool canRequestFocus;

  final Widget? leading;

  final Widget? trailing;

  final String? semanticLabel;

  final String? semanticHint;

  final bool excludeSemantics;

  @override
  Widget build(BuildContext context) {
    return RemixTextArea(
      key: this.key,
      style: carbonTextAreaStyle(readOnly: this.readOnly),
      controller: this.controller,
      focusNode: this.focusNode,
      label: this.label,
      hintText: this.hintText,
      helperText: this.helperText,
      error: this.error,
      keyboardType: this.keyboardType,
      textInputAction: this.textInputAction,
      textCapitalization: this.textCapitalization,
      textDirection: this.textDirection,
      enabled: this.enabled,
      readOnly: this.readOnly,
      autofocus: this.autofocus,
      maxLines: this.maxLines,
      minLines: this.minLines,
      maxLength: this.maxLength,
      maxLengthEnforcement: this.maxLengthEnforcement,
      onChanged: this.onChanged,
      onEditingComplete: this.onEditingComplete,
      onSubmitted: this.onSubmitted,
      inputFormatters: this.inputFormatters,
      showCursor: this.showCursor,
      autocorrect: this.autocorrect,
      enableSuggestions: this.enableSuggestions,
      onTap: this.onTap,
      onTapOutside: this.onTapOutside,
      scrollController: this.scrollController,
      scrollPhysics: this.scrollPhysics,
      autofillHints: this.autofillHints,
      restorationId: this.restorationId,
      canRequestFocus: this.canRequestFocus,
      leading: this.leading,
      trailing: this.trailing,
      semanticLabel: this.semanticLabel,
      semanticHint: this.semanticHint,
      excludeSemantics: this.excludeSemantics,
    );
  }
}
