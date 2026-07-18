part of 'progress.dart';

/// Fortal progress size presets.
enum FortalProgressSize { size1, size2, size3 }

/// Fortal progress color variants.
enum FortalProgressVariant { surface, soft }

/// Fortal-themed preset for [RemixProgress].
RemixProgressStyler fortalProgressStyler({
  FortalProgressVariant variant = .surface,
  FortalProgressSize size = .size2,
  bool highContrast = false,
}) {
  return switch (variant) {
    .surface => _fortalProgressSurfaceStyler(size, highContrast: highContrast),
    .soft => _fortalProgressSoftStyler(size, highContrast: highContrast),
  };
}

RemixProgressStyler _fortalProgressBaseStyler(FortalProgressSize size) {
  return RemixProgressStyler()
      .width(.infinity)
      .merge(_fortalProgressSizeStyler(size));
}

RemixProgressStyler _fortalProgressSurfaceStyler(
  FortalProgressSize size, {
  bool highContrast = false,
}) {
  final radius = switch (size) {
    .size1 => FortalTokens.radius1(),
    .size2 => FortalTokens.radius2(),
    .size3 => FortalTokens.radius3(),
  };

  return _fortalProgressBaseStyler(size)
      .foregroundDecoration(
        BoxDecorationMix()
            .border(
              BoxBorderMix.all(BorderSideMix().color(FortalTokens.grayA5())),
            )
            .borderRadius(BorderRadiusGeometryMix.all(radius)),
      )
      .track(BoxStyler().color(FortalTokens.gray3()).width(.infinity))
      .indicator(
        BoxStyler().color(
          highContrast
              ? FortalTokens.accent12()
              : FortalTokens.accentIndicator(),
        ),
      );
}

RemixProgressStyler _fortalProgressSoftStyler(
  FortalProgressSize size, {
  bool highContrast = false,
}) {
  return _fortalProgressBaseStyler(size)
      .track(BoxStyler().color(FortalTokens.gray4()).width(.infinity))
      .indicator(
        BoxStyler().color(
          highContrast ? FortalTokens.accent12() : FortalTokens.accent9(),
        ),
      );
}

RemixProgressStyler _fortalProgressSizeStyler(FortalProgressSize size) {
  return switch (size) {
    .size1 =>
      RemixProgressStyler()
          .height(4.0)
          .track(
            BoxStyler().height(4.0).borderRadiusAll(FortalTokens.radius1()),
          )
          .indicator(
            BoxStyler().height(4.0).borderRadiusAll(FortalTokens.radius1()),
          ),
    .size2 =>
      RemixProgressStyler()
          .height(8.0)
          .track(
            BoxStyler().height(8.0).borderRadiusAll(FortalTokens.radius2()),
          )
          .indicator(
            BoxStyler().height(8.0).borderRadiusAll(FortalTokens.radius2()),
          ),
    .size3 =>
      RemixProgressStyler()
          .height(12.0)
          .track(
            BoxStyler().height(12.0).borderRadiusAll(FortalTokens.radius3()),
          )
          .indicator(
            BoxStyler().height(12.0).borderRadiusAll(FortalTokens.radius3()),
          ),
  };
}

/// Fortal-themed preset for [RemixProgress].
class FortalProgress extends StatelessWidget {
  const FortalProgress({
    super.key,
    this.variant = .surface,
    this.size = .size2,
    this.color,
    this.radius,
    this.highContrast = false,
    required this.value,
  });

  const FortalProgress.surface({
    super.key,
    this.size = .size2,
    this.color,
    this.radius,
    this.highContrast = false,
    required this.value,
  }) : variant = FortalProgressVariant.surface;

  const FortalProgress.soft({
    super.key,
    this.size = .size2,
    this.color,
    this.radius,
    this.highContrast = false,
    required this.value,
  }) : variant = FortalProgressVariant.soft;

  final FortalProgressVariant variant;

  final FortalProgressSize size;

  /// Optional accent color override for this progress subtree.
  final FortalAccentColor? color;

  /// Optional radius override for this progress subtree.
  final FortalRadius? radius;

  /// Whether to use higher-contrast accent colors.
  final bool highContrast;

  final double value;

  @override
  Widget build(BuildContext context) {
    return FortalOverride(
      color: this.color,
      radius: this.radius,
      child: fortalProgressStyler(
        variant: this.variant,
        size: this.size,
        highContrast: this.highContrast,
      ).call(key: this.key, value: this.value),
    );
  }
}
