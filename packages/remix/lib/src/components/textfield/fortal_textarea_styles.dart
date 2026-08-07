part of 'textfield.dart';

/// Radix Themes TextArea size presets.
enum FortalTextAreaSize { size1, size2, size3 }

/// Radix Themes TextArea variants.
enum FortalTextAreaVariant { classic, surface, soft }

/// Fortal recipe for [RemixTextArea].
@MixWidget(target: RemixTextArea.new)
TextFieldStyler fortalTextAreaStyle({
  FortalTextAreaVariant variant = .surface,
  FortalTextAreaSize size = .size2,
}) {
  final metrics = _fortalTextAreaMetrics(size);
  final base = _fortalTextInputBaseStyle(
    container: BoxStyler()
        .minHeight(metrics.minHeight)
        .paddingOnly(horizontal: metrics.paddingX, vertical: metrics.paddingY)
        .borderRadiusAll(metrics.radius)
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
