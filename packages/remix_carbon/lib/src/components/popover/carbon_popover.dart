import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../../foundation/carbon_layer.dart';
import '../../tokens/generated/carbon_tokens.g.dart';

part 'carbon_popover.g.dart';

const _carbonPopoverLayer = ContextToken(_resolveCarbonPopoverLayer);
const _carbonPopoverBorder = ContextToken(_resolveCarbonPopoverBorder);

Color _resolveCarbonPopoverLayer(BuildContext context) =>
    CarbonLayer.of(context).color(.layer).resolve(context);

Color _resolveCarbonPopoverBorder(BuildContext context) =>
    CarbonLayer.of(context).color(.borderSubtle).resolve(context);

/// Carbon popover recipe generated over [RemixPopover].
@MixWidget(
  target: RemixPopover.new,
  widgetParameters: .only({
    'popoverChild',
    'child',
    'positioning',
    'consumeOutsideTaps',
    'useRootOverlay',
    'openOnTap',
    'triggerFocusNode',
    'onOpen',
    'onClose',
    'onOpenRequested',
    'onCloseRequested',
    'controller',
    'semanticLabel',
    'excludeSemantics',
  }),
)
PopoverStyler carbonPopoverStyle({
  bool highContrast = false,
  bool border = false,
  bool dropShadow = true,
}) {
  final background = highContrast
      ? CarbonTokens.backgroundInverse()
      : _carbonPopoverLayer();
  final foreground = highContrast
      ? CarbonTokens.textInverse()
      : CarbonTokens.textPrimary();

  var style = PopoverStyler()
      .maxWidth(368)
      .borderRadius(.all(.circular(2)))
      .color(background)
      .clipBehavior(.antiAlias)
      .wrap(
        WidgetModifierConfig.defaultTextStyle(style: CarbonTokens.body01.mix()),
      )
      .wrap(
        WidgetModifierConfig.defaultTextStyle(
          style: TextStyleMix().color(foreground),
        ),
      );

  if (border) {
    style = style.border(
      BoxBorderMix.all(BorderSideMix(color: _carbonPopoverBorder(), width: 1)),
    );
  }
  if (dropShadow) {
    style = style.decoration(
      BoxDecorationMix.boxShadow([
        BoxShadowMix(
          color: CarbonTokens.shadow(),
          blurRadius: 2,
          offset: const Offset(0, 2),
        ),
      ]),
    );
  }

  return style;
}
