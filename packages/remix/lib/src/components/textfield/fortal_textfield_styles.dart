part of 'textfield.dart';

/// Fortal text field size presets.
enum FortalTextFieldSize {
  /// Compact text field.
  size1,

  /// Default text field.
  size2,

  /// Large text field.
  size3,
}

/// Fortal text field color variants.
enum FortalTextFieldVariant {
  /// Surface treatment with neutral border and text colors.
  surface,

  /// Soft accent treatment.
  soft,
}

/// Fortal-themed preset for [RemixTextField].
RemixTextFieldStyler fortalTextFieldStyler({
  FortalTextFieldVariant variant = .surface,
  FortalTextFieldSize size = .size2,
}) {
  return switch (variant) {
    .surface => _fortalTextFieldSurfaceStyler(size),
    .soft => _fortalTextFieldSoftStyler(size),
  };
}

RemixTextFieldStyler _fortalTextFieldBaseStyler(FortalTextFieldSize size) {
  return RemixTextFieldStyler(
        hintText: TextStyler().textHeightBehavior(
          TextHeightBehaviorMix()
              .applyHeightToFirstAscent(false)
              .applyHeightToLastDescent(true),
        ),
        cursorWidth: 1.5,
      )
      .spacing(8)
      .wrap(.iconTheme(color: FortalTokens.gray10(), size: 16.0))
      .onFocused(
        RemixTextFieldStyler().borderAll(
          color: FortalTokens.accent8(),
          width: FortalTokens.borderWidth1(),
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      )
      .merge(_fortalTextFieldSizeStyler(size));
}

RemixTextFieldStyler _fortalTextFieldSurfaceStyler([
  FortalTextFieldSize size = .size2,
]) {
  return _fortalTextFieldBaseStyler(size)
      .merge(
        RemixTextFieldStyler(
          text: TextStyler()
              .color(FortalTokens.gray12())
              .fontWeight(FortalTokens.fontWeightRegular()),
          hintText: TextStyler()
              .color(FortalTokens.gray10())
              .fontWeight(FortalTokens.fontWeightRegular()),
          cursorColor: FortalTokens.gray12(),
          helperText: TextStyler()
              .color(FortalTokens.gray11())
              .fontWeight(FortalTokens.fontWeightRegular()),
          label: TextStyler()
              .color(FortalTokens.gray12())
              .fontWeight(FortalTokens.fontWeightMedium()),
        ),
      )
      .borderAll(
        color: FortalTokens.gray7(),
        width: FortalTokens.borderWidth1(),
        strokeAlign: BorderSide.strokeAlignOutside,
      )
      .color(FortalTokens.gray12())
      .onFocused(
        RemixTextFieldStyler().borderAll(
          color: FortalTokens.accent7(),
          width: FortalTokens.borderWidth1(),
        ),
      )
      .onDisabled(
        RemixTextFieldStyler(
              text: TextStyler().color(FortalTokens.gray10()),
              hintText: TextStyler().color(FortalTokens.gray8()),
            )
            .backgroundColor(FortalTokens.colorSurface())
            .borderAll(
              color: FortalTokens.gray6(),
              width: FortalTokens.borderWidth1(),
            ),
      );
}

RemixTextFieldStyler _fortalTextFieldSoftStyler([
  FortalTextFieldSize size = .size2,
]) {
  return _fortalTextFieldBaseStyler(size)
      .merge(
        RemixTextFieldStyler(
          text: TextStyler().fontWeight(FortalTokens.fontWeightRegular()),
          hintText: TextStyler()
              .color(FortalTokens.accentA11())
              .fontWeight(FortalTokens.fontWeightRegular()),
          cursorColor: FortalTokens.accent12(),
          helperText: TextStyler()
              .color(FortalTokens.gray11())
              .fontWeight(FortalTokens.fontWeightRegular()),
          label: TextStyler()
              .color(FortalTokens.gray12())
              .fontWeight(FortalTokens.fontWeightMedium()),
        ),
      )
      .color(FortalTokens.accent12())
      .wrap(.iconTheme(color: FortalTokens.accent10()))
      .backgroundColor(FortalTokens.accent3())
      .borderAll(
        color: FortalTokens.accent3(),
        width: FortalTokens.borderWidth1(),
        strokeAlign: BorderSide.strokeAlignOutside,
      )
      .onDisabled(
        RemixTextFieldStyler(
              text: TextStyler().color(FortalTokens.accentA8()),
              hintText: TextStyler().color(FortalTokens.accentA7()),
            )
            .backgroundColor(FortalTokens.accentA3())
            .borderAll(
              color: FortalTokens.accentA4(),
              width: FortalTokens.borderWidth1(),
            ),
      );
}

RemixTextFieldStyler _fortalTextFieldSizeStyler(FortalTextFieldSize size) {
  return switch (size) {
    .size1 => RemixTextFieldStyler(
      text: TextStyler().fontSize(12.0),
      hintText: TextStyler().fontSize(12.0),
      helperText: TextStyler().fontSize(11.0),
      label: TextStyler().fontSize(11.0),
    ).borderRadiusAll(FortalTokens.radius2()).paddingAll(8.0),
    .size2 => RemixTextFieldStyler(
      text: TextStyler().fontSize(14.0),
      hintText: TextStyler().fontSize(14.0),
      helperText: TextStyler().fontSize(12.0),
      label: TextStyler().fontSize(13.0),
    ).borderRadiusAll(FortalTokens.radius3()).paddingAll(12.0),
    .size3 => RemixTextFieldStyler(
      text: TextStyler().fontSize(15.0),
      hintText: TextStyler().fontSize(15.0),
      helperText: TextStyler().fontSize(14.0),
      label: TextStyler().fontSize(15.0),
    ).borderRadiusAll(FortalTokens.radius4()).paddingAll(16.0),
  };
}

/// Fortal-themed preset for [RemixTextField].
class FortalTextField extends StatelessWidget {
  const FortalTextField({
    super.key,
    this.variant = .surface,
    this.size = .size2,
    this.color,
    this.radius,
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
  });

  /// Surface treatment with neutral border and text colors.
  const FortalTextField.surface({
    super.key,
    this.size = .size2,
    this.color,
    this.radius,
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
  }) : variant = FortalTextFieldVariant.surface;

  /// Soft accent treatment.
  const FortalTextField.soft({
    super.key,
    this.size = .size2,
    this.color,
    this.radius,
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
  }) : variant = FortalTextFieldVariant.soft;

  final FortalTextFieldVariant variant;

  final FortalTextFieldSize size;

  /// Optional accent color override for this text field subtree.
  final FortalAccentColor? color;

  /// Optional radius override for this text field subtree.
  final FortalRadius? radius;

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

  final bool readOnly;

  final bool autofocus;

  final int? maxLines;

  final int? minLines;

  final bool expands;

  final int? maxLength;

  final MaxLengthEnforcement? maxLengthEnforcement;

  final ValueChanged<String>? onChanged;

  final VoidCallback? onEditingComplete;

  final ValueChanged<String>? onSubmitted;

  final AppPrivateCommandCallback? onAppPrivateCommand;

  final List<TextInputFormatter>? inputFormatters;

  final bool? showCursor;

  final String obscuringCharacter;

  final bool autocorrect;

  final bool enableSuggestions;

  final SmartDashesType? smartDashesType;

  final SmartQuotesType? smartQuotesType;

  final DragStartBehavior dragStartBehavior;

  final bool enableInteractiveSelection;

  final TextSelectionControls? selectionControls;

  final GestureTapCallback? onTap;

  final TapRegionCallback? onTapOutside;

  final TapRegionUpCallback? onPressUpOutside;

  final bool onTapAlwaysCalled;

  final ScrollController? scrollController;

  final ScrollPhysics? scrollPhysics;

  final Iterable<String>? autofillHints;

  final ContentInsertionConfiguration? contentInsertionConfiguration;

  final Clip clipBehavior;

  final String? restorationId;

  final bool stylusHandwritingEnabled;

  final bool enableIMEPersonalizedLearning;

  final EditableTextContextMenuBuilder? contextMenuBuilder;

  final SpellCheckConfiguration? spellCheckConfiguration;

  final TextMagnifierConfiguration? magnifierConfiguration;

  final bool canRequestFocus;

  final bool? ignorePointers;

  final UndoHistoryController? undoController;

  final Object groupId;

  final Widget? leading;

  final Widget? trailing;

  final String? semanticLabel;

  final String? semanticHint;

  final bool excludeSemantics;

  @override
  Widget build(BuildContext context) {
    final textField =
        fortalTextFieldStyler(variant: this.variant, size: this.size).call(
          key: this.key,
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
          onAppPrivateCommand: this.onAppPrivateCommand,
          inputFormatters: this.inputFormatters,
          showCursor: this.showCursor,
          obscuringCharacter: this.obscuringCharacter,
          autocorrect: this.autocorrect,
          enableSuggestions: this.enableSuggestions,
          smartDashesType: this.smartDashesType,
          smartQuotesType: this.smartQuotesType,
          dragStartBehavior: this.dragStartBehavior,
          enableInteractiveSelection: this.enableInteractiveSelection,
          selectionControls: this.selectionControls,
          onTap: this.onTap,
          onTapOutside: this.onTapOutside,
          onPressUpOutside: this.onPressUpOutside,
          onTapAlwaysCalled: this.onTapAlwaysCalled,
          scrollController: this.scrollController,
          scrollPhysics: this.scrollPhysics,
          autofillHints: this.autofillHints,
          contentInsertionConfiguration: this.contentInsertionConfiguration,
          clipBehavior: this.clipBehavior,
          restorationId: this.restorationId,
          stylusHandwritingEnabled: this.stylusHandwritingEnabled,
          enableIMEPersonalizedLearning: this.enableIMEPersonalizedLearning,
          contextMenuBuilder: this.contextMenuBuilder,
          spellCheckConfiguration: this.spellCheckConfiguration,
          magnifierConfiguration: this.magnifierConfiguration,
          canRequestFocus: this.canRequestFocus,
          ignorePointers: this.ignorePointers,
          undoController: this.undoController,
          groupId: this.groupId,
          leading: this.leading,
          trailing: this.trailing,
          semanticLabel: this.semanticLabel,
          semanticHint: this.semanticHint,
          excludeSemantics: this.excludeSemantics,
        );

    return FortalOverride(
      color: this.color,
      radius: this.radius,
      child: textField,
    );
  }
}
