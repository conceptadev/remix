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
///   style: TextFieldStyler(),
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
    this.style = const TextFieldStyler.create(),
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
  final TextFieldStyler style;

  /// The style spec for the text field.
  final TextFieldSpec? styleSpec;

  static final styleFrom = TextFieldStyler.new;

  Widget _buildResolved(
    TextFieldSpec spec,
    WidgetStatesController styleController,
    FocusNode effectiveFocusNode, {
    required ValueChanged<bool> onEditablePressChange,
    required ValueChanged<bool> onFallbackPressChange,
  }) {
    final isMultiline = expands || maxLines != 1 || (minLines ?? 1) > 1;
    final hintAlignment = isMultiline
        ? AlignmentDirectional.topStart
        : AlignmentDirectional.centerStart;
    final acceptsPointerEvents = enabled && ignorePointers != true;
    final effectiveSemanticErrorText = error
        ? _joinSemanticText([helperText])
        : null;
    final joinedSemanticHint = _joinSemanticText([
      semanticHint ?? hintText,
      if (!error) helperText,
    ]);
    final effectiveSemanticHint =
        joinedSemanticHint == effectiveSemanticErrorText
        ? null
        : joinedSemanticHint;

    final nakedTextField = NakedTextField(
      groupId: groupId,
      controller: controller,
      focusNode: effectiveFocusNode,
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
      onFocusChange: (value) => styleController.update(.focused, value),
      onPressChange: acceptsPointerEvents ? onEditablePressChange : null,
      ignorePointers: ignorePointers,
      semanticLabel: semanticLabel ?? label,
      semanticHint: effectiveSemanticHint,
      semanticErrorText: effectiveSemanticErrorText,
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
                alignment: hintAlignment,
                children: [
                  if (textFieldState.text.isEmpty)
                    Positioned.fill(
                      child: Align(
                        alignment: hintAlignment,
                        child: ExcludeSemantics(
                          child: StyledText(
                            hintText!,
                            styleSpec: spec.hintText,
                          ),
                        ),
                      ),
                    ),
                  styledEditableText,
                ],
              )
            : styledEditableText;

        return error
            ? Semantics(
                validationResult: SemanticsValidationResult.invalid,
                child: editableWithHint,
              )
            : editableWithHint;
      },
    );

    final withAccessories = RemixBoxWithEffects(
      styleSpec: spec.container,
      containerEffects: spec.containerEffects,
      child: Row(
        spacing: spec.spacing ?? 0,
        crossAxisAlignment:
            spec.crossAxisAlignment ?? CrossAxisAlignment.center,
        textBaseline: TextBaseline.alphabetic,
        children: [
          ?leading,
          Expanded(child: nakedTextField),
          ?trailing,
        ],
      ),
    );

    final needsWrapper = label != null || helperText != null;
    Widget composite = needsWrapper
        ? FlexBox(
            styleSpec: spec.layout,
            children: [
              if (label != null)
                ExcludeSemantics(
                  child: StyledText(label!, styleSpec: spec.label),
                ),
              withAccessories,
              if (helperText != null)
                ExcludeSemantics(
                  child: StyledText(helperText!, styleSpec: spec.helperText),
                ),
            ],
          )
        : withAccessories;

    composite = _RemixTextFieldFallbackGestureDetector(
      enabled: acceptsPointerEvents,
      onTapAlwaysCalled: onTapAlwaysCalled,
      onPressChange: onFallbackPressChange,
      onTap: () {
        if (canRequestFocus && effectiveFocusNode.canRequestFocus) {
          effectiveFocusNode.requestFocus();
        }
        onTap?.call();
      },
      child: composite,
    );

    if (enabled) {
      composite = MouseRegion(
        onEnter: (_) => styleController.update(.hovered, true),
        onExit: (_) => styleController.update(.hovered, false),
        cursor: SystemMouseCursors.text,
        child: composite,
      );
    }

    return excludeSemantics ? ExcludeSemantics(child: composite) : composite;
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
  final _activePressSources = <_RemixTextFieldPressSource>{};
  FocusNode? _internalFocusNode;

  FocusNode get _effectiveFocusNode =>
      widget.config.focusNode ?? _internalFocusNode!;

  @override
  void initState() {
    super.initState();
    _styleController = WidgetStatesController({
      if (!widget.config.enabled || widget.config.readOnly) .disabled,
      if (widget.config.error) .error,
    });
    if (widget.config.focusNode == null) {
      _internalFocusNode = FocusNode(
        debugLabel: '${widget.config.runtimeType} (internal)',
      );
    }
  }

  @override
  void didUpdateWidget(_RemixTextFieldBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldExternalFocusNode = oldWidget.config.focusNode;
    final newExternalFocusNode = widget.config.focusNode;

    if (!identical(oldExternalFocusNode, newExternalFocusNode)) {
      if (oldExternalFocusNode == null && newExternalFocusNode != null) {
        final obsoleteInternalNode = _internalFocusNode!;
        _internalFocusNode = null;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          obsoleteInternalNode.dispose();
        });
      } else if (oldExternalFocusNode != null && newExternalFocusNode == null) {
        _internalFocusNode = FocusNode(
          debugLabel: '${widget.config.runtimeType} (internal)',
        );
      }
    }

    _styleController
      ..update(.disabled, !widget.config.enabled || widget.config.readOnly)
      ..update(.error, widget.config.error);

    if (!widget.config.enabled || widget.config.ignorePointers == true) {
      _activePressSources.clear();
      _styleController.update(.pressed, false);
    }
  }

  void _updatePressSource(_RemixTextFieldPressSource source, bool pressed) {
    if (!mounted) return;

    if (pressed) {
      _activePressSources.add(source);
    } else {
      _activePressSources.remove(source);
    }
    _styleController.update(.pressed, _activePressSources.isNotEmpty);
  }

  @override
  void dispose() {
    _styleController.dispose();
    _internalFocusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;

    return RemixStyleSpecBuilder<TextFieldSpec>(
      style: _baseStyle.merge(config.style),
      styleSpec: config.styleSpec,
      controller: _styleController,
      builder: (context, spec) => config._buildResolved(
        spec,
        _styleController,
        _effectiveFocusNode,
        onEditablePressChange: (pressed) =>
            _updatePressSource(.editable, pressed),
        onFallbackPressChange: (pressed) =>
            _updatePressSource(.fallback, pressed),
      ),
    );
  }
}

enum _RemixTextFieldPressSource { editable, fallback }

class _RemixTextFieldFallbackGestureDetector extends StatelessWidget {
  const _RemixTextFieldFallbackGestureDetector({
    required this.enabled,
    required this.onTapAlwaysCalled,
    required this.onPressChange,
    required this.onTap,
    required this.child,
  });

  final bool enabled;
  final bool onTapAlwaysCalled;
  final ValueChanged<bool> onPressChange;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!enabled) return child;

    return TextSelectionGestureDetector(
      onTapTrackReset: () => onPressChange(false),
      onTapDown: (_) => onPressChange(true),
      onSingleTapUp: (_) => onPressChange(false),
      onSingleTapCancel: () => onPressChange(false),
      onUserTap: onTap,
      onDoubleTapDown: (_) => onPressChange(false),
      onTripleTapDown: (_) => onPressChange(false),
      onDragSelectionStart: (_) => onPressChange(false),
      onUserTapAlwaysCalled: onTapAlwaysCalled,
      behavior: HitTestBehavior.translucent,
      child: child,
    );
  }
}

String? _joinSemanticText(Iterable<String?> values) {
  final pieces = <String>[];
  for (final value in values) {
    final normalized = value?.trim();
    if (normalized == null ||
        normalized.isEmpty ||
        pieces.contains(normalized)) {
      continue;
    }
    pieces.add(normalized);
  }

  return pieces.isEmpty ? null : pieces.join('\n');
}

/// Baseline style merged beneath the user-supplied style.
///
/// It seeds the [FlexBox] wrapper (the [TextFieldSpec.layout]) with a vertical,
/// min-size, start-aligned layout and 8px spacing. Merging it underneath the
/// caller's style means customizing a single layout property (for example,
/// `.layout(.spacing(12))`) keeps the remaining defaults instead of falling
/// back to `FlexBox`'s horizontal / max / center defaults.
final TextFieldStyler _baseStyle = TextFieldStyler(
  layout: FlexBoxStyler()
      .direction(.vertical)
      .mainAxisSize(.min)
      .crossAxisAlignment(.start)
      .spacing(8),
);
