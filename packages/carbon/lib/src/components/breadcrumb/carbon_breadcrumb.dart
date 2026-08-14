import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../../icons/icons.dart';
import '../../tokens/generated/carbon_tokens.g.dart';
import '../link/carbon_link.dart';

/// One link or current-page entry in [CarbonBreadcrumb].
class CarbonBreadcrumbItem extends StatelessWidget {
  const CarbonBreadcrumbItem({
    super.key,
    required this.label,
    this.onPressed,
    this.current = false,
    this.semanticLabel,
  }) : assert(label != '');

  final String label;
  final VoidCallback? onPressed;
  final bool current;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    if (!current) {
      return CarbonLink(
        label: label,
        semanticLabel: semanticLabel,
        inline: true,
        size: .small,
        onPressed: onPressed,
      );
    }

    return Semantics(
      label: semanticLabel ?? label,
      selected: true,
      child: ExcludeSemantics(
        child: StyledText(
          label,
          style: TextStyler()
              .style(CarbonTokens.bodyCompact01.mix())
              .color(CarbonTokens.textPrimary()),
        ),
      ),
    );
  }
}

/// Carbon breadcrumb navigation with optional middle-item collapsing.
class CarbonBreadcrumb extends StatelessWidget {
  const CarbonBreadcrumb({
    super.key,
    required this.items,
    this.maxVisibleItems,
    this.noTrailingSlash = false,
    this.semanticLabel = 'Breadcrumb',
  }) : assert(maxVisibleItems == null || maxVisibleItems >= 2);

  final List<CarbonBreadcrumbItem> items;
  final int? maxVisibleItems;
  final bool noTrailingSlash;
  final String semanticLabel;

  List<Widget> _visibleItems() {
    final max = maxVisibleItems;
    if (max == null || items.length <= max) return List.of(items);
    final trailingCount = max - 2;

    return [
      ...items.take(1),
      const _CollapsedBreadcrumbItem(),
      if (trailingCount > 0) ...items.sublist(items.length - trailingCount),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final visible = _visibleItems();

    return Semantics(
      role: .navigation,
      label: semanticLabel,
      container: true,
      explicitChildNodes: true,
      child: Wrap(
        crossAxisAlignment: .center,
        spacing: CarbonTokens.spacing03.resolve(context),
        runSpacing: CarbonTokens.spacing03.resolve(context),
        children: [
          for (var index = 0; index < visible.length; index++) ...[
            visible[index],
            if (index < visible.length - 1 || !noTrailingSlash)
              ExcludeSemantics(
                child: StyledText(
                  '/',
                  style: TextStyler()
                      .style(CarbonTokens.bodyCompact01.mix())
                      .color(CarbonTokens.textSecondary()),
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _CollapsedBreadcrumbItem extends StatelessWidget {
  const _CollapsedBreadcrumbItem();

  @override
  Widget build(BuildContext context) => Semantics(
    label: 'Collapsed breadcrumb items',
    child: ExcludeSemantics(
      child: Icon(
        CarbonIcons.overflowMenuHorizontal,
        size: CarbonTokens.iconSize01.resolve(context),
        color: CarbonTokens.iconSecondary.resolve(context),
      ),
    ),
  );
}
