import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../../tokens/generated/carbon_tokens.g.dart';
import '../toggletip/carbon_toggletip.dart';

/// Carbon AI-label presentation modes.
enum CarbonAiLabelKind { standard, inline }

/// Carbon AI-label sizes from the upstream Slug/AI Label component.
enum CarbonAiLabelSize { mini, x2Small, xSmall, small, medium, large, xLarge }

/// Carbon AI-label trigger geometry.
BoxStyler carbonAiLabelStyle({
  CarbonAiLabelKind kind = .standard,
  CarbonAiLabelSize size = .xSmall,
}) {
  if (kind == .inline) {
    return BoxStyler()
        .padding(.horizontal(CarbonTokens.spacing02()))
        .borderRadius(.all(.circular(1)))
        .border(
          BoxBorderMix.all(
            BorderSideMix(color: const Color(0x00000000), width: 1),
          ),
        )
        .alignment(.center);
  }

  final dimension = switch (size) {
    .mini => 16.0,
    .x2Small => 20.0,
    .xSmall => 24.0,
    .small => 32.0,
    .medium => 40.0,
    .large => 48.0,
    .xLarge => 64.0,
  };

  return BoxStyler()
      .size(dimension, dimension)
      .alignment(.center)
      .border(
        BoxBorderMix.all(
          BorderSideMix(color: CarbonTokens.borderInverse(), width: 1),
        ),
      );
}

/// Carbon's AI provenance label with an explanatory toggletip.
class CarbonAiLabel extends StatelessWidget {
  const CarbonAiLabel({
    super.key,
    required this.content,
    this.actions,
    this.aiText = 'AI',
    this.textLabel,
    this.kind = .standard,
    this.size = .xSmall,
    this.semanticLabel,
    this.positioning = const OverlayPositionConfig(sideOffset: 13),
    this.controller,
  });

  final Widget content;
  final Widget? actions;
  final String aiText;
  final String? textLabel;
  final CarbonAiLabelKind kind;
  final CarbonAiLabelSize size;
  final String? semanticLabel;
  final OverlayPositionConfig positioning;
  final MenuController? controller;

  double get _fontSize => switch (size) {
    .mini => 9,
    .x2Small || .xSmall => 12,
    .small || .medium || .large => 16,
    .xLarge => 20,
  };

  @override
  Widget build(BuildContext context) {
    final additionalText = textLabel;
    final aiTextWidget = StyledText(
      aiText,
      style: TextStyler()
          .fontSize(_fontSize)
          .fontWeight(.w600)
          .color(CarbonTokens.textPrimary()),
    );
    final trigger = Box(
      style: carbonAiLabelStyle(kind: kind, size: size),
      child: kind == .standard
          ? FittedBox(fit: .scaleDown, child: aiTextWidget)
          : Row(
              mainAxisSize: .min,
              spacing: additionalText == null
                  ? 0
                  : CarbonTokens.spacing02.resolve(context),
              children: [
                aiTextWidget,
                if (additionalText != null)
                  StyledText(
                    additionalText,
                    style: TextStyler()
                        .style(CarbonTokens.bodyCompact02.mix())
                        .color(CarbonTokens.textPrimary()),
                  ),
              ],
            ),
    );

    return CarbonToggletip(
      content: content,
      actions: actions,
      semanticLabel:
          semanticLabel ?? '$aiText ${additionalText ?? 'Show information'}',
      positioning: positioning,
      controller: controller,
      child: trigger,
    );
  }
}
