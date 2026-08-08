import 'package:flutter/material.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../fortal/fortal.dart';

part 'icon_button.g.dart';

/// Radix Themes IconButton size presets.
enum FortalIconButtonSize { size1, size2, size3, size4 }

/// Radix Themes IconButton variants.
enum FortalIconButtonVariant { classic, solid, soft, surface, outline, ghost }

/// Fortal-themed IconButton with the Radix size, variant, and override contract.
@MixWidget(target: RemixIconButton.new)
IconButtonStyler fortalIconButtonStyle({
  FortalIconButtonVariant variant = .solid,
  FortalIconButtonSize size = .size2,
  bool highContrast = false,
}) {
  final index = size.index + 1;
  final base = _fortalIconButtonBaseStyler(variant, index);
  final focus = fortalFocusOutline(
    variant == .soft ? FortalTokens.accent8() : FortalTokens.focus8(),
    offset: variant == .classic || variant == .solid ? 2 : -1,
  );
  final disabledFocus = RemixBoxEffectsMix(
    outline: BorderSideMix(style: BorderStyle.none),
  );

  return switch (variant) {
        .classic => _fortalIconButtonClassic(
          base,
          size: index,
          highContrast: highContrast,
        ),
        .solid => _fortalIconButtonSolid(base, highContrast: highContrast),
        .soft => _fortalIconButtonSoft(base, highContrast: highContrast),
        .surface => _fortalIconButtonSurface(base, highContrast: highContrast),
        .outline => _fortalIconButtonOutline(base, highContrast: highContrast),
        .ghost => _fortalIconButtonGhost(base, highContrast: highContrast),
      }
      .onFocused(.containerEffects(focus))
      .onDisabled(.containerEffects(disabledFocus));
}

IconButtonStyler _fortalIconButtonBaseStyler(
  FortalIconButtonVariant variant,
  int size,
) {
  final metrics = fortalBaseButtonMetrics(size);
  var style = IconButtonStyler(
    container: .alignment(Alignment.center),
    icon: .size(_fortalIconButtonIconSize(size)),
    spinner: .size(metrics.spinnerSize)
        .opacity(0.65)
        .leafRadius(FortalTokens.radius1())
        .duration(const Duration(milliseconds: 800)),
  ).borderRadiusAll(metrics.radius);

  if (variant == .ghost) {
    final ghost = fortalIconButtonGhostMetrics(size);
    style = style.paddingAll(ghost.padding).marginAll(ghost.margin);
  } else {
    style = style.width(metrics.height).height(metrics.height);
  }
  return style;
}

double _fortalIconButtonIconSize(int size) => switch (size) {
  1 => FortalTokens.space3(),
  2 => FortalTokens.space4(),
  3 => FortalTokens.spinnerSize3(),
  4 => FortalTokens.space5(),
  _ => throw ArgumentError.value(size, 'size', 'Expected a size from 1 to 4.'),
};

IconButtonStyler _fortalIconButtonClassic(
  IconButtonStyler base, {
  required int size,
  required bool highContrast,
}) {
  final foreground = highContrast
      ? FortalTokens.gray1()
      : FortalTokens.accentContrast();
  return _fortalIconButtonForeground(base, foreground)
      .color(highContrast ? FortalTokens.accent12() : FortalTokens.accent9())
      .containerEffects(
        RemixBoxEffectsMix(
          behindContent: fortalClassicBaseButtonSurface(
            highContrast: highContrast,
          ),
        ),
      )
      .onHovered(
        .containerEffects(
          RemixBoxEffectsMix(
            behindContent: fortalClassicBaseButtonSurface(
              highContrast: highContrast,
              hovered: true,
            ),
          ),
        ).wrap(
          highContrast
              ? fortalModeAwareFilter(
                  light: const [
                    RemixCssColorFilterOperation.contrast(0.88),
                    RemixCssColorFilterOperation.saturate(1.1),
                    RemixCssColorFilterOperation.brightness(1.1),
                  ],
                  dark: const [
                    RemixCssColorFilterOperation.contrast(0.88),
                    RemixCssColorFilterOperation.saturate(1.3),
                    RemixCssColorFilterOperation.brightness(1.14),
                  ],
                )
              : fortalClearFilter(),
        ),
      )
      .onPressed(
        .containerEffects(
              RemixBoxEffectsMix(
                behindContent: fortalClassicBaseButtonSurface(
                  highContrast: highContrast,
                  pressed: true,
                ),
              ),
            )
            .paddingTop(size == 1 ? 1 : 2)
            .wrap(
              highContrast
                  ? fortalModeAwareFilter(
                      light: const [
                        RemixCssColorFilterOperation.contrast(0.82),
                        RemixCssColorFilterOperation.saturate(1.2),
                        RemixCssColorFilterOperation.brightness(1.16),
                      ],
                      dark: const [
                        RemixCssColorFilterOperation.brightness(0.95),
                        RemixCssColorFilterOperation.saturate(1.2),
                      ],
                    )
                  : fortalModeAwareFilter(
                      light: const [
                        RemixCssColorFilterOperation.brightness(0.92),
                        RemixCssColorFilterOperation.saturate(1.1),
                      ],
                      dark: const [
                        RemixCssColorFilterOperation.brightness(1.08),
                      ],
                    ),
            ),
      )
      .onDisabled(
        _fortalIconButtonForeground(IconButtonStyler(), FortalTokens.grayA8())
            .color(FortalTokens.gray2())
            .containerEffects(
              RemixBoxEffectsMix(
                behindContent: fortalClassicBaseButtonSurface(
                  highContrast: false,
                  disabled: true,
                ),
              ),
            )
            .spinner(.opacity(1))
            .wrap(fortalClearFilter()),
      );
}

IconButtonStyler _fortalIconButtonSolid(
  IconButtonStyler base, {
  required bool highContrast,
}) {
  final foreground = highContrast
      ? FortalTokens.gray1()
      : FortalTokens.accentContrast();
  return _fortalIconButtonForeground(base, foreground)
      .color(highContrast ? FortalTokens.accent12() : FortalTokens.accent9())
      .onHovered(
        .color(
          highContrast ? FortalTokens.accent12() : FortalTokens.accent10(),
        ).wrap(
          highContrast
              ? fortalModeAwareFilter(
                  light: const [
                    RemixCssColorFilterOperation.contrast(0.88),
                    RemixCssColorFilterOperation.saturate(1.1),
                    RemixCssColorFilterOperation.brightness(1.1),
                  ],
                  dark: const [
                    RemixCssColorFilterOperation.contrast(0.88),
                    RemixCssColorFilterOperation.saturate(1.3),
                    RemixCssColorFilterOperation.brightness(1.18),
                  ],
                )
              : fortalClearFilter(),
        ),
      )
      .onPressed(
        .color(
          highContrast ? FortalTokens.accent12() : FortalTokens.accent10(),
        ).wrap(
          highContrast
              ? fortalModeAwareFilter(
                  light: const [
                    RemixCssColorFilterOperation.contrast(0.82),
                    RemixCssColorFilterOperation.saturate(1.2),
                    RemixCssColorFilterOperation.brightness(1.16),
                  ],
                  dark: const [
                    RemixCssColorFilterOperation.brightness(0.95),
                    RemixCssColorFilterOperation.saturate(1.2),
                  ],
                )
              : fortalModeAwareFilter(
                  light: const [
                    RemixCssColorFilterOperation.brightness(0.92),
                    RemixCssColorFilterOperation.saturate(1.1),
                  ],
                  dark: const [RemixCssColorFilterOperation.brightness(1.08)],
                ),
        ),
      )
      .onDisabled(
        _fortalIconButtonForeground(IconButtonStyler(), FortalTokens.grayA8())
            .color(FortalTokens.grayA3())
            .spinner(.opacity(1))
            .wrap(fortalClearFilter()),
      );
}

IconButtonStyler _fortalIconButtonSoft(
  IconButtonStyler base, {
  required bool highContrast,
}) =>
    _fortalIconButtonForeground(
          base,
          highContrast ? FortalTokens.accent12() : FortalTokens.accentA11(),
        )
        .color(FortalTokens.accentA3())
        .onHovered(.color(FortalTokens.accentA4()))
        .onPressed(.color(FortalTokens.accentA5()))
        .onDisabled(_fortalIconButtonDisabledFill());

IconButtonStyler _fortalIconButtonSurface(
  IconButtonStyler base, {
  required bool highContrast,
}) =>
    _fortalIconButtonForeground(
          base,
          highContrast ? FortalTokens.accent12() : FortalTokens.accentA11(),
        )
        .color(FortalTokens.accentSurface())
        .containerEffects(
          RemixBoxEffectsMix(
            behindContent: fortalInsetSurface(
              strokes: [FortalTokens.accentA7()],
            ),
          ),
        )
        .onHovered(
          .color(FortalTokens.accentSurface()).containerEffects(
            RemixBoxEffectsMix(
              behindContent: fortalInsetSurface(
                strokes: [FortalTokens.accentA8()],
              ),
            ),
          ),
        )
        .onPressed(
          .color(FortalTokens.accentA3()).containerEffects(
            RemixBoxEffectsMix(
              behindContent: fortalInsetSurface(
                strokes: [FortalTokens.accentA8()],
              ),
            ),
          ),
        )
        .onDisabled(
          _fortalIconButtonForeground(IconButtonStyler(), FortalTokens.grayA8())
              .color(FortalTokens.grayA2())
              .containerEffects(
                RemixBoxEffectsMix(
                  behindContent: fortalInsetSurface(
                    strokes: [FortalTokens.grayA6()],
                  ),
                ),
              )
              .spinner(.opacity(1)),
        );

IconButtonStyler _fortalIconButtonOutline(
  IconButtonStyler base, {
  required bool highContrast,
}) {
  final strokes = highContrast
      ? [FortalTokens.accentA7(), FortalTokens.grayA11()]
      : [FortalTokens.accentA8()];
  return _fortalIconButtonForeground(
        base,
        highContrast ? FortalTokens.accent12() : FortalTokens.accentA11(),
      )
      .containerEffects(
        RemixBoxEffectsMix(behindContent: fortalInsetSurface(strokes: strokes)),
      )
      .onHovered(
        .color(FortalTokens.accentA2()).containerEffects(
          RemixBoxEffectsMix(
            behindContent: fortalInsetSurface(strokes: strokes),
          ),
        ),
      )
      .onPressed(
        .color(FortalTokens.accentA3()).containerEffects(
          RemixBoxEffectsMix(
            behindContent: fortalInsetSurface(strokes: strokes),
          ),
        ),
      )
      .onDisabled(
        _fortalIconButtonForeground(IconButtonStyler(), FortalTokens.grayA8())
            .color(Colors.transparent)
            .containerEffects(
              RemixBoxEffectsMix(
                behindContent: fortalInsetSurface(
                  strokes: [FortalTokens.grayA7()],
                ),
              ),
            )
            .spinner(.opacity(1)),
      );
}

IconButtonStyler _fortalIconButtonGhost(
  IconButtonStyler base, {
  required bool highContrast,
}) =>
    _fortalIconButtonForeground(
          base,
          highContrast ? FortalTokens.accent12() : FortalTokens.accentA11(),
        )
        .color(Colors.transparent)
        .onHovered(.color(FortalTokens.accentA3()))
        .onPressed(.color(FortalTokens.accentA4()))
        .onDisabled(
          _fortalIconButtonForeground(
            IconButtonStyler(),
            FortalTokens.grayA8(),
          ).color(Colors.transparent).spinner(.opacity(1)),
        );

IconButtonStyler _fortalIconButtonDisabledFill() => _fortalIconButtonForeground(
  IconButtonStyler(),
  FortalTokens.grayA8(),
).color(FortalTokens.grayA3()).spinner(.opacity(1));

IconButtonStyler _fortalIconButtonForeground(
  IconButtonStyler style,
  Color color,
) => style.icon(.color(color)).spinner(.color(color));
