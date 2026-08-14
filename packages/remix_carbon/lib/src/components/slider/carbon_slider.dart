import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../../foundation/carbon_layer.dart';
import '../../tokens/generated/carbon_tokens.g.dart';

part 'carbon_slider.g.dart';

const _carbonSliderTrack = ContextToken(_resolveCarbonSliderTrack);
const _carbonSliderFocusInset = ContextToken(_resolveCarbonSliderFocusInset);

Color _resolveCarbonSliderTrack(BuildContext context) =>
    CarbonLayer.of(context).color(.borderSubtle).resolve(context);

Color _resolveCarbonSliderFocusInset(BuildContext context) =>
    CarbonLayer.of(context).color(.layer).resolve(context);

/// Carbon slider recipe generated over [RemixSlider].
@MixWidget(
  target: RemixSlider.new,
  widgetParameters: .only({
    'value',
    'onChanged',
    'onChangeStart',
    'onChangeEnd',
    'min',
    'max',
    'enabled',
    'enableFeedback',
    'focusNode',
    'autofocus',
    'snapDivisions',
    'semanticLabel',
    'excludeSemantics',
  }),
)
SliderStyler carbonSliderStyle() {
  final regularThumb = BoxStyler()
      .size(14, 14)
      .borderRadius(.all(.circular(7)))
      .color(CarbonTokens.layerSelectedInverse());
  final largeThumb = BoxStyler().size(20, 20).borderRadius(.all(.circular(10)));

  return SliderStyler()
      .trackColor(_carbonSliderTrack())
      .rangeColor(CarbonTokens.layerSelectedInverse())
      .trackWidth(2)
      .rangeWidth(2)
      .thumb(regularThumb)
      .onHovered(SliderStyler().thumb(largeThumb))
      .onPressed(SliderStyler().thumb(largeThumb))
      .onFocused(
        SliderStyler().thumb(
          largeThumb
              .color(CarbonTokens.interactive())
              .border(
                BoxBorderMix.all(
                  BorderSideMix(color: _carbonSliderFocusInset(), width: 1),
                ),
              ),
        ),
      )
      .onDisabled(
        SliderStyler()
            .trackColor(CarbonTokens.borderDisabled())
            .rangeColor(CarbonTokens.borderDisabled())
            .thumb(regularThumb.color(CarbonTokens.borderDisabled())),
      );
}
