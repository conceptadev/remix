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
  /// Raised treatment with Radix's level-one shadow.
  classic,

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
  final style = switch (variant) {
    .classic => _fortalTextFieldClassicStyler(size),
    .surface => _fortalTextFieldSurfaceStyler(size),
    .soft => _fortalTextFieldSoftStyler(size),
  };
  return style.variant(
    ContextVariant.widgetState(.error),
    _fortalTextFieldErrorStyler(),
  );
}

RemixTextFieldStyler _fortalTextFieldBaseStyler(
  FortalTextFieldSize size, {
  required bool bordered,
}) {
  final metrics = _fortalTextFieldMetrics(size, bordered: bordered);
  return RemixTextFieldStyler(
        container: .height(metrics.height)
            .paddingX(metrics.paddingX)
            .spacing(metrics.spacing)
            .crossAxisAlignment(.center)
            .borderRadiusAll(metrics.radius)
            .clipBehavior(.antiAlias),
        text: .style(metrics.text.mix()),
        hintText: .style(metrics.text.mix()).textHeightBehavior(
          TextHeightBehaviorMix()
              .applyHeightToFirstAscent(false)
              .applyHeightToLastDescent(true),
        ),
        helperText: .style(FortalTokens.text1.mix()),
        label: .style(FortalTokens.text2.mix()),
        cursorWidth: 1.5,
        containerEffects: RemixBoxEffectsMix(
          behindContent: _fortalTextFieldLayer(),
          overContent: _fortalTextFieldLayer(),
        ),
      )
      .wrap(.iconTheme(color: FortalTokens.gray11(), size: 16.0))
      .onFocused(
        .containerEffects(
          RemixBoxEffectsMix(
            outline: BorderSideMix(
              color: FortalTokens.focus8(),
              width: 2,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
            outlineOffset: -1,
          ),
        ),
      );
}

RemixTextFieldStyler _fortalTextFieldClassicStyler(FortalTextFieldSize size) {
  return _fortalTextFieldNeutralText(
        _fortalTextFieldBaseStyler(size, bordered: true),
      )
      .color(FortalTokens.colorSurface())
      .containerEffects(
        RemixBoxEffectsMix(
          behindContent: _fortalTextFieldLayer(
            shadowToken: FortalTokens.shadow1,
          ),
        ),
      )
      .onDisabled(
        _fortalTextFieldDisabledText()
            .color(FortalTokens.colorSurface())
            .containerEffects(
              RemixBoxEffectsMix(
                behindContent: _fortalTextFieldLayer(
                  gradients: [
                    RemixLinearGradientMix(
                      colors: [FortalTokens.grayA2(), FortalTokens.grayA2()],
                    ),
                  ],
                  shadowToken: FortalTokens.shadow1,
                ),
              ),
            ),
      );
}

RemixTextFieldStyler _fortalTextFieldSurfaceStyler([
  FortalTextFieldSize size = .size2,
]) {
  return _fortalTextFieldNeutralText(
        _fortalTextFieldBaseStyler(size, bordered: true),
      )
      .color(FortalTokens.colorSurface())
      .containerEffects(
        RemixBoxEffectsMix(behindContent: _fortalTextFieldLayer()),
      )
      .containerEffects(
        RemixBoxEffectsMix(
          overContent: _fortalTextFieldInsetRing(FortalTokens.grayA7()),
        ),
      )
      .onDisabled(
        _fortalTextFieldDisabledText()
            .color(FortalTokens.colorSurface())
            .containerEffects(
              RemixBoxEffectsMix(
                behindContent: _fortalTextFieldLayer(
                  gradients: [
                    RemixLinearGradientMix(
                      colors: [FortalTokens.grayA2(), FortalTokens.grayA2()],
                    ),
                  ],
                ),
              ),
            )
            .containerEffects(
              RemixBoxEffectsMix(
                overContent: _fortalTextFieldInsetRing(FortalTokens.grayA6()),
              ),
            ),
      );
}

RemixTextFieldStyler _fortalTextFieldSoftStyler([
  FortalTextFieldSize size = .size2,
]) {
  return _fortalTextFieldBaseStyler(size, bordered: false)
      .merge(
        RemixTextFieldStyler(
          text: .fontWeight(FortalTokens.fontWeightRegular()),
          hintText: .color(
            FortalTokens.accentA11(),
          ).fontWeight(FortalTokens.fontWeightRegular()),
          cursorColor: FortalTokens.accent12(),
          helperText: .color(
            FortalTokens.gray11(),
          ).fontWeight(FortalTokens.fontWeightRegular()),
          label: .color(
            FortalTokens.gray12(),
          ).fontWeight(FortalTokens.fontWeightMedium()),
        ),
      )
      .textColor(FortalTokens.accent12())
      .wrap(.iconTheme(color: FortalTokens.accent10()))
      .color(FortalTokens.accentA3())
      .containerEffects(
        RemixBoxEffectsMix(behindContent: _fortalTextFieldLayer()),
      )
      .onDisabled(
        _fortalTextFieldDisabledText()
            .color(FortalTokens.grayA3())
            .containerEffects(
              RemixBoxEffectsMix(behindContent: _fortalTextFieldLayer()),
            ),
      );
}

RemixTextFieldStyler _fortalTextFieldNeutralText(RemixTextFieldStyler base) =>
    base.merge(
      RemixTextFieldStyler(
        text: .color(FortalTokens.gray12()),
        hintText: .color(FortalTokens.grayA10()),
        cursorColor: FortalTokens.gray12(),
        helperText: .color(FortalTokens.gray11()),
        label: .color(
          FortalTokens.gray12(),
        ).fontWeight(FortalTokens.fontWeightMedium()),
      ),
    );

RemixTextFieldStyler _fortalTextFieldDisabledText() =>
    RemixTextFieldStyler(
      text: .color(FortalTokens.gray11()),
      hintText: .color(FortalTokens.grayA8()),
      cursorColor: FortalTokens.gray8(),
    ).onFocused(
      .containerEffects(
        RemixBoxEffectsMix(
          outline: BorderSideMix(
            color: FortalTokens.gray8(),
            width: 2,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
          outlineOffset: -1,
        ),
      ),
    );

RemixTextFieldStyler _fortalTextFieldErrorStyler() {
  return RemixTextFieldStyler(
    helperText: .color(FortalTokens.error11()),
    label: .color(FortalTokens.error11()),
    cursorColor: FortalTokens.error9(),
    containerEffects: RemixBoxEffectsMix(
      overContent: _fortalTextFieldLayer(
        shadows: [
          RemixBoxShadowMix(
            kind: .inset,
            color: FortalTokens.errorA7(),
            spreadRadius: 1,
          ),
        ],
      ),
      outline: BorderSideMix(
        color: FortalTokens.error8(),
        width: 2,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
      outlineOffset: -1,
    ),
  );
}

({
  double height,
  double paddingX,
  double spacing,
  Radius radius,
  TextStyleToken text,
})
_fortalTextFieldMetrics(FortalTextFieldSize size, {required bool bordered}) =>
    switch (size) {
      .size1 => (
        height: FortalTokens.space5(),
        paddingX: bordered
            ? FortalTokens.textFieldPadding1()
            : FortalTokens.selectSpace1Half(),
        spacing: FortalTokens.space2(),
        radius: FortalTokens.radius2OrFull(),
        text: FortalTokens.text1,
      ),
      .size2 => (
        height: FortalTokens.space6(),
        paddingX: bordered
            ? FortalTokens.textFieldPadding2()
            : FortalTokens.space2(),
        spacing: FortalTokens.space2(),
        radius: FortalTokens.radius2OrFull(),
        text: FortalTokens.text2,
      ),
      .size3 => (
        height: FortalTokens.space7(),
        paddingX: bordered
            ? FortalTokens.textFieldPadding3()
            : FortalTokens.space3(),
        spacing: FortalTokens.space3(),
        radius: FortalTokens.radius3OrFull(),
        text: FortalTokens.text3,
      ),
    };

RemixBoxEffectLayerMix _fortalTextFieldInsetRing(Color color) =>
    _fortalTextFieldLayer(
      shadows: [RemixBoxShadowMix(kind: .inset, color: color, spreadRadius: 1)],
    );

RemixBoxEffectLayerMix _fortalTextFieldLayer({
  List<RemixLinearGradientMix>? gradients,
  List<RemixBoxShadowMix>? shadows,
  RemixBoxShadowListToken? shadowToken,
}) => RemixBoxEffectLayerMix(
  gradients: gradients,
  shadows: shadows,
  shadowToken: shadowToken,
);

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

  const FortalTextField.classic({
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
  }) : variant = .classic;

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
  }) : variant = .surface;

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
  }) : variant = .soft;

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

    return FortalComponentOverride(
      color: this.color,
      radius: this.radius,
      // Radix keeps read-only selection interactive while neutralizing it.
      child: this.readOnly
          ? Builder(
              builder: (context) => DefaultSelectionStyle.merge(
                selectionColor: FortalTokens.grayA5.resolve(context),
                child: textField,
              ),
            )
          : textField,
    );
  }
}
