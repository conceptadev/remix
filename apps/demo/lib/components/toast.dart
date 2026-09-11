import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Stacked notifications', type: RemixToast)
Widget buildToastUseCase(BuildContext context) => const ToastExample();

@widgetbook.UseCase(name: 'Catalog', type: RemixToast)
Widget buildToastCatalogUseCase(BuildContext context) => const ToastCatalog();

class ToastExample extends StatefulWidget {
  const ToastExample({super.key});

  @override
  State<ToastExample> createState() => _ToastExampleState();
}

class _ToastExampleState extends State<ToastExample> {
  int _undone = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: RemixToastScope(
      style: fortalToastStyle(),
      // showRemixToast needs a context below the scope.
      child: Builder(
        builder: (context) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 12,
            children: [
              FortalButton(
                label: 'Archive conversation',
                onPressed: () => showRemixToast(
                  context,
                  RemixToastData(
                    title: 'Conversation archived',
                    icon: Icons.archive_outlined,
                    action: RemixToastAction(
                      label: 'Undo',
                      onPressed: () => setState(() => _undone += 1),
                    ),
                  ),
                ),
              ),
              Text('Undone: $_undone'),
            ],
          ),
        ),
      ),
    ),
  );
}

class ToastCatalog extends StatelessWidget {
  const ToastCatalog({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: SizedBox(
          width: 360,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              FortalToast.surface(
                title: 'Draft saved',
                icon: Icons.check_circle_outline,
                onDismiss: () {},
                dismissLabel: 'Dismiss',
              ),
              FortalToast.classic(
                title: 'Conversation archived',
                description: 'You can restore it from the archive.',
                icon: Icons.archive_outlined,
                action: RemixToastAction(label: 'Undo', onPressed: () {}),
                onDismiss: () {},
                dismissLabel: 'Dismiss',
              ),
              const FortalToast(size: .size1, title: 'Size 1'),
              const FortalToast(size: .size2, title: 'Size 2'),
              const FortalToast(size: .size3, title: 'Size 3'),
            ],
          ),
        ),
      ),
    ),
  );
}
