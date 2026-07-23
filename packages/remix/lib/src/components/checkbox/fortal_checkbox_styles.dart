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
        container: .size(
          metrics.size,
          metrics.size,
        ).alignment(.center).borderRadiusAll(metrics.radius),
        indicator: .size(metrics.indicatorSize),
        containerEffects: RemixBoxEffectsMix(
          behindContent: _fortalCheckboxLayer(),
          overContent: _fortalCheckboxLayer(),
        ),
      ).onFocused(
        .containerEffects(
          RemixBoxEffectsMix(
            outline: BorderSideMix(
              color: FortalTokens.focus8(),
              width: 2,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
            outlineOffset: 2,
          ),
        ),
      );

  return switch (variant) {
    .classic => _fortalCheckboxClassic(base, highContrast),
    .surface => _fortalCheckboxSurface(base, highContrast),
    .soft => _fortalCheckboxSoft(base, highContrast),
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
  bool highContrast,
) {
  final selected = RemixCheckboxStyler()
      .color(
        highContrast ? FortalTokens.accent12() : FortalTokens.accentIndicator(),
      )
      .containerEffects(
        RemixBoxEffectsMix(behindContent: _fortalCheckboxLayer()),
      )
      .containerEffects(
        RemixBoxEffectsMix(
          overContent: _fortalCheckboxLayer(shadows: const []),
        ),
      )
      .indicatorColor(
        highContrast ? FortalTokens.accent1() : FortalTokens.accentContrast(),
      );

  return base
      .color(FortalTokens.colorSurface())
      .containerEffects(
        RemixBoxEffectsMix(behindContent: _fortalCheckboxLayer()),
      )
      .containerEffects(
        RemixBoxEffectsMix(
          overContent: _fortalCheckboxInsetRing(FortalTokens.grayA7()),
        ),
      )
      .onSelected(selected)
      .onIndeterminate(selected)
      .onDisabled(
        .color(FortalTokens.grayA3())
            .containerEffects(
              RemixBoxEffectsMix(behindContent: _fortalCheckboxLayer()),
            )
            .containerEffects(
              RemixBoxEffectsMix(
                overContent: _fortalCheckboxInsetRing(FortalTokens.grayA6()),
              ),
            )
            .indicatorColor(FortalTokens.grayA8()),
      );
}

RemixCheckboxStyler _fortalCheckboxClassic(
  RemixCheckboxStyler base,
  bool highContrast,
) {
  final selected = RemixCheckboxStyler()
      .color(
        highContrast ? FortalTokens.accent12() : FortalTokens.accentIndicator(),
      )
      .containerEffects(
        RemixBoxEffectsMix(
          behindContent: _fortalCheckboxLayer(
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
              RemixBoxShadowMix(
                kind: .inset,
                color: FortalTokens.whiteA4(),
                offset: const Offset(0, 0.5),
                blurRadius: 0.5,
              ),
              RemixBoxShadowMix(
                kind: .inset,
                color: FortalTokens.blackA4(),
                offset: const Offset(0, -0.5),
                blurRadius: 0.5,
              ),
            ],
          ),
        ),
      )
      .containerEffects(
        RemixBoxEffectsMix(
          overContent: _fortalCheckboxLayer(shadows: const []),
        ),
      )
      .indicatorColor(
        highContrast ? FortalTokens.accent1() : FortalTokens.accentContrast(),
      );

  return base
      .color(FortalTokens.colorSurface())
      .containerEffects(
        RemixBoxEffectsMix(
          behindContent: _fortalCheckboxLayer(
            shadowToken: FortalTokens.shadow1Layers,
          ),
        ),
      )
      .containerEffects(
        RemixBoxEffectsMix(
          overContent: _fortalCheckboxInsetRing(FortalTokens.grayA3()),
        ),
      )
      .onSelected(selected)
      .onIndeterminate(selected)
      .onDisabled(
        .color(FortalTokens.grayA3())
            .containerEffects(
              RemixBoxEffectsMix(
                behindContent: _fortalCheckboxLayer(
                  gradients: const [],
                  shadowToken: FortalTokens.shadow1Layers,
                ),
              ),
            )
            .containerEffects(
              RemixBoxEffectsMix(
                overContent: _fortalCheckboxLayer(shadows: const []),
              ),
            )
            .indicatorColor(FortalTokens.grayA8()),
      );
}

RemixCheckboxStyler _fortalCheckboxSoft(
  RemixCheckboxStyler base,
  bool highContrast,
) {
  final selected = RemixCheckboxStyler().indicatorColor(
    highContrast ? FortalTokens.accent12() : FortalTokens.accentA11(),
  );

  return base
      .color(FortalTokens.accentA5())
      .containerEffects(
        RemixBoxEffectsMix(behindContent: _fortalCheckboxLayer()),
      )
      .onSelected(selected)
      .onIndeterminate(selected)
      .onDisabled(
        .color(FortalTokens.grayA3())
            .containerEffects(
              RemixBoxEffectsMix(behindContent: _fortalCheckboxLayer()),
            )
            .indicatorColor(FortalTokens.grayA8()),
      );
}

RemixBoxEffectLayerMix _fortalCheckboxInsetRing(Color color) =>
    _fortalCheckboxLayer(
      shadows: [RemixBoxShadowMix(kind: .inset, color: color, spreadRadius: 1)],
    );

RemixBoxEffectLayerMix _fortalCheckboxLayer({
  List<RemixLinearGradientMix>? gradients,
  List<RemixBoxShadowMix>? shadows,
  RemixBoxShadowListToken? shadowToken,
}) => RemixBoxEffectLayerMix(
  gradients: gradients,
  shadows: shadows,
  shadowToken: shadowToken,
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
    this.checkedIcon = Icons.check_rounded,
    this.uncheckedIcon,
    this.indeterminateIcon = Icons.horizontal_rule,
    this.focusNode,
    this.autofocus = false,
    this.enableFeedback = true,
    this.semanticLabel,
    this.mouseCursor = SystemMouseCursors.click,
  });

  const FortalCheckbox.classic({
    super.key,
    this.size = .size2,
    this.color,
    this.highContrast = false,
    required this.selected,
    this.onChanged,
    this.enabled = true,
    this.tristate = false,
    this.checkedIcon = Icons.check_rounded,
    this.uncheckedIcon,
    this.indeterminateIcon = Icons.horizontal_rule,
    this.focusNode,
    this.autofocus = false,
    this.enableFeedback = true,
    this.semanticLabel,
    this.mouseCursor = SystemMouseCursors.click,
  }) : variant = .classic;

  const FortalCheckbox.surface({
    super.key,
    this.size = .size2,
    this.color,
    this.highContrast = false,
    required this.selected,
    this.onChanged,
    this.enabled = true,
    this.tristate = false,
    this.checkedIcon = Icons.check_rounded,
    this.uncheckedIcon,
    this.indeterminateIcon = Icons.horizontal_rule,
    this.focusNode,
    this.autofocus = false,
    this.enableFeedback = true,
    this.semanticLabel,
    this.mouseCursor = SystemMouseCursors.click,
  }) : variant = .surface;

  const FortalCheckbox.soft({
    super.key,
    this.size = .size2,
    this.color,
    this.highContrast = false,
    required this.selected,
    this.onChanged,
    this.enabled = true,
    this.tristate = false,
    this.checkedIcon = Icons.check_rounded,
    this.uncheckedIcon,
    this.indeterminateIcon = Icons.horizontal_rule,
    this.focusNode,
    this.autofocus = false,
    this.enableFeedback = true,
    this.semanticLabel,
    this.mouseCursor = SystemMouseCursors.click,
  }) : variant = .soft;

  final FortalCheckboxVariant variant;
  final FortalCheckboxSize size;
  final FortalAccentColor? color;
  final bool highContrast;
  final bool? selected;
  final ValueChanged<bool?>? onChanged;
  final bool enabled;
  final bool tristate;
  final IconData checkedIcon;
  final IconData? uncheckedIcon;
  final IconData indeterminateIcon;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool enableFeedback;
  final String? semanticLabel;
  final MouseCursor mouseCursor;

  bool get _usesFortalIndicator =>
      checkedIcon == Icons.check_rounded &&
      uncheckedIcon == null &&
      indeterminateIcon == Icons.horizontal_rule;

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
          checkedIcon: checkedIcon,
          uncheckedIcon: uncheckedIcon,
          indeterminateIcon: indeterminateIcon,
          indicatorBuilder: _usesFortalIndicator
              ? _buildFortalCheckboxIndicator
              : null,
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
