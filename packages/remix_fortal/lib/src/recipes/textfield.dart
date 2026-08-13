// `DragStartBehavior` and `MaxLengthEnforcement` appear in the generated
// FortalTextField/FortalTextArea constructors, so they must be visible from
// this library even though nothing here references them directly.
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../fortal/fortal.dart';

part 'textfield.g.dart';

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

Color _resolveNeutralTextInputPlaceholder(BuildContext context) {
  final color = FortalTokens.grayA10.resolve(context);
  return color.withValues(alpha: color.a * 0.5);
}

const _neutralTextInputPlaceholder = ContextToken<Color>(
  _resolveNeutralTextInputPlaceholder,
);

/// Fortal-themed preset for [RemixTextField].
@MixWidget(target: RemixTextField.new)
TextFieldStyler fortalTextFieldStyle({
  FortalTextFieldVariant variant = .surface,
  FortalTextFieldSize size = .size2,
}) {
  final metrics = _fortalTextFieldMetrics(size, bordered: variant != .soft);
  final base = _fortalTextInputBaseStyle(
    container: BoxStyler()
        .height(metrics.height)
        .padding(.horizontal(metrics.paddingX))
        .borderRadius(.all(metrics.radius))
        .clipBehavior(.antiAlias),
    spacing: metrics.spacing,
    crossAxisAlignment: .center,
    text: metrics.text,
    focusColor: variant == .soft
        ? FortalTokens.accent8()
        : FortalTokens.focus8(),
  );

  final style = switch (variant) {
    .classic => _fortalApplyClassicTextInput(base),
    .surface => _fortalApplySurfaceTextInput(base),
    .soft => _fortalApplySoftTextInput(base, placeholderOpacity: 0.60),
  };

  return style.variant(
    ContextVariant.widgetState(.error),
    _fortalTextInputErrorStyle(),
  );
}

TextFieldStyler _fortalTextInputBaseStyle({
  required BoxStyler container,
  required double spacing,
  required CrossAxisAlignment crossAxisAlignment,
  required TextStyleToken text,
  required Color focusColor,
}) =>
    TextFieldStyler(
          container: container,
          spacing: spacing,
          crossAxisAlignment: crossAxisAlignment,
          text: .style(text.mix()),
          hintText: .style(text.mix()).textHeightBehavior(
            TextHeightBehaviorMix()
                .applyHeightToFirstAscent(false)
                .applyHeightToLastDescent(true),
          ),
          helperText: .style(FortalTokens.text1.mix()),
          label: .style(FortalTokens.text2.mix()),
          cursorWidth: 1.5,
          containerEffects: RemixBoxEffectsMix(
            behindContent: RemixBoxEffectLayerMix(),
            overContent: RemixBoxEffectLayerMix(),
          ),
        )
        .wrap(.iconTheme(color: FortalTokens.gray11(), size: 16.0))
        // Radix keys text-input rings from :focus/:focus-within, so unlike
        // control focus rings this intentionally follows raw focus.
        .onFocused(
          .containerEffects(fortalFocusOutline(focusColor, offset: -1)),
        );

TextFieldStyler _fortalApplyClassicTextInput(TextFieldStyler base) =>
    _fortalApplyNeutralTextInput(base)
        .color(FortalTokens.colorSurface())
        .containerEffects(
          RemixBoxEffectsMix.behindContent(
            RemixBoxEffectLayerMix(shadowToken: FortalTokens.shadow1Layers),
          ),
        )
        .onDisabled(
          _fortalNeutralTextInputDisabledStyle()
              .color(FortalTokens.colorSurface())
              .containerEffects(
                RemixBoxEffectsMix.behindContent(
                  RemixBoxEffectLayerMix(
                    gradients: [
                      RemixLinearGradientMix(
                        colors: [FortalTokens.grayA2(), FortalTokens.grayA2()],
                      ),
                    ],
                    shadowToken: FortalTokens.shadow1Layers,
                  ),
                ),
              ),
        );

TextFieldStyler _fortalApplySurfaceTextInput(TextFieldStyler base) =>
    _fortalApplyNeutralTextInput(base)
        .color(FortalTokens.colorSurface())
        .containerEffects(
          RemixBoxEffectsMix.behindContent(RemixBoxEffectLayerMix()),
        )
        .containerEffects(
          RemixBoxEffectsMix.overContent(
            _fortalTextInputInsetRing(FortalTokens.grayA7()),
          ),
        )
        .onDisabled(
          _fortalNeutralTextInputDisabledStyle()
              .color(FortalTokens.colorSurface())
              .containerEffects(
                RemixBoxEffectsMix.behindContent(
                  RemixBoxEffectLayerMix(
                    gradients: [
                      RemixLinearGradientMix(
                        colors: [FortalTokens.grayA2(), FortalTokens.grayA2()],
                      ),
                    ],
                  ),
                ),
              )
              .containerEffects(
                RemixBoxEffectsMix.overContent(
                  _fortalTextInputInsetRing(FortalTokens.grayA6()),
                ),
              ),
        );

TextFieldStyler _fortalApplySoftTextInput(
  TextFieldStyler base, {
  required double placeholderOpacity,
}) => base
    .merge(
      TextFieldStyler(
        text: .fontWeight(FortalTokens.fontWeightRegular()),
        hintText: .fontWeight(FortalTokens.fontWeightRegular()),
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
    .text(.selectionColor(FortalTokens.accentA5()))
    .onEnabled(
      .hintText(
        .color(FortalTokens.accent12().withValues(alpha: placeholderOpacity)),
      ),
    )
    .wrap(.iconTheme(color: FortalTokens.accent10()))
    .color(FortalTokens.accentA3())
    .containerEffects(
      RemixBoxEffectsMix.behindContent(RemixBoxEffectLayerMix()),
    )
    .onDisabled(
      _fortalSoftTextInputDisabledStyle()
          .color(FortalTokens.grayA3())
          .containerEffects(
            RemixBoxEffectsMix.behindContent(RemixBoxEffectLayerMix()),
          ),
    );

TextFieldStyler _fortalApplyNeutralTextInput(TextFieldStyler base) =>
    base.merge(
      TextFieldStyler(
        text: .color(
          FortalTokens.gray12(),
        ).selectionColor(FortalTokens.focusA5()),
        hintText: .color(_neutralTextInputPlaceholder()),
        cursorColor: FortalTokens.gray12(),
        helperText: .color(FortalTokens.gray11()),
        label: .color(
          FortalTokens.gray12(),
        ).fontWeight(FortalTokens.fontWeightMedium()),
      ),
    );

// Keep the disabled-color branch on raw focus for the same :focus-within
// contract as the enabled text input.
TextFieldStyler _fortalTextInputDisabledBaseStyle() =>
    TextFieldStyler(
      text: .color(
        FortalTokens.grayA11(),
      ).selectionColor(FortalTokens.grayA5()),
      cursorColor: FortalTokens.grayA11(),
    ).onFocused(
      .containerEffects(fortalFocusOutline(FortalTokens.gray8(), offset: -1)),
    );

TextFieldStyler _fortalNeutralTextInputDisabledStyle() =>
    _fortalTextInputDisabledBaseStyle().hintText(
      .color(_neutralTextInputPlaceholder()),
    );

TextFieldStyler _fortalSoftTextInputDisabledStyle() =>
    _fortalTextInputDisabledBaseStyle().hintText(
      .color(FortalTokens.accent12().withValues(alpha: 0.5)),
    );

TextFieldStyler _fortalTextInputErrorStyle() => TextFieldStyler(
  helperText: .color(FortalTokens.error11()),
  label: .color(FortalTokens.error11()),
  cursorColor: FortalTokens.error9(),
  containerEffects: RemixBoxEffectsMix(
    overContent: RemixBoxEffectLayerMix(
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

RemixBoxEffectLayerMix _fortalTextInputInsetRing(Color color) =>
    RemixBoxEffectLayerMix(
      shadows: [RemixBoxShadowMix(kind: .inset, color: color, spreadRadius: 1)],
    );

/// Radix Themes TextArea size presets.
enum FortalTextAreaSize { size1, size2, size3 }

/// Radix Themes TextArea variants.
enum FortalTextAreaVariant { classic, surface, soft }

/// Fortal recipe for [RemixTextArea].
///
/// Scrolling follows the host platform; this recipe does not reproduce Radix's
/// themed browser scrollbar or resize handle.
@MixWidget(target: RemixTextArea.new)
TextFieldStyler fortalTextAreaStyle({
  FortalTextAreaVariant variant = .surface,
  FortalTextAreaSize size = .size2,
}) {
  final metrics = _fortalTextAreaMetrics(size);
  final base = _fortalTextInputBaseStyle(
    container: BoxStyler()
        .minHeight(metrics.minHeight)
        .padding(
          .symmetric(horizontal: metrics.paddingX, vertical: metrics.paddingY),
        )
        .borderRadius(.all(metrics.radius))
        .clipBehavior(.antiAlias),
    spacing: metrics.spacing,
    crossAxisAlignment: .start,
    text: metrics.text,
    focusColor: variant == .soft
        ? FortalTokens.accent8()
        : FortalTokens.focus8(),
  );

  final style = switch (variant) {
    .classic => _fortalApplyClassicTextInput(base),
    .surface => _fortalApplySurfaceTextInput(base),
    .soft => _fortalApplySoftTextInput(base, placeholderOpacity: 0.65),
  };

  return style.variant(
    ContextVariant.widgetState(.error),
    _fortalTextInputErrorStyle(),
  );
}

({
  double minHeight,
  double paddingX,
  double paddingY,
  double spacing,
  Radius radius,
  TextStyleToken text,
})
_fortalTextAreaMetrics(FortalTextAreaSize size) => switch (size) {
  .size1 => (
    minHeight: FortalTokens.space8(),
    paddingX: FortalTokens.selectSpace1Half(),
    paddingY: FortalTokens.space1(),
    spacing: FortalTokens.space2(),
    radius: FortalTokens.radius2(),
    text: FortalTokens.text1,
  ),
  .size2 => (
    minHeight: FortalTokens.space9(),
    paddingX: FortalTokens.space2(),
    paddingY: FortalTokens.selectSpace1Half(),
    spacing: FortalTokens.space2(),
    radius: FortalTokens.radius2(),
    text: FortalTokens.text2,
  ),
  .size3 => (
    minHeight: FortalTokens.textAreaMinHeight3(),
    paddingX: FortalTokens.space3(),
    paddingY: FortalTokens.space2(),
    spacing: FortalTokens.space3(),
    radius: FortalTokens.radius3(),
    text: FortalTokens.text3,
  ),
};
