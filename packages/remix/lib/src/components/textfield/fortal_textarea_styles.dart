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
  final metrics = _fortalTextAreaMetrics(size, bordered: variant != .soft);
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

class _FortalTextAreaMetrics {
  const _FortalTextAreaMetrics({
    required this.minHeight,
    required this.paddingX,
    required this.paddingY,
    required this.spacing,
    required this.radius,
    required this.text,
  });

  final double minHeight;
  final double paddingX;
  final double paddingY;
  final double spacing;
  final Radius radius;
  final TextStyleToken text;
}

_FortalTextAreaMetrics _fortalTextAreaMetrics(
  FortalTextAreaSize size, {
  required bool bordered,
}) => switch (size) {
  .size1 => _FortalTextAreaMetrics(
    minHeight: FortalTokens.space8(),
    paddingX: bordered
        ? FortalTokens.textFieldPadding1()
        : FortalTokens.selectSpace1Half(),
    paddingY: bordered
        ? FortalTokens.textAreaPaddingY1()
        : FortalTokens.space1(),
    spacing: FortalTokens.space2(),
    radius: FortalTokens.radius2(),
    text: FortalTokens.text1,
  ),
  .size2 => _FortalTextAreaMetrics(
    minHeight: FortalTokens.space9(),
    paddingX: bordered
        ? FortalTokens.textFieldPadding2()
        : FortalTokens.space2(),
    paddingY: bordered
        ? FortalTokens.textFieldPadding1()
        : FortalTokens.selectSpace1Half(),
    spacing: FortalTokens.space2(),
    radius: FortalTokens.radius2(),
    text: FortalTokens.text2,
  ),
  .size3 => _FortalTextAreaMetrics(
    minHeight: FortalTokens.textAreaMinHeight3(),
    paddingX: bordered
        ? FortalTokens.textFieldPadding3()
        : FortalTokens.space3(),
    paddingY: bordered
        ? FortalTokens.textFieldPadding2()
        : FortalTokens.space2(),
    spacing: FortalTokens.space3(),
    radius: FortalTokens.radius3(),
    text: FortalTokens.text3,
  ),
};
