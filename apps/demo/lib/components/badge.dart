import 'package:demo/helpers/catalog.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final _key = GlobalKey();

@widgetbook.UseCase(name: 'Badge Component', type: RemixBadge)
Widget buildBadgeUseCase(BuildContext context) {
  return KeyedSubtree(
    key: _key,
    child: Scaffold(
      body: Center(
        child: FortalBadge(
          label: context.knobs.string(label: 'Label', initialValue: 'New'),
          variant: context.knobs.object.dropdown(
            label: 'variant',
            options: FortalBadgeVariant.values,
            labelBuilder: (variant) => variant.name,
          ),
          size: context.knobs.object.dropdown(
            label: 'size',
            options: FortalBadgeSize.values,
            labelBuilder: (size) => size.name,
            initialOption: FortalBadgeSize.size1,
          ),
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Catalog', type: RemixBadge)
Widget buildBadgeCatalogUseCase(BuildContext context) {
  return CatalogMatrix(
    columns: labelsOf(FortalBadgeSize.values),
    rows: labelsOf(FortalBadgeVariant.values),
    cell: (row, column) => FortalBadge(
      label: 'Badge',
      size: FortalBadgeSize.values[column],
      variant: FortalBadgeVariant.values[row],
    ),
  );
}
