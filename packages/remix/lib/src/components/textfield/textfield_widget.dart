part of 'textfield.dart';

/// A customizable text field component that supports various styles and behaviors.
/// The text field integrates with the Mix styling system and follows Remix design patterns.
///
/// ## Example
///
/// ```dart
/// RemixTextField(
///   controller: _controller,
///   hintText: 'Enter your name',
///   helperText: 'Required field',
///   onChanged: (value) {
///     debugPrint('Value changed: $value');
///   },
///   style: RemixTextFieldStyler(),
/// )
/// ```
class RemixTextField extends StatelessWidget {
  const RemixTextField({
    super.key,
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
    this.readOnly = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.showCursor,
    this.obscuringCharacter = '•',
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.dragStartBehavior = .start,
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.onTap,
    this.onTapOutside,
    this.onPressUpOutside,
    this.onTapAlwaysCalled = false,
    this.scrollController,
    this.scrollPhysics,
    this.autofillHints,
    this.contentInsertionConfiguration,
    this.clipBehavior = .hardEdge,
    this.restorationId,
    this.stylusHandwritingEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.contextMenuBuilder,
    this.spellCheckConfiguration,
    this.magnifierConfiguration,
    this.canRequestFocus = true,
    this.ignorePointers,
    this.undoController,
    this.groupId = EditableText,
    this.leading,
    this.trailing,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
    this.style = const RemixTextFieldStyler.create(),
    this.styleSpec,
  });

  /// Controls the text being edited.
  final TextEditingController? controller;

  /// Defines the keyboard focus for this widget.
  final FocusNode? focusNode;

  /// Undo controller for managing undo/redo operations.
  final UndoHistoryController? undoController;

  /// The group ID for the text field.
  final Object groupId;

  /// The type of keyboard to use for editing the text.
  final TextInputType? keyboardType;

  /// The type of action button to use for the keyboard.
  final TextInputAction? textInputAction;

  /// Configures how the platform keyboard will select an uppercase or lowercase keyboard.
  final TextCapitalization textCapitalization;

  /// The directionality of the text.
  final TextDirection? textDirection;

  /// Whether the text can be changed.
  final bool readOnly;

  /// Whether to show cursor.
  final bool? showCursor;

  /// Whether this text field should focus itself if nothing else is already focused.
  final bool autofocus;

  /// Whether to hide the text being edited.
  final bool obscureText;

  /// Character used for obscuring text if obscureText is true.
  final String obscuringCharacter;

  /// Whether to enable autocorrect.
  final bool autocorrect;

  /// Whether to show input suggestions as the user types.
  final bool enableSuggestions;

  /// Configuration for smart dashes.
  final SmartDashesType? smartDashesType;

  /// Configuration for smart quotes.
  final SmartQuotesType? smartQuotesType;

  /// The maximum number of lines for the text to span.
  final int? maxLines;

  /// The minimum number of lines to occupy when the content spans fewer lines.
  final int? minLines;

  /// Whether this widget's height will be sized to fill its parent.
  final bool expands;

  /// The maximum number of characters to allow in the text field.
  final int? maxLength;

  /// How the maxLength limit should be enforced.
  final MaxLengthEnforcement? maxLengthEnforcement;

  /// Called when the user initiates a change to the TextField's value.
  final ValueChanged<String>? onChanged;

  /// Called when the user submits editable content.
  final VoidCallback? onEditingComplete;

  /// Called when the user indicates that they are done editing the text in the field.
  final ValueChanged<String>? onSubmitted;

  /// This is used to receive a private command from the input method.
  final AppPrivateCommandCallback? onAppPrivateCommand;

  /// Optional input formatters.
  final List<TextInputFormatter>? inputFormatters;

  /// Whether the text field is enabled.
  final bool enabled;

  /// Defines how to handle drag start behavior.
  final DragStartBehavior dragStartBehavior;

  /// Whether to enable user interface affordances for changing the text selection.
  final bool enableInteractiveSelection;

  /// Optional delegate for building the text selection handles and toolbar.
  final TextSelectionControls? selectionControls;

  /// Called when the text field is tapped.
  final GestureTapCallback? onTap;

  /// Called when the user taps outside of this text field.
  final TapRegionCallback? onTapOutside;

  /// Called when tap up is detected outside of this text field.
  final TapRegionUpCallback? onPressUpOutside;

  /// Whether onTap should be called for every tap.
  final bool onTapAlwaysCalled;

  /// The ScrollController to use when vertically scrolling the input.
  final ScrollController? scrollController;

  /// The ScrollPhysics to use when vertically scrolling the input.
  final ScrollPhysics? scrollPhysics;

  /// A list of strings that helps the autofill service identify the type of this text input.
  final Iterable<String>? autofillHints;

  /// Configuration for content insertion.
  final ContentInsertionConfiguration? contentInsertionConfiguration;

  /// The content will be clipped (or not) according to this option.
  final Clip clipBehavior;

  /// Restoration ID to save and restore the state of the text field.
  final String? restorationId;

  /// Whether stylus handwriting is enabled.
  final bool stylusHandwritingEnabled;

  /// Whether to enable that the IME update personalized data.
  final bool enableIMEPersonalizedLearning;

  /// A context menu builder for the text field.
  final EditableTextContextMenuBuilder? contextMenuBuilder;

  /// Configuration for spell checking.
  final SpellCheckConfiguration? spellCheckConfiguration;

  /// Configuration for text magnification.
  final TextMagnifierConfiguration? magnifierConfiguration;

  /// Whether this text field can request focus.
  final bool canRequestFocus;

  /// Whether to ignore pointer events.
  final bool? ignorePointers;

  /// Hint text to display when the text field is empty.
  final String? hintText;

  /// Helper text to display below the text field.
  final String? helperText;

  /// Label text to display above the text field.
  final String? label;

  /// Whether the text field is in error state.
  final bool error;

  /// A widget to display at the leading edge of the text field.
  final Widget? leading;

  /// A widget to display at the trailing edge of the text field.
  final Widget? trailing;

  /// The semantic label for the text field.
  final String? semanticLabel;

  /// The semantic hint for the text field.
  final String? semanticHint;

  /// Whether to exclude child semantics.
  final bool excludeSemantics;

  /// The style configuration for the text field.
  final RemixTextFieldStyler style;

  /// The style spec for the text field.
  final RemixTextFieldSpec? styleSpec;

  static final styleFrom = RemixTextFieldStyler.new;

  Widget _buildResolved(
    RemixTextFieldSpec spec,
    WidgetStatesController styleController,
  ) {
    return NakedTextField(
      groupId: groupId,
      controller: controller,
      focusNode: focusNode,
      undoController: undoController,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      textAlign: spec.textAlign ?? .start,
      textDirection: textDirection,
      readOnly: readOnly,
      showCursor: showCursor,
      autofocus: autofocus,
      obscuringCharacter: obscuringCharacter,
      obscureText: obscureText,
      autocorrect: autocorrect,
      smartDashesType: smartDashesType,
      smartQuotesType: smartQuotesType,
      enableSuggestions: enableSuggestions,
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
      enabled: enabled,
      error: error,
      cursorWidth: spec.cursorWidth ?? 2.0,
      cursorHeight: spec.cursorHeight,
      cursorRadius: spec.cursorRadius,
      cursorOpacityAnimates: spec.cursorOpacityAnimates,
      cursorColor: spec.cursorColor,
      selectionHeightStyle: spec.selectionHeightStyle ?? .tight,
      selectionWidthStyle: spec.selectionWidthStyle ?? .tight,
      keyboardAppearance: spec.keyboardAppearance,
      scrollPadding: spec.scrollPadding ?? const .all(20.0),
      dragStartBehavior: dragStartBehavior,
      enableInteractiveSelection: enableInteractiveSelection,
      selectionControls: selectionControls,
      onTap: onTap,
      onTapAlwaysCalled: onTapAlwaysCalled,
      onTapOutside: onTapOutside,
      scrollController: scrollController,
      scrollPhysics: scrollPhysics,
      autofillHints: autofillHints,
      contentInsertionConfiguration: contentInsertionConfiguration,
      clipBehavior: clipBehavior,
      restorationId: restorationId,
      onTapUpOutside: onPressUpOutside,
      stylusHandwritingEnabled: stylusHandwritingEnabled,
      enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
      contextMenuBuilder: contextMenuBuilder,
      canRequestFocus: canRequestFocus,
      spellCheckConfiguration: spellCheckConfiguration,
      magnifierConfiguration: magnifierConfiguration,
      onHoverChange: (value) => styleController.update(.hovered, value),
      onFocusChange: (value) => styleController.update(.focused, value),
      onPressChange: (value) => styleController.update(.pressed, value),
      ignorePointers: ignorePointers,
      semanticLabel: semanticLabel ?? label,
      semanticHint: semanticHint ?? hintText,
      semanticErrorText: error ? helperText : null,
      excludeSemantics: excludeSemantics,
      builder: (BuildContext context, _, Widget editableText) {
        final textFieldState = NakedTextFieldState.of(context);
        final styledEditableText = StyleSpecBuilder(
          styleSpec: spec.text,
          builder: (context, textSpec) => DefaultTextStyle.merge(
            style: textSpec.style,
            child: editableText,
          ),
        );

        final editableWithHint = hintText != null
            ? Stack(
                alignment: AlignmentDirectional.centerStart,
                children: [
                  if (textFieldState.text.isEmpty)
                    Positioned.fill(
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: StyledText(hintText!, styleSpec: spec.hintText),
                      ),
                    ),
                  styledEditableText,
                ],
              )
            : styledEditableText;

        final withAccessories = RemixFlexBoxWithEffects(
          styleSpec: spec.container,
          direction: Axis.horizontal,
          containerEffects: spec.containerEffects,
          children: [
            ?leading,
            // ignore: avoid-flexible-outside-flex
            Expanded(child: editableWithHint),
            ?trailing,
          ],
        );

        final needsWrapper = label != null || helperText != null;

        return needsWrapper
            ? ColumnBox(
                styleSpec: spec.layout,
                children: [
                  if (label != null) StyledText(label!, styleSpec: spec.label),
                  withAccessories,
                  if (helperText != null)
                    StyledText(helperText!, styleSpec: spec.helperText),
                ],
              )
            : withAccessories;
      },
    );
  }

  @override
  Widget build(BuildContext context) => _RemixTextFieldBody(config: this);
}

class _RemixTextFieldBody extends StatefulWidget {
  const _RemixTextFieldBody({required this.config});

  final RemixTextField config;

  @override
  State<_RemixTextFieldBody> createState() => _RemixTextFieldBodyState();
}

class _RemixTextFieldBodyState extends State<_RemixTextFieldBody> {
  late final WidgetStatesController _styleController;

  @override
  void initState() {
    super.initState();
    _styleController = WidgetStatesController({
      if (!widget.config.enabled || widget.config.readOnly) .disabled,
      if (widget.config.error) .error,
    });
  }

  @override
  void didUpdateWidget(_RemixTextFieldBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    _styleController
      ..update(.disabled, !widget.config.enabled || widget.config.readOnly)
      ..update(.error, widget.config.error);
  }

  @override
  void dispose() {
    _styleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;

    return RemixStyleSpecBuilder<RemixTextFieldSpec>(
      style: _baseStyle.merge(config.style),
      styleSpec: config.styleSpec,
      controller: _styleController,
      builder: (context, spec) => config._buildResolved(spec, _styleController),
    );
  }
}

/// Baseline style merged beneath the user-supplied style.
///
/// It seeds the vertical [ColumnBox] wrapper (the [RemixTextFieldSpec.layout])
/// with the default min-size / start-alignment layout and an 8px vertical
/// spacing. Merging it underneath the caller's style means customizing a
/// single layout property (e.g. `.layout(.spacing(12))`) keeps
/// the remaining defaults instead of falling back to `ColumnBox`'s
/// `mainAxisSize: max` / `crossAxisAlignment: center`.
final RemixTextFieldStyler _baseStyle = RemixTextFieldStyler(
  layout: FlexBoxStyler()
      .mainAxisSize(.min)
      .crossAxisAlignment(.start)
      .spacing(8),
);
