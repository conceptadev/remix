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
        trackEffects: RemixBoxEffectsMix(
          behindContent: _fortalSwitchLayer(),
          overContent: _fortalSwitchLayer(),
        ),
      )
      .thumbColor(Colors.white)
      .onFocused(
        RemixSwitchStyler().trackEffects(
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
}

RemixSwitchStyler _fortalSwitchClassicStyler(
  FortalSwitchSize size, {
  required bool highContrast,
}) {
  return _fortalSwitchBaseStyler(size)
      .trackColor(FortalTokens.grayA4())
      .trackEffects(
        RemixBoxEffectsMix(
          behindContent: _fortalSwitchLayer(shadowToken: FortalTokens.shadow1),
        ),
      )
      .thumb(
        _fortalSwitchThumbStyler(selected: false, highContrast: highContrast),
      )
      .onSelected(
        RemixSwitchStyler()
            .trackColor(
              highContrast
                  ? FortalTokens.accent12()
                  : FortalTokens.accentTrack(),
            )
            .trackEffects(
              RemixBoxEffectsMix(
                behindContent: _fortalSwitchLayer(
                  shadows: [
                    RemixBoxShadowMix(
                      kind: .inset,
                      color: FortalTokens.grayA3(),
                      spreadRadius: 1,
                    ),
                    RemixBoxShadowMix(
                      kind: .inset,
                      color: highContrast
                          ? FortalTokens.blackA2()
                          : FortalTokens.accentA4(),
                      spreadRadius: 1,
                    ),
                    RemixBoxShadowMix(
                      kind: .inset,
                      color: FortalTokens.blackA2(),
                      offset: const Offset(0, 1.5),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
            )
            .thumb(
              _fortalSwitchThumbStyler(
                selected: true,
                highContrast: highContrast,
              ),
            ),
      )
      .onPressed(
        RemixSwitchStyler()
            .trackColor(FortalTokens.grayA5())
            .trackEffects(
              RemixBoxEffectsMix(behindContent: _fortalSwitchLayer()),
            ),
      )
      .onDisabled(_fortalSwitchDisabledStyler(classic: true));
}

RemixSwitchStyler _fortalSwitchSurfaceStyler(
  FortalSwitchSize size, {
  required bool highContrast,
}) {
  return _fortalSwitchBaseStyler(size)
      .trackColor(FortalTokens.grayA3())
      .trackEffects(RemixBoxEffectsMix(behindContent: _fortalSwitchLayer()))
      .trackEffects(
        RemixBoxEffectsMix(
          overContent: _fortalSwitchInsetRing(FortalTokens.grayA5()),
        ),
      )
      .thumb(
        _fortalSwitchThumbStyler(selected: false, highContrast: highContrast),
      )
      .onSelected(
        RemixSwitchStyler()
            .trackColor(
              highContrast
                  ? FortalTokens.accent12()
                  : FortalTokens.accentTrack(),
            )
            .trackEffects(
              RemixBoxEffectsMix(behindContent: _fortalSwitchLayer()),
            )
            .thumb(
              _fortalSwitchThumbStyler(
                selected: true,
                highContrast: highContrast,
              ),
            ),
      )
      .onPressed(
        RemixSwitchStyler()
            .trackColor(FortalTokens.grayA4())
            .trackEffects(
              RemixBoxEffectsMix(behindContent: _fortalSwitchLayer()),
            ),
      )
      .onDisabled(_fortalSwitchDisabledStyler());
}

RemixSwitchStyler _fortalSwitchSoftStyler(
  FortalSwitchSize size, {
  required bool highContrast,
}) {
  return _fortalSwitchBaseStyler(size)
      .trackColor(FortalTokens.grayA3())
      .trackEffects(RemixBoxEffectsMix(behindContent: _fortalSwitchLayer()))
      .thumb(_fortalSwitchSoftThumbStyler(false))
      .onSelected(
        RemixSwitchStyler()
            .trackColor(
              highContrast ? FortalTokens.accentA6() : FortalTokens.accentA4(),
            )
            .trackEffects(
              RemixBoxEffectsMix(behindContent: _fortalSwitchLayer()),
            )
            .thumb(_fortalSwitchSoftThumbStyler(true)),
      )
      .onPressed(
        RemixSwitchStyler()
            .trackColor(FortalTokens.grayA4())
            .trackEffects(
              RemixBoxEffectsMix(behindContent: _fortalSwitchLayer()),
            ),
      )
      .onDisabled(_fortalSwitchDisabledStyler(soft: true));
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

RemixSwitchStyler _fortalSwitchDisabledStyler({
  bool classic = false,
  bool soft = false,
}) {
  final trackColor = switch ((classic, soft)) {
    (true, _) => FortalTokens.grayA5(),
    (_, true) => FortalTokens.grayA4(),
    _ => FortalTokens.grayA3(),
  };
  return RemixSwitchStyler()
      .trackColor(trackColor)
      .trackEffects(
        RemixBoxEffectsMix(
          behindContent: _fortalSwitchLayer(
            shadowToken: classic ? FortalTokens.shadow1 : null,
          ),
        ),
      )
      .trackEffects(
        RemixBoxEffectsMix(
          overContent: classic || soft
              ? _fortalSwitchLayer(shadows: const [])
              : _fortalSwitchInsetRing(FortalTokens.grayA3()),
        ),
      )
      .thumb(
        BoxStyler().boxShadows([
          BoxShadowMix(color: FortalTokens.grayA2(), spreadRadius: 1),
          BoxShadowMix(
            color: FortalTokens.blackA1(),
            offset: const Offset(0, 1),
            blurRadius: 3,
          ),
        ]),
      )
      .thumbColor(FortalTokens.gray2());
}

BoxStyler _fortalSwitchThumbStyler({
  required bool selected,
  required bool highContrast,
}) => BoxStyler().boxShadows(
  selected
      ? [
          BoxShadowMix(
            color: FortalTokens.blackA2(),
            offset: const Offset(0, 1),
            blurRadius: 3,
          ),
          BoxShadowMix(
            color: FortalTokens.blackA1(),
            offset: const Offset(0, 2),
            blurRadius: 4,
            spreadRadius: -1,
          ),
          BoxShadowMix(
            color: highContrast
                ? FortalTokens.blackA2()
                : FortalTokens.accentA4(),
            spreadRadius: 1,
          ),
          BoxShadowMix(
            color: FortalTokens.blackA2(),
            offset: const Offset(-1, 0),
            blurRadius: 1,
          ),
        ]
      : [
          BoxShadowMix(color: FortalTokens.blackA2(), spreadRadius: 1),
          BoxShadowMix(
            color: FortalTokens.blackA1(),
            offset: const Offset(0, 1),
            blurRadius: 3,
          ),
          BoxShadowMix(
            color: FortalTokens.blackA1(),
            offset: const Offset(0, 2),
            blurRadius: 4,
            spreadRadius: -1,
          ),
        ],
);

BoxStyler _fortalSwitchSoftThumbStyler(bool selected) =>
    BoxStyler().boxShadows([
      BoxShadowMix(color: FortalTokens.blackA1(), spreadRadius: 1),
      BoxShadowMix(
        color: selected ? FortalTokens.blackA2() : FortalTokens.blackA1(),
        offset: const Offset(0, 1),
        blurRadius: 3,
      ),
      BoxShadowMix(
        color: selected ? FortalTokens.accentA3() : FortalTokens.blackA1(),
        offset: const Offset(0, 1),
        blurRadius: 3,
      ),
      BoxShadowMix(
        color: selected ? FortalTokens.accentA3() : FortalTokens.blackA1(),
        offset: const Offset(0, 2),
        blurRadius: 4,
        spreadRadius: -1,
      ),
    ]);

RemixBoxEffectLayerMix _fortalSwitchInsetRing(Color color) =>
    _fortalSwitchLayer(
      shadows: [RemixBoxShadowMix(kind: .inset, color: color, spreadRadius: 1)],
    );

RemixBoxEffectLayerMix _fortalSwitchLayer({
  List<RemixBoxShadowMix>? shadows,
  RemixBoxShadowListToken? shadowToken,
}) => RemixBoxEffectLayerMix(shadows: shadows, shadowToken: shadowToken);

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
