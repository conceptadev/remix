part of 'textfield.dart';

/// A multiline text editor backed by the same implementation as
/// [RemixTextField].
///
/// Text areas and text fields share one accessible editing pipeline and one
/// styling anatomy. This constructor-only facade supplies safe multiline
/// defaults without forking a spec or build path that could drift over time.
class RemixTextArea extends RemixTextField {
  const RemixTextArea({
    super.key,
    super.controller,
    super.focusNode,
    super.label,
    super.hintText,
    super.helperText,
    super.error,
    TextInputType? keyboardType = TextInputType.multiline,
    TextInputAction? textInputAction = TextInputAction.newline,
    super.textCapitalization,
    super.textDirection,
    super.enabled,
    super.readOnly,
    super.autofocus,
    int? maxLines,
    int? minLines = 2,
    super.maxLength,
    super.maxLengthEnforcement,
    super.onChanged,
    super.onEditingComplete,
    super.onSubmitted,
    super.onAppPrivateCommand,
    super.inputFormatters,
    super.showCursor,
    super.autocorrect,
    super.enableSuggestions,
    super.smartDashesType,
    super.smartQuotesType,
    super.dragStartBehavior,
    super.enableInteractiveSelection,
    super.selectionControls,
    super.onTap,
    super.onTapOutside,
    super.onPressUpOutside,
    super.onTapAlwaysCalled,
    super.scrollController,
    super.scrollPhysics,
    super.autofillHints,
    super.contentInsertionConfiguration,
    super.clipBehavior,
    super.restorationId,
    super.stylusHandwritingEnabled,
    super.enableIMEPersonalizedLearning,
    super.contextMenuBuilder,
    super.spellCheckConfiguration,
    super.magnifierConfiguration,
    super.canRequestFocus,
    super.ignorePointers,
    super.undoController,
    super.groupId,
    super.leading,
    super.trailing,
    super.semanticLabel,
    super.semanticHint,
    super.excludeSemantics,
    super.style,
    super.styleSpec,
  }) : assert(
         minLines == null || minLines > 0,
         'minLines must be greater than zero.',
       ),
       assert(
         maxLines == null || maxLines > 0,
         'maxLines must be greater than zero.',
       ),
       assert(
         maxLines == null || minLines == null || maxLines >= minLines,
         'maxLines must be greater than or equal to minLines.',
       ),
       super(
         keyboardType: keyboardType,
         textInputAction: textInputAction,
         minLines: minLines,
         maxLines: maxLines,
         expands: false,
         obscureText: false,
       );

  static final styleFrom = TextFieldStyler.new;
}
