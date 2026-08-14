import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../../foundation/carbon_layout_scope.dart';
import '../../icons/icons.dart';
import '../../tokens/generated/carbon_component_tokens.g.dart';
import '../../tokens/generated/carbon_tokens.g.dart';
import '../_shared/carbon_icon_button_style.dart';
import '../button/carbon_button.dart';

enum CarbonTagKind {
  gray,
  coolGray,
  warmGray,
  red,
  magenta,
  purple,
  blue,
  cyan,
  teal,
  green,
  highContrast,
}

/// Carbon status/filter tag adapted over [RemixBadge].
class CarbonTag extends StatelessWidget {
  const CarbonTag({
    super.key,
    required this.label,
    this.kind = .gray,
    this.size = .sm,
    this.onRemove,
    this.disabled = false,
    this.removeLabel,
  });

  final String label;
  final CarbonTagKind kind;
  final CarbonSize size;
  final VoidCallback? onRemove;
  final bool disabled;
  final String? removeLabel;

  @override
  Widget build(BuildContext context) {
    final (background, foreground, border) = _colors(kind);
    final height = size.clampTo(.sm, .md) == .sm ? 24.0 : 32.0;
    final removable = onRemove != null;

    return Semantics(
      label: label,
      container: true,
      explicitChildNodes: removable,
      child:
          BadgeStyler()
              .height(height)
              .padding(
                .left(CarbonTokens.spacing03()).right(
                  removable
                      ? CarbonTokens.spacing02()
                      : CarbonTokens.spacing03(),
                ),
              )
              .borderRadius(.all(.circular(height / 2)))
              .color(
                disabled ? CarbonTokens.layerSelectedDisabled() : background(),
              )
              .border(
                BoxBorderMix.all(
                  BorderSideMix(
                    color: disabled ? CarbonTokens.borderDisabled() : border(),
                    width: 1,
                  ),
                ),
              )
              .label(
                .style(
                  CarbonTokens.label01.mix(),
                ).color(disabled ? CarbonTokens.textDisabled() : foreground()),
              )(
            child: Row(
              mainAxisSize: .min,
              children: [
                ExcludeSemantics(
                  child: StyledText(
                    label,
                    style: TextStyler()
                        .style(CarbonTokens.label01.mix())
                        .color(
                          disabled ? CarbonTokens.textDisabled() : foreground(),
                        ),
                  ),
                ),
                if (removable) ...[
                  SizedBox(width: CarbonTokens.spacing02.resolve(context)),
                  SizedBox.square(
                    dimension: height - 4,
                    child: CarbonIconButton(
                      icon: CarbonIcons.close,
                      semanticLabel: removeLabel ?? 'Remove $label',
                      enabled: !disabled,
                      onPressed: disabled ? null : onRemove,
                      size: .sm,
                      style: carbonIconButtonForegroundStyle(
                        foreground,
                      ).size(height - 4, height - 4),
                    ),
                  ),
                ],
              ],
            ),
          ),
    );
  }
}

(ColorToken, ColorToken, ColorToken) _colors(CarbonTagKind kind) =>
    switch (kind) {
      .gray => (
        CarbonComponentTokens.tagBackgroundGray,
        CarbonComponentTokens.tagColorGray,
        CarbonComponentTokens.tagBorderGray,
      ),
      .coolGray => (
        CarbonComponentTokens.tagBackgroundCoolGray,
        CarbonComponentTokens.tagColorCoolGray,
        CarbonComponentTokens.tagBorderCoolGray,
      ),
      .warmGray => (
        CarbonComponentTokens.tagBackgroundWarmGray,
        CarbonComponentTokens.tagColorWarmGray,
        CarbonComponentTokens.tagBorderWarmGray,
      ),
      .red => (
        CarbonComponentTokens.tagBackgroundRed,
        CarbonComponentTokens.tagColorRed,
        CarbonComponentTokens.tagBorderRed,
      ),
      .magenta => (
        CarbonComponentTokens.tagBackgroundMagenta,
        CarbonComponentTokens.tagColorMagenta,
        CarbonComponentTokens.tagBorderMagenta,
      ),
      .purple => (
        CarbonComponentTokens.tagBackgroundPurple,
        CarbonComponentTokens.tagColorPurple,
        CarbonComponentTokens.tagBorderPurple,
      ),
      .blue => (
        CarbonComponentTokens.tagBackgroundBlue,
        CarbonComponentTokens.tagColorBlue,
        CarbonComponentTokens.tagBorderBlue,
      ),
      .cyan => (
        CarbonComponentTokens.tagBackgroundCyan,
        CarbonComponentTokens.tagColorCyan,
        CarbonComponentTokens.tagBorderCyan,
      ),
      .teal => (
        CarbonComponentTokens.tagBackgroundTeal,
        CarbonComponentTokens.tagColorTeal,
        CarbonComponentTokens.tagBorderTeal,
      ),
      .green => (
        CarbonComponentTokens.tagBackgroundGreen,
        CarbonComponentTokens.tagColorGreen,
        CarbonComponentTokens.tagBorderGreen,
      ),
      .highContrast => (
        CarbonTokens.backgroundInverse,
        CarbonTokens.textInverse,
        CarbonTokens.borderInverse,
      ),
    };
