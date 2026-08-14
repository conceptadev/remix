import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../../foundation/carbon_layer.dart';
import '../../foundation/carbon_layout_scope.dart';
import '../../tokens/generated/carbon_tokens.g.dart';
import '../button/carbon_button.dart';
import '../select/carbon_select.dart';

/// Controlled Carbon pagination navigation.
class CarbonPagination extends StatelessWidget {
  const CarbonPagination({
    super.key,
    required this.page,
    required this.pageSize,
    required this.totalItems,
    this.onPageChanged,
    this.onPageSizeChanged,
    this.pageSizeOptions = const [10, 20, 30, 40, 50],
    this.itemsLabel = 'items',
    this.previousPageLabel = 'Previous page',
    this.nextPageLabel = 'Next page',
    this.semanticLabel = 'Pagination',
  });

  final int page;
  final int pageSize;
  final int totalItems;
  final ValueChanged<int>? onPageChanged;
  final ValueChanged<int>? onPageSizeChanged;
  final List<int> pageSizeOptions;
  final String itemsLabel;
  final String previousPageLabel;
  final String nextPageLabel;
  final String semanticLabel;

  bool _debugConfigurationIsValid() {
    assert(pageSize > 0, 'CarbonPagination.pageSize must be positive.');
    assert(
      totalItems >= 0,
      'CarbonPagination.totalItems must not be negative.',
    );
    assert(
      pageSizeOptions.isNotEmpty &&
          pageSizeOptions.every((value) => value > 0) &&
          pageSizeOptions.toSet().length == pageSizeOptions.length,
      'CarbonPagination.pageSizeOptions must be unique and positive.',
    );
    assert(
      onPageSizeChanged == null || pageSizeOptions.contains(pageSize),
      'CarbonPagination.pageSize must be one of pageSizeOptions.',
    );
    final pages = math.max(1, (totalItems / pageSize).ceil());
    assert(
      page >= 1 && page <= pages,
      'CarbonPagination.page is out of range.',
    );

    return true;
  }

  @override
  Widget build(BuildContext context) {
    assert(_debugConfigurationIsValid());
    final pageCount = math.max(1, (totalItems / pageSize).ceil());
    final start = totalItems == 0 ? 0 : (page - 1) * pageSize + 1;
    final end = math.min(page * pageSize, totalItems);
    final buttonStyle = carbonButtonStyle(
      kind: .ghost,
      size: .md,
    ).padding(.all(0)).spacing(0).mainAxisAlignment(.center);

    return Semantics(
      role: .navigation,
      label: semanticLabel,
      container: true,
      explicitChildNodes: true,
      child: Box(
        style: BoxStyler()
            .minHeight(CarbonSize.md.height)
            .color(CarbonLayer.of(context).color(.layer).resolve(context))
            .border(
              BoxBorderMix.top(
                BorderSideMix(
                  color: CarbonLayer.of(
                    context,
                  ).color(.borderSubtle).resolve(context),
                  width: 1,
                ),
              ),
            )
            .padding(.left(CarbonTokens.spacing05())),
        child: Row(
          children: [
            if (onPageSizeChanged != null) ...[
              ExcludeSemantics(
                child: StyledText(
                  'Items per page',
                  style: TextStyler()
                      .style(CarbonTokens.label01.mix())
                      .color(CarbonTokens.textSecondary()),
                ),
              ),
              SizedBox(width: CarbonTokens.spacing03.resolve(context)),
              SizedBox(
                width: 88,
                child: CarbonSelect<int>(
                  placeholder: '$pageSize',
                  semanticLabel: 'Items per page',
                  selectedValue: pageSize,
                  items: [
                    for (final size in pageSizeOptions)
                      CarbonSelectItem(value: size, label: '$size'),
                  ],
                  size: .md,
                  onChanged: (value) {
                    if (value != null) onPageSizeChanged?.call(value);
                  },
                ),
              ),
              SizedBox(width: CarbonTokens.spacing05.resolve(context)),
            ],
            Expanded(
              child: StyledText(
                '$start–$end of $totalItems $itemsLabel',
                style: TextStyler()
                    .style(CarbonTokens.bodyCompact01.mix())
                    .color(CarbonTokens.textSecondary()),
              ),
            ),
            ExcludeSemantics(
              child: StyledText(
                '$page of $pageCount pages',
                style: TextStyler()
                    .style(CarbonTokens.bodyCompact01.mix())
                    .color(CarbonTokens.textSecondary()),
              ),
            ),
            SizedBox(width: CarbonTokens.spacing03.resolve(context)),
            SizedBox.square(
              dimension: CarbonSize.md.height,
              child: RemixButton(
                label: '‹',
                semanticLabel: previousPageLabel,
                enabled: page > 1 && onPageChanged != null,
                onPressed: page > 1
                    ? () => onPageChanged?.call(page - 1)
                    : null,
                style: buttonStyle,
              ),
            ),
            SizedBox.square(
              dimension: CarbonSize.md.height,
              child: RemixButton(
                label: '›',
                semanticLabel: nextPageLabel,
                enabled: page < pageCount && onPageChanged != null,
                onPressed: page < pageCount
                    ? () => onPageChanged?.call(page + 1)
                    : null,
                style: buttonStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
