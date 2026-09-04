import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../../foundation/carbon_layer.dart';
import '../../icons/icons.dart';
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
  target: _CarbonAccordionBase.new,
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

class _CarbonAccordionBase<T> extends StatelessWidget {
  const _CarbonAccordionBase({
    super.key,
    required this.value,
    required this.child,
    required this.title,
    this.leadingIcon,
    this.trailingIcon,
    this.enabled = true,
    this.mouseCursor = SystemMouseCursors.click,
    this.enableFeedback = true,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.onHoverChange,
    this.onPressChange,
    this.semanticLabel,
    this.transitionBuilder = RemixAccordion.defaultAccordionTransitionBuilder,
    this.style = const AccordionStyler.create(),
  });

  final T value;
  final Widget child;
  final String title;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final bool enabled;
  final MouseCursor mouseCursor;
  final bool enableFeedback;
  final bool autofocus;
  final FocusNode? focusNode;
  final ValueChanged<bool>? onFocusChange;
  final ValueChanged<bool>? onHoverChange;
  final ValueChanged<bool>? onPressChange;
  final String? semanticLabel;
  final Widget Function(Widget, Animation<double>) transitionBuilder;
  final AccordionStyler style;

  Widget _buildTrigger(AccordionSpec spec, bool expanded) => FlexBox(
    styleSpec: spec.trigger,
    children: [
      if (leadingIcon case final icon?)
        StyledIcon(icon: icon, styleSpec: spec.leadingIcon),
      // FlexBox is a Mix-owned Flex wrapper that DCM cannot infer here.
      // ignore: avoid-flexible-outside-flex
      Expanded(child: StyledText(title, styleSpec: spec.title)),
      StyledIcon(
        icon:
            trailingIcon ??
            (expanded ? CarbonIcons.chevronDown : CarbonIcons.chevronRight),
        styleSpec: spec.trailingIcon,
      ),
    ],
  );

  @override
  Widget build(BuildContext context) => style<T>(
    value: value,
    child: child,
    title: title,
    leadingIcon: leadingIcon,
    trailingIcon: trailingIcon,
    builder: (context, state) {
      final styleSpec = StyleSpecProvider.of<AccordionSpec>(context);
      assert(styleSpec != null, 'No CarbonAccordion style found in context.');

      return _buildTrigger(styleSpec!.spec, state.isExpanded);
    },
    enabled: enabled,
    mouseCursor: mouseCursor,
    enableFeedback: enableFeedback,
    autofocus: autofocus,
    focusNode: focusNode,
    onFocusChange: onFocusChange,
    onHoverChange: onHoverChange,
    onPressChange: onPressChange,
    semanticLabel: semanticLabel,
    transitionBuilder: transitionBuilder,
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
