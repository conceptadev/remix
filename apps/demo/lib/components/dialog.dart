import 'package:demo/helpers/catalog.dart';
import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final _key = GlobalKey();

@widgetbook.UseCase(name: 'Dialog Component', type: RemixDialog)
Widget buildDividerUseCase(BuildContext context) {
  return KeyedSubtree(
    key: _key,
    child: Scaffold(
      body: Center(
        child: Center(
          child: FortalButton(
            label: 'Open Dialog',
            onPressed: () {
              showRemixDialog(
                context: context,
                builder: (context) => Center(
                  child: FortalDialog(
                    title: 'Revoke access',
                    description:
                        'Are you sure? This application will no longer be accessible and any existing sessions will be expired.',
                    actions: [
                      FortalButton.ghost(
                        label: 'Cancel',
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      FortalButton(label: 'Revoke access', onPressed: () {}),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Alert Dialog', type: RemixDialog)
Widget buildAlertDialogUseCase(BuildContext context) {
  return Scaffold(
    body: Center(
      child: FortalButton(
        label: 'Delete project',
        onPressed: () {
          showRemixAlertDialog<void>(
            context: context,
            semanticLabel: 'Delete project confirmation',
            builder: (context) => Center(
              child: FortalDialog(
                title: 'Delete project?',
                description:
                    'This permanently deletes the project and all of its data.',
                actions: [
                  FortalButton.ghost(
                    label: 'Cancel',
                    onPressed: () => Navigator.pop(context),
                  ),
                  FortalButton(
                    label: 'Delete project',
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Catalog', type: RemixDialog)
Widget buildDialogCatalogUseCase(BuildContext context) {
  return CatalogMatrix(
    cellWidth: 340,
    columns: labelsOf(FortalDialogSize.values),
    rows: labelsOf(FortalDialogAlign.values),
    // Built inline rather than through showRemixDialog: routed modal dialogs
    // cannot be shown side by side, and the surface metrics these two enums
    // drive are visible without the route.
    cell: (row, column) => FortalDialog(
      size: FortalDialogSize.values[column],
      align: FortalDialogAlign.values[row],
      title: 'Title',
      description: 'Description',
      child: const FortalText('Body'),
    ),
  );
}
