part of 'textfield.dart';

/// Style builder for [RemixTextField].
///
/// Use this class to style the text field container, text, hint text, helper
/// text, label, cursor, selection behavior, and spacing.
extension RemixTextFieldStylerRemixHelpers on TextFieldStyler {
  /// Sets the editable text color.
  ///
  /// Use [TextFieldStyler.color] for the generated container color
  /// shortcut.
  TextFieldStyler textColor(Color value) {
    return merge(
      TextFieldStyler(
        text: TextStyler(style: TextStyleMix(color: value)),
      ),
    );
  }

  /// Sets hint text color
  TextFieldStyler hintColor(Color value) {
    return merge(
      TextFieldStyler(
        hintText: TextStyler(style: TextStyleMix(color: value)),
      ),
    );
  }

  /// Creates a [RemixTextField] widget with this style applied.
  ///
  /// Example:
  /// ```dart
  /// final textField = TextFieldStyler()
  ///   .color(Colors.grey.shade100)
  ///   .borderRadius(BorderRadiusMix.circular(8));
  ///
  /// // Use it like a function
  /// textField(
  ///   hintText: 'Enter your name',
  ///   onChanged: (value) => debugPrint(value),
  /// )
  /// ```
  RemixTextField call({
    Key? key,
    TextEditingController? controller,
    FocusNode? focusNode,
    String? label,
    String? hintText,
    String? helperText,
    bool error = false,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    TextCapitalization textCapitalization = .none,
    TextDirection? textDirection,
    bool obscureText = false,
    bool enabled = true,
    bool readOnly = false,
    bool autofocus = false,
    int? maxLines = 1,
    int? minLines,
    bool expands = false,
    int? maxLength,
    MaxLengthEnforcement? maxLengthEnforcement,
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onSubmitted,
    AppPrivateCommandCallback? onAppPrivateCommand,
    List<TextInputFormatter>? inputFormatters,
    bool? showCursor,
    String obscuringCharacter = '•',
    bool autocorrect = true,
    bool enableSuggestions = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    DragStartBehavior dragStartBehavior = .start,
    bool enableInteractiveSelection = true,
    TextSelectionControls? selectionControls,
    GestureTapCallback? onTap,
    TapRegionCallback? onTapOutside,
    TapRegionUpCallback? onPressUpOutside,
    bool onTapAlwaysCalled = false,
    ScrollController? scrollController,
    ScrollPhysics? scrollPhysics,
    Iterable<String>? autofillHints,
    ContentInsertionConfiguration? contentInsertionConfiguration,
    Clip clipBehavior = .hardEdge,
    String? restorationId,
    bool stylusHandwritingEnabled = true,
    bool enableIMEPersonalizedLearning = true,
    EditableTextContextMenuBuilder? contextMenuBuilder,
    SpellCheckConfiguration? spellCheckConfiguration,
    TextMagnifierConfiguration? magnifierConfiguration,
    bool canRequestFocus = true,
    bool? ignorePointers,
    UndoHistoryController? undoController,
    Object groupId = EditableText,
    Widget? leading,
    Widget? trailing,
    String? semanticLabel,
    String? semanticHint,
    bool excludeSemantics = false,
  }) {
    return RemixTextField(
      key: key,
      controller: controller,
      focusNode: focusNode,
      label: label,
      hintText: hintText,
      helperText: helperText,
      error: error,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      textDirection: textDirection,
      obscureText: obscureText,
      enabled: enabled,
      readOnly: readOnly,
      autofocus: autofocus,
      maxLines: maxLines,
      minLines: minLines,
      expands: expands,
      maxLength: maxLength,
      maxLengthEnforcement: maxLengthEnforcement,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      onAppPrivateCommand: onAppPrivateCommand,
      inputFormatters: inputFormatters,
      showCursor: showCursor,
      obscuringCharacter: obscuringCharacter,
      autocorrect: autocorrect,
      enableSuggestions: enableSuggestions,
      smartDashesType: smartDashesType,
      smartQuotesType: smartQuotesType,
      dragStartBehavior: dragStartBehavior,
      enableInteractiveSelection: enableInteractiveSelection,
      selectionControls: selectionControls,
      onTap: onTap,
      onTapOutside: onTapOutside,
      onPressUpOutside: onPressUpOutside,
      onTapAlwaysCalled: onTapAlwaysCalled,
      scrollController: scrollController,
      scrollPhysics: scrollPhysics,
      autofillHints: autofillHints,
      contentInsertionConfiguration: contentInsertionConfiguration,
      clipBehavior: clipBehavior,
      restorationId: restorationId,
      stylusHandwritingEnabled: stylusHandwritingEnabled,
      enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
      contextMenuBuilder: contextMenuBuilder,
      spellCheckConfiguration: spellCheckConfiguration,
      magnifierConfiguration: magnifierConfiguration,
      canRequestFocus: canRequestFocus,
      ignorePointers: ignorePointers,
      undoController: undoController,
      groupId: groupId,
      leading: leading,
      trailing: trailing,
      semanticLabel: semanticLabel,
      semanticHint: semanticHint,
      excludeSemantics: excludeSemantics,
      style: this,
    );
  }
}
