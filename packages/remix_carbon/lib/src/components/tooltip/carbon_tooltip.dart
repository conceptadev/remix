import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../../foundation/carbon_layer.dart';
import '../../tokens/generated/carbon_tokens.g.dart';

part 'carbon_tooltip.g.dart';

const _carbonTooltipLayer = ContextToken(_resolveCarbonTooltipLayer);

Color _resolveCarbonTooltipLayer(BuildContext context) =>
    CarbonLayer.of(context).color(.layer).resolve(context);

/// Carbon tooltip recipe generated over [RemixTooltip].
@MixWidget(target: RemixTooltip.new)
TooltipStyler carbonTooltipStyle({bool highContrast = true}) {
  final background = highContrast
      ? CarbonTokens.backgroundInverse()
      : _carbonTooltipLayer();
  final foreground = highContrast
      ? CarbonTokens.textInverse()
      : CarbonTokens.textPrimary();

  return TooltipStyler(
        label: TextStyler().style(CarbonTokens.body01.mix()).color(foreground),
        waitDuration: const Duration(milliseconds: 100),
        showDuration: const Duration(milliseconds: 1500),
        dismissDuration: const Duration(milliseconds: 300),
      )
      .maxWidth(288)
      .padding(.all(CarbonTokens.spacing05()))
      .borderRadius(.all(.circular(2)))
      .color(background);
}
