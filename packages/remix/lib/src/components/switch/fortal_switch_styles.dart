part of 'switch.dart';

/// Fortal switch size presets.
enum FortalSwitchSize {
  /// Compact switch.
  size1,

  /// Default switch.
  size2,

  /// Large switch.
  size3,
}

/// Fortal switch color variants.
enum FortalSwitchVariant {
  /// Raised treatment with Radix's classic shadows.
  classic,

  /// Surface treatment with a visible border.
  surface,

  /// Softer accent treatment.
  soft,
}

/// Fortal-themed preset for [RemixSwitch].
RemixSwitchStyler fortalSwitchStyler({
  FortalSwitchVariant variant = .surface,
  FortalSwitchSize size = .size2,
  bool highContrast = false,
}) {
  return switch (variant) {
    .classic => _fortalSwitchClassicStyler(size, highContrast: highContrast),
    .surface => _fortalSwitchSurfaceStyler(size, highContrast: highContrast),
    .soft => _fortalSwitchSoftStyler(size, highContrast: highContrast),
  };
}

RemixSwitchStyler _fortalSwitchBaseStyler(FortalSwitchSize size) {
  final metrics = _fortalSwitchMetrics(size);
  return RemixSwitchStyler(
    container: BoxStyler()
        .size(metrics.width, metrics.height)
        .paddingAll(1)
        .borderRadiusAll(metrics.radius),
    thumb: BoxStyler()
        .size(metrics.thumbSize, metrics.thumbSize)
        .borderRadiusAll(metrics.radius),
    surface: _fortalSwitchLayer(radius: metrics.radius),
    overlay: _fortalSwitchLayer(radius: metrics.radius),
    thumbSurface: _fortalSwitchLayer(
      radius: metrics.radius,
      color: Colors.white,
    ),
    thumbOverlay: _fortalSwitchLayer(radius: metrics.radius),
  ).onFocused(
    RemixSwitchStyler().overlay(
      _fortalSwitchLayer(
        radius: metrics.radius,
        outlineColor: FortalTokens.focus8(),
        outlineWidth: 2,
        outlineOffset: 2,
      ),
    ),
  );
}

RemixSwitchStyler _fortalSwitchClassicStyler(
  FortalSwitchSize size, {
  required bool highContrast,
}) {
  final metrics = _fortalSwitchMetrics(size);
  return _fortalSwitchBaseStyler(size)
      .surface(
        _fortalSwitchLayer(
          radius: metrics.radius,
          color: FortalTokens.grayA4(),
          shadowToken: FortalTokens.shadow1,
        ),
      )
      .thumbSurface(
        _fortalSwitchThumbLayer(
          metrics.radius,
          selected: false,
          highContrast: highContrast,
        ),
      )
      .onSelected(
        RemixSwitchStyler()
            .surface(
              _fortalSwitchLayer(
                radius: metrics.radius,
                color: highContrast
                    ? FortalTokens.accent12()
                    : FortalTokens.accentTrack(),
                shadows: [
                  RemixPaintShadowMix(
                    kind: .inset,
                    color: FortalTokens.grayA3(),
                    spreadRadius: 1,
                  ),
                  RemixPaintShadowMix(
                    kind: .inset,
                    color: highContrast
                        ? FortalTokens.blackA2()
                        : FortalTokens.accentA4(),
                    spreadRadius: 1,
                  ),
                  RemixPaintShadowMix(
                    kind: .inset,
                    color: FortalTokens.blackA2(),
                    offset: const Offset(0, 1.5),
                    blurRadius: 2,
                  ),
                ],
              ),
            )
            .thumbSurface(
              _fortalSwitchThumbLayer(
                metrics.radius,
                selected: true,
                highContrast: highContrast,
              ),
            ),
      )
      .onPressed(
        RemixSwitchStyler().surface(
          _fortalSwitchLayer(
            radius: metrics.radius,
            color: FortalTokens.grayA5(),
          ),
        ),
      )
      .onDisabled(_fortalSwitchDisabledStyler(metrics.radius, classic: true));
}

RemixSwitchStyler _fortalSwitchSurfaceStyler(
  FortalSwitchSize size, {
  required bool highContrast,
}) {
  final metrics = _fortalSwitchMetrics(size);
  return _fortalSwitchBaseStyler(size)
      .surface(
        _fortalSwitchLayer(
          radius: metrics.radius,
          color: FortalTokens.grayA3(),
        ),
      )
      .overlay(_fortalSwitchInsetRing(metrics.radius, FortalTokens.grayA5()))
      .thumbSurface(
        _fortalSwitchThumbLayer(
          metrics.radius,
          selected: false,
          highContrast: highContrast,
        ),
      )
      .onSelected(
        RemixSwitchStyler()
            .surface(
              _fortalSwitchLayer(
                radius: metrics.radius,
                color: highContrast
                    ? FortalTokens.accent12()
                    : FortalTokens.accentTrack(),
              ),
            )
            .thumbSurface(
              _fortalSwitchThumbLayer(
                metrics.radius,
                selected: true,
                highContrast: highContrast,
              ),
            ),
      )
      .onPressed(
        RemixSwitchStyler().surface(
          _fortalSwitchLayer(
            radius: metrics.radius,
            color: FortalTokens.grayA4(),
          ),
        ),
      )
      .onDisabled(_fortalSwitchDisabledStyler(metrics.radius));
}

RemixSwitchStyler _fortalSwitchSoftStyler(
  FortalSwitchSize size, {
  required bool highContrast,
}) {
  final metrics = _fortalSwitchMetrics(size);
  return _fortalSwitchBaseStyler(size)
      .surface(
        _fortalSwitchLayer(
          radius: metrics.radius,
          color: FortalTokens.grayA3(),
        ),
      )
      .thumbSurface(_fortalSwitchSoftThumbLayer(metrics.radius, false))
      .onSelected(
        RemixSwitchStyler()
            .surface(
              _fortalSwitchLayer(
                radius: metrics.radius,
                color: highContrast
                    ? FortalTokens.accentA6()
                    : FortalTokens.accentA4(),
              ),
            )
            .thumbSurface(_fortalSwitchSoftThumbLayer(metrics.radius, true)),
      )
      .onPressed(
        RemixSwitchStyler().surface(
          _fortalSwitchLayer(
            radius: metrics.radius,
            color: FortalTokens.grayA4(),
          ),
        ),
      )
      .onDisabled(_fortalSwitchDisabledStyler(metrics.radius, soft: true));
}

({double width, double height, double thumbSize, Radius radius})
_fortalSwitchMetrics(FortalSwitchSize size) {
  final height = switch (size) {
    .size1 => FortalTokens.space4(),
    .size2 => FortalTokens.switchHeight2(),
    .size3 => FortalTokens.space5(),
  };
  final width = switch (size) {
    .size1 => FortalTokens.switchWidth1(),
    .size2 => FortalTokens.switchWidth2(),
    .size3 => FortalTokens.switchWidth3(),
  };
  final thumbSize = switch (size) {
    .size1 => FortalTokens.switchThumbSize1(),
    .size2 => FortalTokens.switchThumbSize2(),
    .size3 => FortalTokens.switchThumbSize3(),
  };
  final radius = switch (size) {
    .size1 => FortalTokens.radius1OrThumb(),
    .size2 || .size3 => FortalTokens.radius2OrThumb(),
  };
  return (width: width, height: height, thumbSize: thumbSize, radius: radius);
}

RemixSwitchStyler _fortalSwitchDisabledStyler(
  Radius radius, {
  bool classic = false,
  bool soft = false,
}) => RemixSwitchStyler()
    .surface(
      _fortalSwitchLayer(
        radius: radius,
        color: classic
            ? FortalTokens.grayA5()
            : soft
            ? FortalTokens.grayA4()
            : FortalTokens.grayA3(),
        shadowToken: classic ? FortalTokens.shadow1 : null,
      ),
    )
    .overlay(
      classic || soft
          ? _fortalSwitchLayer(radius: radius, shadows: const [])
          : _fortalSwitchInsetRing(radius, FortalTokens.grayA3()),
    )
    .thumbSurface(
      _fortalSwitchLayer(
        radius: radius,
        color: FortalTokens.gray2(),
        shadows: [
          RemixPaintShadowMix(color: FortalTokens.grayA2(), spreadRadius: 1),
          RemixPaintShadowMix(
            color: FortalTokens.blackA1(),
            offset: const Offset(0, 1),
            blurRadius: 3,
          ),
        ],
      ),
    );

RemixSurfaceLayerMix _fortalSwitchThumbLayer(
  Radius radius, {
  required bool selected,
  required bool highContrast,
}) => _fortalSwitchLayer(
  radius: radius,
  color: Colors.white,
  shadows: selected
      ? [
          RemixPaintShadowMix(
            color: FortalTokens.blackA2(),
            offset: const Offset(0, 1),
            blurRadius: 3,
          ),
          RemixPaintShadowMix(
            color: FortalTokens.blackA1(),
            offset: const Offset(0, 2),
            blurRadius: 4,
            spreadRadius: -1,
          ),
          RemixPaintShadowMix(
            color: highContrast
                ? FortalTokens.blackA2()
                : FortalTokens.accentA4(),
            spreadRadius: 1,
          ),
          RemixPaintShadowMix(
            color: FortalTokens.blackA2(),
            offset: const Offset(-1, 0),
            blurRadius: 1,
          ),
        ]
      : [
          RemixPaintShadowMix(color: FortalTokens.blackA2(), spreadRadius: 1),
          RemixPaintShadowMix(
            color: FortalTokens.blackA1(),
            offset: const Offset(0, 1),
            blurRadius: 3,
          ),
          RemixPaintShadowMix(
            color: FortalTokens.blackA1(),
            offset: const Offset(0, 2),
            blurRadius: 4,
            spreadRadius: -1,
          ),
        ],
);

RemixSurfaceLayerMix _fortalSwitchSoftThumbLayer(
  Radius radius,
  bool selected,
) => _fortalSwitchLayer(
  radius: radius,
  color: Colors.white,
  shadows: [
    RemixPaintShadowMix(color: FortalTokens.blackA1(), spreadRadius: 1),
    RemixPaintShadowMix(
      color: selected ? FortalTokens.blackA2() : FortalTokens.blackA1(),
      offset: const Offset(0, 1),
      blurRadius: 3,
    ),
    RemixPaintShadowMix(
      color: selected ? FortalTokens.accentA3() : FortalTokens.blackA1(),
      offset: const Offset(0, 1),
      blurRadius: 3,
    ),
    RemixPaintShadowMix(
      color: selected ? FortalTokens.accentA3() : FortalTokens.blackA1(),
      offset: const Offset(0, 2),
      blurRadius: 4,
      spreadRadius: -1,
    ),
  ],
);

RemixSurfaceLayerMix _fortalSwitchInsetRing(Radius radius, Color color) =>
    _fortalSwitchLayer(
      radius: radius,
      shadows: [
        RemixPaintShadowMix(kind: .inset, color: color, spreadRadius: 1),
      ],
    );

RemixSurfaceLayerMix _fortalSwitchLayer({
  required Radius radius,
  Color? color,
  List<RemixPaintShadowMix>? shadows,
  RemixPaintShadowListToken? shadowToken,
  Color? outlineColor,
  double? outlineWidth,
  double? outlineOffset,
}) => RemixSurfaceLayerMix(
  color: color,
  shadows: shadows,
  shadowToken: shadowToken,
  borderRadius: BorderRadiusMix.all(radius),
  outlineColor: outlineColor,
  outlineWidth: outlineWidth,
  outlineOffset: outlineOffset,
);

/// Fortal-themed preset for [RemixSwitch].
class FortalSwitch extends StatelessWidget {
  const FortalSwitch({
    super.key,
    this.variant = .surface,
    this.size = .size2,
    this.color,
    this.radius,
    this.highContrast = false,
    required this.selected,
    this.onChanged,
    this.enabled = true,
    this.enableFeedback = true,
    this.focusNode,
    this.autofocus = false,
    this.semanticLabel,
    this.mouseCursor = SystemMouseCursors.click,
  });

  final FortalSwitchVariant variant;

  final FortalSwitchSize size;

  /// Optional accent color override for this switch subtree.
  final FortalAccentColor? color;

  /// Optional radius override for this switch subtree.
  final FortalRadius? radius;

  /// Whether to use higher-contrast accent colors.
  final bool highContrast;

  final bool selected;

  final ValueChanged<bool>? onChanged;

  final bool enabled;

  final bool enableFeedback;

  final FocusNode? focusNode;

  final bool autofocus;

  final String? semanticLabel;

  final MouseCursor mouseCursor;

  @override
  Widget build(BuildContext context) {
    return FortalComponentOverride(
      color: this.color,
      radius: this.radius,
      child:
          fortalSwitchStyler(
            variant: this.variant,
            size: this.size,
            highContrast: this.highContrast,
          ).call(
            key: this.key,
            selected: this.selected,
            onChanged: this.onChanged,
            enabled: this.enabled,
            enableFeedback: this.enableFeedback,
            focusNode: this.focusNode,
            autofocus: this.autofocus,
            semanticLabel: this.semanticLabel,
            mouseCursor: this.mouseCursor,
          ),
    );
  }
}
