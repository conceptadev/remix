import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../../foundation/carbon_layer.dart';
import '../../tokens/generated/carbon_tokens.g.dart';

part 'carbon_accordion.g.dart';

/// Sizes supported by Carbon accordions.
enum CarbonAccordionSize { small, medium, large }

/// Carbon-facing name for Remix's behavior-only accordion controller.
typedef CarbonAccordionController<T> = RemixAccordionController<T>;

const _carbonAccordionBorder = ContextToken(_resolveCarbonAccordionBorder);
const _carbonAccordionHover = ContextToken(_resolveCarbonAccordionHover);
Color _resolveCarbonAccordionBorder(BuildContext context) =>
    CarbonLayer.of(context).color(.borderSubtle).resolve(context);

Color _resolveCarbonAccordionHover(BuildContext context) =>
    CarbonLayer.of(context).color(.layerHover).resolve(context);

/// Carbon's visual recipe for an accordion item.
@MixWidget(
  target: RemixAccordion.new,
  widgetParameters: .only({
    'value',
    'child',
    'title',
    'leadingIcon',
    'trailingIcon',
    'enabled',
    'mouseCursor',
    'enableFeedback',
    'autofocus',
    'focusNode',
    'onFocusChange',
    'onHoverChange',
    'onPressChange',
    'semanticLabel',
    'transitionBuilder',
  }),
)
AccordionStyler carbonAccordionStyle({CarbonAccordionSize size = .medium}) {
  final divider = BorderSideMix(color: _carbonAccordionBorder(), width: 1);
  final height = switch (size) {
    .small => CarbonTokens.sizeSmall(),
    .medium => CarbonTokens.sizeMedium(),
    .large => CarbonTokens.sizeLarge(),
  };

  return AccordionStyler()
      .container(
        BoxStyler().width(.infinity).border(BoxBorderMix.horizontal(divider)),
      )
      .trigger(
        FlexBoxStyler()
            .height(height)
            .padding(.horizontal(CarbonTokens.spacing05()))
            .direction(.horizontal)
            .crossAxisAlignment(.center),
      )
      .title(
        TextStyler()
            .style(CarbonTokens.body01.mix())
            .color(CarbonTokens.textPrimary()),
      )
      .leadingIcon(
        IconStyler()
            .size(CarbonTokens.iconSize01())
            .color(CarbonTokens.iconPrimary()),
      )
      .trailingIcon(
        IconStyler()
            .size(CarbonTokens.iconSize01())
            .color(CarbonTokens.iconPrimary()),
      )
      .content(
        BoxStyler()
            .width(.infinity)
            .padding(
              EdgeInsetsDirectionalMix.fromSTEB(
                CarbonTokens.spacing05(),
                CarbonTokens.spacing03(),
                CarbonTokens.spacing09(),
                CarbonTokens.spacing06(),
              ),
            )
            .wrap(
              WidgetModifierConfig.defaultTextStyle(
                style: CarbonTokens.body01.mix(),
              ),
            ),
      )
      .onHovered(AccordionStyler().trigger(.color(_carbonAccordionHover())))
      .onFocusVisible(
        AccordionStyler().trigger(
          .foregroundDecoration(
            BoxDecorationMix(
              border: BoxBorderMix.all(
                BorderSideMix(color: CarbonTokens.focus(), width: 2),
              ),
            ),
          ),
        ),
      )
      .onDisabled(
        AccordionStyler()
            .title(.color(CarbonTokens.textDisabled()))
            .leadingIcon(.color(CarbonTokens.iconDisabled()))
            .trailingIcon(.color(CarbonTokens.iconDisabled())),
      );
}

/// Coordinates the expansion state of descendant [CarbonAccordion] items.
class CarbonAccordionGroup<T> extends StatelessWidget {
  const CarbonAccordionGroup({
    super.key,
    required this.child,
    required this.controller,
    this.initialExpandedValues = const [],
  });

  final Widget child;
  final CarbonAccordionController<T> controller;
  final List<T> initialExpandedValues;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: .infinity,
    child: RemixAccordionGroup<T>(
      controller: controller,
      initialExpandedValues: initialExpandedValues,
      child: child,
    ),
  );
}
