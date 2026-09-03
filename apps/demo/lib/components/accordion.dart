import 'package:demo/helpers/catalog.dart';
import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final _key = GlobalKey();

@widgetbook.UseCase(name: 'Accordion Component', type: RemixAccordion)
Widget buildAvatarUseCase(BuildContext context) {
  return KeyedSubtree(
    key: _key,
    child: Scaffold(
      body: Center(
        child: SizedBox(
          width: 400,
          child: RemixAccordionGroup(
            controller: RemixAccordionController<String>(min: 0, max: 1),
            child: const Column(
              spacing: 8,
              children: [
                FortalAccordion(
                  value: 'accordion1',
                  title: 'Is it accessible?',
                  child: Text('Yes, it is accessible.'),
                ),
                FortalAccordion(
                  value: 'accordion2',
                  title: 'What payment methods are accepted?',
                  child: Text(
                    'Major credit and debit cards like Visa, MasterCard, and American Express, as well as digital payment options like PayPal and Apple Pay.',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

/// One controller per cell, created once rather than per build.
///
/// An accordion reads its open state from the group above it, so a shared
/// controller would expand every cell in the matrix together, and a controller
/// built inside `cell` would be replaced on each rebuild.
final _catalogControllers = <String, RemixAccordionController<String>>{};

RemixAccordionController<String> _catalogController(String cellId) {
  return _catalogControllers.putIfAbsent(
    cellId,
    () => RemixAccordionController<String>(min: 0, max: 1),
  );
}

@widgetbook.UseCase(name: 'Catalog', type: RemixAccordion)
Widget buildAccordionCatalogUseCase(BuildContext context) {
  return CatalogMatrix(
    cellWidth: 280,
    columns: labelsOf(FortalAccordionSize.values),
    rows: labelsOf(FortalAccordionVariant.values),
    cell: (row, column) => SizedBox(
      width: 260,
      child: RemixAccordionGroup(
        controller: _catalogController('$row.$column'),
        child: FortalAccordion<String>(
          value: 'panel',
          title: 'Section',
          size: FortalAccordionSize.values[column],
          variant: FortalAccordionVariant.values[row],
          child: const FortalText('Panel body'),
        ),
      ),
    ),
  );
}
