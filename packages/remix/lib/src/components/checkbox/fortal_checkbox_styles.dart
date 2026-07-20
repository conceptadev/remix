part of 'checkbox.dart';

/// Radix Themes Checkbox size presets.
enum FortalCheckboxSize { size1, size2, size3 }

/// Radix Themes Checkbox variants.
enum FortalCheckboxVariant { classic, surface, soft }

/// Fortal recipe for [RemixCheckbox].
RemixCheckboxStyler fortalCheckboxStyler({
  FortalCheckboxVariant variant = .surface,
  FortalCheckboxSize size = .size2,
  bool highContrast = false,
}) {
  final metrics = _fortalCheckboxMetrics(size);
  final base =
      RemixCheckboxStyler(
        container: BoxStyler()
            .size(metrics.size, metrics.size)
            .alignment(.center)
            .borderRadiusAll(metrics.radius),
        indicator: IconStyler().size(metrics.indicatorSize),
        surface: _fortalCheckboxLayer(radius: metrics.radius),
        overlay: _fortalCheckboxLayer(radius: metrics.radius),
      ).onFocused(
        RemixCheckboxStyler().overlay(
          _fortalCheckboxLayer(
            radius: metrics.radius,
            outlineColor: FortalTokens.focus8(),
            outlineWidth: 2,
            outlineOffset: 2,
          ),
        ),
      );

  return switch (variant) {
    .classic => _fortalCheckboxClassic(base, metrics.radius, highContrast),
    .surface => _fortalCheckboxSurface(base, metrics.radius, highContrast),
    .soft => _fortalCheckboxSoft(base, metrics.radius, highContrast),
  };
}

({double size, double indicatorSize, Radius radius}) _fortalCheckboxMetrics(
  FortalCheckboxSize size,
) => switch (size) {
  .size1 => (
    size: FortalTokens.checkboxSize1(),
    indicatorSize: FortalTokens.checkboxIndicatorSize1(),
    radius: FortalTokens.checkboxRadius1(),
  ),
  .size2 => (
    size: FortalTokens.space4(),
    indicatorSize: FortalTokens.checkboxIndicatorSize2(),
    radius: FortalTokens.radius1(),
  ),
  .size3 => (
    size: FortalTokens.checkboxSize3(),
    indicatorSize: FortalTokens.checkboxIndicatorSize3(),
    radius: FortalTokens.checkboxRadius3(),
  ),
};

RemixCheckboxStyler _fortalCheckboxSurface(
  RemixCheckboxStyler base,
  Radius radius,
  bool highContrast,
) {
  final selected = RemixCheckboxStyler()
      .surface(
        _fortalCheckboxLayer(
          radius: radius,
          color: highContrast
              ? FortalTokens.accent12()
              : FortalTokens.accentIndicator(),
        ),
      )
      .overlay(_fortalCheckboxLayer(radius: radius, shadows: const []))
      .indicatorColor(
        highContrast ? FortalTokens.accent1() : FortalTokens.accentContrast(),
      );

  return base
      .surface(
        _fortalCheckboxLayer(
          radius: radius,
          color: FortalTokens.colorSurface(),
        ),
      )
      .overlay(_fortalCheckboxInsetRing(radius, FortalTokens.grayA7()))
      .onSelected(selected)
      .onIndeterminate(selected)
      .onDisabled(
        RemixCheckboxStyler()
            .surface(
              _fortalCheckboxLayer(radius: radius, color: Colors.transparent),
            )
            .overlay(_fortalCheckboxInsetRing(radius, FortalTokens.grayA6()))
            .indicatorColor(FortalTokens.grayA8()),
      );
}

RemixCheckboxStyler _fortalCheckboxClassic(
  RemixCheckboxStyler base,
  Radius radius,
  bool highContrast,
) {
  final selected = RemixCheckboxStyler()
      .surface(
        _fortalCheckboxLayer(
          radius: radius,
          color: highContrast
              ? FortalTokens.accent12()
              : FortalTokens.accentIndicator(),
          gradients: [
            RemixLinearGradientMix(
              colors: [
                FortalTokens.whiteA3(),
                Colors.transparent,
                FortalTokens.blackA1(),
              ],
            ),
          ],
          shadows: [
            RemixPaintShadowMix(
              kind: .inset,
              color: FortalTokens.whiteA4(),
              offset: const Offset(0, 0.5),
              blurRadius: 0.5,
            ),
            RemixPaintShadowMix(
              kind: .inset,
              color: FortalTokens.blackA4(),
              offset: const Offset(0, -0.5),
              blurRadius: 0.5,
            ),
          ],
        ),
      )
      .overlay(_fortalCheckboxLayer(radius: radius, shadows: const []))
      .indicatorColor(
        highContrast ? FortalTokens.accent1() : FortalTokens.accentContrast(),
      );

  return base
      .surface(
        _fortalCheckboxLayer(
          radius: radius,
          color: FortalTokens.colorSurface(),
          shadowToken: FortalTokens.shadow1,
        ),
      )
      .overlay(_fortalCheckboxInsetRing(radius, FortalTokens.grayA3()))
      .onSelected(selected)
      .onIndeterminate(selected)
      .onDisabled(
        RemixCheckboxStyler()
            .surface(
              _fortalCheckboxLayer(
                radius: radius,
                color: Colors.transparent,
                gradients: const [],
                shadowToken: FortalTokens.shadow1,
              ),
            )
            .overlay(_fortalCheckboxLayer(radius: radius, shadows: const []))
            .indicatorColor(FortalTokens.grayA8()),
      );
}

RemixCheckboxStyler _fortalCheckboxSoft(
  RemixCheckboxStyler base,
  Radius radius,
  bool highContrast,
) {
  final selected = RemixCheckboxStyler().indicatorColor(
    highContrast ? FortalTokens.accent12() : FortalTokens.accentA11(),
  );

  return base
      .surface(
        _fortalCheckboxLayer(radius: radius, color: FortalTokens.accentA5()),
      )
      .onSelected(selected)
      .onIndeterminate(selected)
      .onDisabled(
        RemixCheckboxStyler()
            .surface(
              _fortalCheckboxLayer(radius: radius, color: Colors.transparent),
            )
            .indicatorColor(FortalTokens.grayA8()),
      );
}

RemixSurfaceLayerMix _fortalCheckboxInsetRing(Radius radius, Color color) =>
    _fortalCheckboxLayer(
      radius: radius,
      shadows: [
        RemixPaintShadowMix(kind: .inset, color: color, spreadRadius: 1),
      ],
    );

RemixSurfaceLayerMix _fortalCheckboxLayer({
  required Radius radius,
  Color? color,
  List<RemixLinearGradientMix>? gradients,
  List<RemixPaintShadowMix>? shadows,
  RemixPaintShadowListToken? shadowToken,
  Color? outlineColor,
  double? outlineWidth,
  double? outlineOffset,
}) => RemixSurfaceLayerMix(
  color: color,
  gradients: gradients,
  shadows: shadows,
  shadowToken: shadowToken,
  borderRadius: BorderRadiusMix.all(radius),
  outlineColor: outlineColor,
  outlineWidth: outlineWidth,
  outlineOffset: outlineOffset,
);

/// Fortal Checkbox with the Radix size, variant, and override contract.
class FortalCheckbox extends StatelessWidget {
  const FortalCheckbox({
    super.key,
    this.variant = .surface,
    this.size = .size2,
    this.color,
    this.highContrast = false,
    required this.selected,
    this.onChanged,
    this.enabled = true,
    this.tristate = false,
    this.focusNode,
    this.autofocus = false,
    this.enableFeedback = true,
    this.semanticLabel,
    this.mouseCursor = SystemMouseCursors.click,
  });

  final FortalCheckboxVariant variant;
  final FortalCheckboxSize size;
  final FortalAccentColor? color;
  final bool highContrast;
  final bool? selected;
  final ValueChanged<bool?>? onChanged;
  final bool enabled;
  final bool tristate;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool enableFeedback;
  final String? semanticLabel;
  final MouseCursor mouseCursor;

  @override
  Widget build(BuildContext context) => FortalComponentOverride(
    color: color,
    child:
        fortalCheckboxStyler(
          variant: variant,
          size: size,
          highContrast: highContrast,
        ).call(
          key: key,
          selected: selected,
          onChanged: onChanged,
          enabled: enabled,
          tristate: tristate,
          indicatorBuilder: _buildFortalCheckboxIndicator,
          focusNode: focusNode,
          autofocus: autofocus,
          enableFeedback: enableFeedback,
          semanticLabel: semanticLabel,
          mouseCursor: mouseCursor,
        ),
  );
}

Widget _buildFortalCheckboxIndicator(
  BuildContext context,
  IconSpec spec,
  bool? value,
) {
  final color = spec.color ?? IconTheme.of(context).color ?? Colors.black;
  final size = spec.size ?? IconTheme.of(context).size ?? 9;
  return SizedBox.square(
    dimension: size,
    child: CustomPaint(
      painter: _FortalCheckboxIndicatorPainter(
        color: color,
        indeterminate: value == null,
      ),
    ),
  );
}

class _FortalCheckboxIndicatorPainter extends CustomPainter {
  const _FortalCheckboxIndicatorPainter({
    required this.color,
    required this.indeterminate,
  });

  final Color color;
  final bool indeterminate;

  @override
  void paint(Canvas canvas, Size size) {
    final scaleX = size.width / 9;
    final scaleY = size.height / 9;
    canvas.save();
    canvas.scale(scaleX, scaleY);
    final path = indeterminate ? _dividerPath() : _checkPath();
    canvas.drawPath(path, Paint()..color = color);
    canvas.restore();
  }

  Path _dividerPath() => Path()
    ..moveTo(0.75, 4.5)
    ..cubicTo(0.75, 4.08579, 1.08579, 3.75, 1.5, 3.75)
    ..lineTo(7.5, 3.75)
    ..cubicTo(7.91421, 3.75, 8.25, 4.08579, 8.25, 4.5)
    ..cubicTo(8.25, 4.91421, 7.91421, 5.25, 7.5, 5.25)
    ..lineTo(1.5, 5.25)
    ..cubicTo(1.08579, 5.25, 0.75, 4.91421, 0.75, 4.5)
    ..close();

  Path _checkPath() => Path()
    ..moveTo(8.53547, 0.62293)
    ..cubicTo(8.88226, 0.849446, 8.97976, 1.3142, 8.75325, 1.66099)
    ..lineTo(4.5083, 8.1599)
    ..cubicTo(4.38833, 8.34356, 4.19397, 8.4655, 3.9764, 8.49358)
    ..cubicTo(3.75883, 8.52167, 3.53987, 8.45309, 3.3772, 8.30591)
    ..lineTo(0.616113, 5.80777)
    ..cubicTo(0.308959, 5.52987, 0.285246, 5.05559, 0.563148, 4.74844)
    ..cubicTo(0.84105, 4.44128, 1.31533, 4.41757, 1.62249, 4.69547)
    ..lineTo(3.73256, 6.60459)
    ..lineTo(7.49741, 0.840706)
    ..cubicTo(7.72393, 0.493916, 8.18868, 0.396414, 8.53547, 0.62293)
    ..close();

  @override
  bool shouldRepaint(_FortalCheckboxIndicatorPainter oldDelegate) =>
      color != oldDelegate.color || indeterminate != oldDelegate.indeterminate;
}
