import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
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
            onPressed: () {
              showRemixDialog(
                context: context,
                builder: (context) => FortalDialog(
                  title: 'Revoke access',
                  description:
                      'Are you sure? This application will no longer be accessible and any existing sessions will be expired.',
                  actions: [
                    FortalButton(
                      variant: .ghost,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    FortalButton(
                      onPressed: () {},
                      child: const Text('Revoke access'),
                    ),
                  ],
                ),
              );
            },
            child: const Text('Open Dialog'),
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
        onPressed: () {
          showRemixAlertDialog<void>(
            context: context,
            semanticLabel: 'Delete project confirmation',
            builder: (context) => FortalDialog(
              title: 'Delete project?',
              description:
                  'This permanently deletes the project and all of its data.',
              actions: [
                FortalButton(
                  variant: .ghost,
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                FortalButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Delete project'),
                ),
              ],
            ),
          );
        },
        child: const Text('Delete project'),
      ),
    ),
  );
}
