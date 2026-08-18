import 'package:demo/helpers/catalog.dart';
import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final _key = GlobalKey();

@widgetbook.UseCase(name: 'Divider Component', type: RemixDivider)
Widget buildDividerUseCase(BuildContext context) {
  return KeyedSubtree(
    key: _key,
    child: Scaffold(
      body: Center(
        child: SizedBox(
          height: 300,
          width: 300,
          child: Center(
            child: FortalDivider(
              size: context.knobs.object.dropdown(
                label: 'size',
                options: FortalDividerSize.values,
                labelBuilder: (size) => size.name,
                initialOption: FortalDividerSize.size1,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Catalog', type: RemixDivider)
Widget buildDividerCatalogUseCase(BuildContext context) {
  return CatalogMatrix(
    columns: labelsOf(FortalDividerSize.values),
    rows: noRowAxis,
    cell: (row, column) => SizedBox(
      width: 120,
      child: FortalDivider(size: FortalDividerSize.values[column]),
    ),
  );
}
