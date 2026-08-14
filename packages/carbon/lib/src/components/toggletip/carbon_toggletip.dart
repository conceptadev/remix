import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../popover/carbon_popover.dart';
import '../../tokens/generated/carbon_tokens.g.dart';

/// Carbon's high-contrast toggletip content container.
BoxStyler carbonToggletipContentStyle() => .new()
    .maxWidth(288)
    .padding(.all(CarbonTokens.spacing05()))
    .wrap(
      WidgetModifierConfig.defaultTextStyle(style: CarbonTokens.body01.mix()),
    )
    .wrap(
      WidgetModifierConfig.defaultTextStyle(
        style: TextStyleMix().color(CarbonTokens.textInverse()),
      ),
    );

/// A click-activated, interactive explanation anchored to [child].
class CarbonToggletip extends StatelessWidget {
  const CarbonToggletip({
    super.key,
    required this.content,
    required this.child,
    this.actions,
    this.semanticLabel = 'Show information',
    this.positioning = const OverlayPositionConfig(sideOffset: 13),
    this.controller,
    this.onOpen,
    this.onClose,
  });

  final Widget content;
  final Widget child;
  final Widget? actions;
  final String semanticLabel;
  final OverlayPositionConfig positioning;
  final MenuController? controller;
  final VoidCallback? onOpen;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final actionContent = actions;
    final trigger = DefaultTextStyle.merge(
      style: TextStyle(color: CarbonTokens.textPrimary.resolve(context)),
      child: child,
    );

    return CarbonPopover(
      highContrast: true,
      popoverChild: Box(
        style: carbonToggletipContentStyle(),
        child: actionContent == null
            ? content
            : Column(
                mainAxisSize: .min,
                crossAxisAlignment: .start,
                spacing: CarbonTokens.spacing05.resolve(context),
                children: [content, actionContent],
              ),
      ),
      positioning: positioning,
      controller: controller,
      onOpen: onOpen,
      onClose: onClose,
      semanticLabel: semanticLabel,
      child: trigger,
    );
  }
}
