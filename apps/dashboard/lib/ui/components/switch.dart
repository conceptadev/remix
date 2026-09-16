import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';

part 'switch.g.dart';

/// Ui switch size presets.
enum UiSwitchSize {
  /// Compact switch.
  size1,

  /// Default switch.
  size2,

  /// Large switch.
  size3,
}

/// Ui switch color variants.
enum UiSwitchVariant {
  /// Raised treatment with Radix's classic shadows.
  classic,

  /// Surface treatment with a visible border.
  surface,

  /// Softer accent treatment.
  soft,
}

/// Ui-themed preset for [RemixSwitch].
@MixWidget(target: RemixSwitch.new)
SwitchStyler uiSwitchStyle({
  UiSwitchVariant variant = .surface,
  UiSwitchSize size = .size2,
  bool highContrast = false,
  SwitchStyler style = const SwitchStyler.create(),
}) {
  return (switch (variant) {
    .classic => _uiSwitchClassicStyler(size, highContrast: highContrast),
    .surface => _uiSwitchSurfaceStyler(size, highContrast: highContrast),
    .soft => _uiSwitchSoftStyler(size, highContrast: highContrast),
  }).merge(style);
}

SwitchStyler _uiSwitchBaseStyler(UiSwitchSize size) {
  final metrics = _uiSwitchMetrics(size);
  return SwitchStyler(
        container: .size(
          metrics.width,
          metrics.height,
        ).padding(.all(1)).borderRadius(.all(metrics.radius)),
        thumb: .size(
          metrics.thumbSize,
          metrics.thumbSize,
        ).borderRadius(.all(metrics.radius)),
        trackEffects: RemixBoxEffectsMix(
          behindContent: _uiSwitchLayer(),
          overContent: _uiSwitchLayer(),
        ),
      )
      .thumbColor(const Color(0xFFFFFFFF))
      .onFocusVisible(
        .trackEffects(
          RemixBoxEffectsMix(
            outline: BorderSideMix(
              color: UiTokens.focus8(),
              width: 2,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
            outlineOffset: 2,
          ),
        ),
      );
}

SwitchStyler _uiSwitchClassicStyler(
  UiSwitchSize size, {
  required bool highContrast,
}) {
  return _uiSwitchBaseStyler(size)
      .trackColor(UiTokens.grayA4())
      .trackEffects(
        RemixBoxEffectsMix.behindContent(
          _uiSwitchLayer(shadowToken: UiTokens.shadow1Layers),
        ),
      )
      .thumb(_uiSwitchThumbStyler(selected: false, highContrast: highContrast))
      .onSelected(
        SwitchStyler()
            .trackColor(
              highContrast ? UiTokens.accent12() : UiTokens.accentTrack(),
            )
            .trackEffects(
              RemixBoxEffectsMix.behindContent(
                _uiSwitchLayer(
                  shadows: [
                    RemixBoxShadowMix(
                      kind: .inset,
                      color: UiTokens.grayA3(),
                      spreadRadius: 1,
                    ),
                    RemixBoxShadowMix(
                      kind: .inset,
                      color: highContrast
                          ? UiTokens.blackA2()
                          : UiTokens.accentA4(),
                      spreadRadius: 1,
                    ),
                    RemixBoxShadowMix(
                      kind: .inset,
                      color: UiTokens.blackA2(),
                      offset: const Offset(0, 1.5),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
            )
            .thumb(
              _uiSwitchThumbStyler(selected: true, highContrast: highContrast),
            ),
      )
      .onPressed(
        SwitchStyler()
            .trackColor(UiTokens.grayA5())
            .trackEffects(RemixBoxEffectsMix.behindContent(_uiSwitchLayer())),
      )
      .onDisabled(_uiSwitchDisabledStyler(classic: true));
}

SwitchStyler _uiSwitchSurfaceStyler(
  UiSwitchSize size, {
  required bool highContrast,
}) {
  return _uiSwitchBaseStyler(size)
      .trackColor(UiTokens.grayA3())
      .trackEffects(RemixBoxEffectsMix.behindContent(_uiSwitchLayer()))
      .trackEffects(
        RemixBoxEffectsMix.overContent(_uiSwitchInsetRing(UiTokens.grayA5())),
      )
      .thumb(_uiSwitchThumbStyler(selected: false, highContrast: highContrast))
      .onSelected(
        SwitchStyler()
            .trackColor(
              highContrast ? UiTokens.accent12() : UiTokens.accentTrack(),
            )
            .trackEffects(RemixBoxEffectsMix.behindContent(_uiSwitchLayer()))
            .thumb(
              _uiSwitchThumbStyler(selected: true, highContrast: highContrast),
            ),
      )
      .onPressed(
        SwitchStyler()
            .trackColor(UiTokens.grayA4())
            .trackEffects(RemixBoxEffectsMix.behindContent(_uiSwitchLayer())),
      )
      .onDisabled(_uiSwitchDisabledStyler());
}

SwitchStyler _uiSwitchSoftStyler(
  UiSwitchSize size, {
  required bool highContrast,
}) {
  return _uiSwitchBaseStyler(size)
      .trackColor(UiTokens.grayA3())
      .trackEffects(RemixBoxEffectsMix.behindContent(_uiSwitchLayer()))
      .thumb(_uiSwitchSoftThumbStyler(false))
      .onSelected(
        SwitchStyler()
            .trackColor(
              highContrast ? UiTokens.accentA6() : UiTokens.accentA4(),
            )
            .trackEffects(RemixBoxEffectsMix.behindContent(_uiSwitchLayer()))
            .thumb(_uiSwitchSoftThumbStyler(true)),
      )
      .onPressed(
        SwitchStyler()
            .trackColor(UiTokens.grayA4())
            .trackEffects(RemixBoxEffectsMix.behindContent(_uiSwitchLayer())),
      )
      .onDisabled(_uiSwitchDisabledStyler(soft: true));
}

({double width, double height, double thumbSize, Radius radius})
_uiSwitchMetrics(UiSwitchSize size) {
  final height = switch (size) {
    .size1 => UiTokens.space4(),
    .size2 => UiTokens.switchHeight2(),
    .size3 => UiTokens.space5(),
  };
  final width = switch (size) {
    .size1 => UiTokens.switchWidth1(),
    .size2 => UiTokens.switchWidth2(),
    .size3 => UiTokens.switchWidth3(),
  };
  final thumbSize = switch (size) {
    .size1 => UiTokens.switchThumbSize1(),
    .size2 => UiTokens.switchThumbSize2(),
    .size3 => UiTokens.switchThumbSize3(),
  };
  final radius = switch (size) {
    .size1 => UiTokens.radius1OrThumb(),
    .size2 || .size3 => UiTokens.radius2OrThumb(),
  };
  return (width: width, height: height, thumbSize: thumbSize, radius: radius);
}

SwitchStyler _uiSwitchDisabledStyler({
  bool classic = false,
  bool soft = false,
}) {
  final trackColor = switch ((classic, soft)) {
    (true, _) => UiTokens.grayA5(),
    (_, true) => UiTokens.grayA4(),
    _ => UiTokens.grayA3(),
  };
  return SwitchStyler()
      .trackColor(trackColor)
      .trackEffects(
        RemixBoxEffectsMix.behindContent(
          _uiSwitchLayer(shadowToken: classic ? UiTokens.shadow1Layers : null),
        ),
      )
      .trackEffects(
        RemixBoxEffectsMix.overContent(
          classic || soft
              ? _uiSwitchLayer(shadows: const [])
              : _uiSwitchInsetRing(UiTokens.grayA3()),
        ),
      )
      .thumb(
        BoxStyler().decoration(
          .boxShadow([
            BoxShadowMix(color: UiTokens.grayA2(), spreadRadius: 1),
            BoxShadowMix(
              color: UiTokens.blackA1(),
              offset: const Offset(0, 1),
              blurRadius: 3,
            ),
          ]),
        ),
      )
      .thumbColor(UiTokens.gray2());
}

BoxStyler _uiSwitchThumbStyler({
  required bool selected,
  required bool highContrast,
}) => BoxStyler().decoration(
  .boxShadow(
    selected
        ? [
            BoxShadowMix(
              color: UiTokens.blackA2(),
              offset: const Offset(0, 1),
              blurRadius: 3,
            ),
            BoxShadowMix(
              color: UiTokens.blackA1(),
              offset: const Offset(0, 2),
              blurRadius: 4,
              spreadRadius: -1,
            ),
            BoxShadowMix(
              color: highContrast ? UiTokens.blackA2() : UiTokens.accentA4(),
              spreadRadius: 1,
            ),
            BoxShadowMix(
              color: UiTokens.blackA2(),
              offset: const Offset(-1, 0),
              blurRadius: 1,
            ),
          ]
        : [
            BoxShadowMix(color: UiTokens.blackA2(), spreadRadius: 1),
            BoxShadowMix(
              color: UiTokens.blackA1(),
              offset: const Offset(0, 1),
              blurRadius: 3,
            ),
            BoxShadowMix(
              color: UiTokens.blackA1(),
              offset: const Offset(0, 2),
              blurRadius: 4,
              spreadRadius: -1,
            ),
          ],
  ),
);

BoxStyler _uiSwitchSoftThumbStyler(bool selected) => BoxStyler().decoration(
  .boxShadow([
    BoxShadowMix(color: UiTokens.blackA1(), spreadRadius: 1),
    BoxShadowMix(
      color: selected ? UiTokens.blackA2() : UiTokens.blackA1(),
      offset: const Offset(0, 1),
      blurRadius: 3,
    ),
    BoxShadowMix(
      color: selected ? UiTokens.accentA3() : UiTokens.blackA1(),
      offset: const Offset(0, 1),
      blurRadius: 3,
    ),
    BoxShadowMix(
      color: selected ? UiTokens.accentA3() : UiTokens.blackA1(),
      offset: const Offset(0, 2),
      blurRadius: 4,
      spreadRadius: -1,
    ),
  ]),
);

RemixBoxEffectLayerMix _uiSwitchInsetRing(Color color) => _uiSwitchLayer(
  shadows: [RemixBoxShadowMix(kind: .inset, color: color, spreadRadius: 1)],
);

RemixBoxEffectLayerMix _uiSwitchLayer({
  List<RemixBoxShadowMix>? shadows,
  RemixBoxShadowListToken? shadowToken,
}) => RemixBoxEffectLayerMix(shadows: shadows, shadowToken: shadowToken);
