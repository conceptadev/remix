import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../../foundation/carbon_layer.dart';
import '../../tokens/generated/carbon_tokens.g.dart';
import '../_shared/carbon_action_surface.dart';

/// Carbon list contained within a labeled surface.
class CarbonContainedList extends StatelessWidget {
  const CarbonContainedList({
    super.key,
    required this.label,
    required this.items,
    this.action,
    this.semanticLabel,
  });

  final String label;
  final List<CarbonContainedListItem> items;
  final Widget? action;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) => Semantics(
    role: .list,
    label: semanticLabel ?? label,
    container: true,
    explicitChildNodes: true,
    child: Box(
      style: BoxStyler()
          .color(CarbonLayer.of(context).color(.layer).resolve(context))
          .border(
            BoxBorderMix.all(
              BorderSideMix(
                color: CarbonLayer.of(
                  context,
                ).color(.borderSubtle).resolve(context),
                width: 1,
              ),
            ),
          ),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          Padding(
            padding: .all(CarbonTokens.spacing05.resolve(context)),
            child: Row(
              children: [
                Expanded(
                  child: ExcludeSemantics(
                    child: StyledText(
                      label,
                      style: TextStyler()
                          .style(CarbonTokens.headingCompact01.mix())
                          .color(CarbonTokens.textPrimary()),
                    ),
                  ),
                ),
                ?action,
              ],
            ),
          ),
          ...items,
        ],
      ),
    ),
  );
}

/// One row in a [CarbonContainedList].
class CarbonContainedListItem extends StatelessWidget {
  const CarbonContainedListItem({
    super.key,
    required this.label,
    this.description,
    this.trailing,
    this.onPressed,
    this.enabled = true,
    this.semanticLabel,
  });

  final String label;
  final String? description;
  final Widget? trailing;
  final VoidCallback? onPressed;
  final bool enabled;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) => Semantics(
    role: .listItem,
    container: true,
    explicitChildNodes: true,
    child: CarbonActionSurface(
      semanticLabel: semanticLabel ?? label,
      enabled: enabled,
      onPressed: onPressed,
      builder: (context, focused, hovered, pressed) => Box(
        style: BoxStyler()
            .minHeight(CarbonTokens.sizeLarge())
            .padding(.all(CarbonTokens.spacing05()))
            .color(
              hovered || pressed
                  ? CarbonLayer.of(context).color(.layerHover).resolve(context)
                  : CarbonLayer.of(context).color(.layer).resolve(context),
            )
            .border(
              BoxBorderMix.top(
                BorderSideMix(
                  color: focused
                      ? CarbonTokens.focus()
                      : CarbonLayer.of(
                          context,
                        ).color(.borderSubtle).resolve(context),
                  width: focused ? 2 : 1,
                ),
              ),
            ),
        child: Row(
          children: [
            Expanded(
              child: ExcludeSemantics(
                child: Column(
                  mainAxisSize: .min,
                  crossAxisAlignment: .start,
                  children: [
                    StyledText(
                      label,
                      style: TextStyler()
                          .style(CarbonTokens.bodyCompact01.mix())
                          .color(
                            enabled
                                ? CarbonTokens.textPrimary()
                                : CarbonTokens.textDisabled(),
                          ),
                    ),
                    if (description != null) ...[
                      SizedBox(height: CarbonTokens.spacing02.resolve(context)),
                      StyledText(
                        description!,
                        style: TextStyler()
                            .style(CarbonTokens.helperText01.mix())
                            .color(CarbonTokens.textSecondary()),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            if (trailing != null) ...[
              SizedBox(width: CarbonTokens.spacing05.resolve(context)),
              trailing!,
            ],
          ],
        ),
      ),
    ),
  );
}
