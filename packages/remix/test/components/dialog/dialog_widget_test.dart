import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

List<SemanticsNode> _collectSemanticsNodes(
  SemanticsNode root,
  bool Function(SemanticsNode) predicate,
) {
  final nodes = <SemanticsNode>[];

  bool visitor(SemanticsNode node) {
    if (!node.isMergedIntoParent && predicate(node)) nodes.add(node);
    node.visitChildren(visitor);
    return true;
  }

  visitor(root);
  return nodes;
}

void main() {
  group('showRemixAlertDialog', () {
    testWidgets('opens and renders alert content', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => TextButton(
              onPressed: () => showRemixAlertDialog<void>(
                context: context,
                semanticLabel: 'Delete project',
                transitionDuration: Duration.zero,
                builder: (context) => const Text('Alert content'),
              ),
              child: const Text('Open'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pump();
      await tester.pump();

      expect(find.text('Alert content'), findsOneWidget);
    });

    testWidgets('rejects an empty semantic label', (tester) async {
      late BuildContext hostContext;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              hostContext = context;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(
        () => showRemixAlertDialog<void>(
          context: hostContext,
          semanticLabel: '   ',
          builder: (context) => const SizedBox.shrink(),
        ),
        throwsArgumentError,
      );
    });

    testWidgets('does not dismiss from a barrier tap by default', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => TextButton(
              onPressed: () => showRemixAlertDialog<void>(
                context: context,
                semanticLabel: 'Delete project',
                transitionDuration: Duration.zero,
                builder: (context) => const SizedBox.square(
                  key: ValueKey('alert-content'),
                  dimension: 200,
                ),
              ),
              child: const Text('Open'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pump();
      await tester.pump();
      await tester.tapAt(const Offset(4, 4));
      await tester.pump();

      expect(find.byKey(const ValueKey('alert-content')), findsOneWidget);

      Navigator.of(
        tester.element(find.byKey(const ValueKey('alert-content'))),
      ).pop();
      await tester.pump();
    });

    testWidgets('Escape cancels with a null result', (tester) async {
      final cancelNode = FocusNode(debugLabel: 'escape cancel action');
      addTearDown(cancelNode.dispose);
      Future<String?>? result;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => TextButton(
              onPressed: () {
                result = showRemixAlertDialog<String>(
                  context: context,
                  semanticLabel: 'Delete project',
                  transitionDuration: Duration.zero,
                  initialFocusNode: cancelNode,
                  builder: (context) => TextButton(
                    focusNode: cancelNode,
                    onPressed: () => Navigator.of(context).pop('cancel'),
                    child: const Text('Escape alert'),
                  ),
                );
              },
              child: const Text('Open'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pump();
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pump();

      expect(find.text('Escape alert'), findsNothing);
      expect(await result, isNull);
    });

    testWidgets('system back cancels with a null result', (tester) async {
      Future<String?>? result;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => TextButton(
              onPressed: () {
                result = showRemixAlertDialog<String>(
                  context: context,
                  semanticLabel: 'Delete project',
                  transitionDuration: Duration.zero,
                  builder: (context) => const Text('Back alert'),
                );
              },
              child: const Text('Open'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pump();
      await tester.pump();
      expect(await tester.binding.handlePopRoute(), isTrue);
      await tester.pump();

      expect(find.text('Back alert'), findsNothing);
      expect(await result, isNull);
    });

    testWidgets('passes a cloned MixScope to the alert builder', (
      tester,
    ) async {
      bool builderHasScope = false;
      await tester.pumpRemixApp(
        Builder(
          builder: (context) => TextButton(
            onPressed: () => showRemixAlertDialog<void>(
              context: context,
              semanticLabel: 'Delete project',
              transitionDuration: Duration.zero,
              builder: (context) {
                builderHasScope = MixScope.maybeOf(context) != null;
                return const Text('Scoped alert');
              },
            ),
            child: const Text('Open'),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pump();
      await tester.pump();

      expect(builderHasScope, isTrue);
      expect(find.text('Scoped alert'), findsOneWidget);
    });

    testWidgets('focuses the requested node and exposes one alert role', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      try {
        final initialFocusNode = FocusNode(debugLabel: 'safe alert action');
        addTearDown(initialFocusNode.dispose);

        await tester.pumpRemixApp(
          Builder(
            builder: (context) => TextButton(
              onPressed: () => showRemixAlertDialog<void>(
                context: context,
                semanticLabel: 'Delete project confirmation',
                transitionDuration: Duration.zero,
                initialFocusNode: initialFocusNode,
                builder: (context) => Center(
                  child: RemixDialog(
                    title: 'Delete project',
                    actions: [
                      TextButton(
                        focusNode: initialFocusNode,
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
                ),
              ),
              child: const Text('Open'),
            ),
          ),
        );

        await tester.tap(find.text('Open'));
        await tester.pump();
        await tester.pump();

        expect(initialFocusNode.hasFocus, isTrue);

        final root = tester
            .binding
            .renderViews
            .single
            .owner!
            .semanticsOwner!
            .rootSemanticsNode!;
        final alerts = _collectSemanticsNodes(
          root,
          (node) => node.getSemanticsData().role == SemanticsRole.alertDialog,
        );
        final dialogs = _collectSemanticsNodes(
          root,
          (node) => node.getSemanticsData().role == SemanticsRole.dialog,
        );

        expect(alerts, hasLength(1));
        expect(
          alerts.single.getSemanticsData().label,
          'Delete project confirmation',
        );
        expect(dialogs, isEmpty);
      } finally {
        semantics.dispose();
      }
    });
  });

  group('showRemixDialog', () {
    testWidgets('transitions through entering open exiting and closed states', (
      tester,
    ) async {
      final enteringValues = <double>[];
      final exitingValues = <double>[];
      var exiting = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => TextButton(
              onPressed: () => showRemixDialog<void>(
                context: context,
                barrierDismissible: false,
                transitionDuration: const Duration(milliseconds: 200),
                transitionBuilder: (context, animation, secondary, child) {
                  (exiting ? exitingValues : enteringValues).add(
                    animation.value,
                  );
                  return child;
                },
                builder: (context) =>
                    const RemixDialog(title: 'Animated dialog'),
              ),
              child: const Text('Open animated dialog'),
            ),
          ),
        ),
      );

      expect(find.text('Animated dialog'), findsNothing);
      await tester.tap(find.text('Open animated dialog'));
      await tester.pump();
      expect(find.text('Animated dialog'), findsOneWidget);
      expect(enteringValues.any((value) => value < 1), isTrue);

      await tester.pump(const Duration(milliseconds: 100));
      expect(enteringValues.any((value) => value > 0 && value < 1), isTrue);
      await tester.pumpAndSettle();
      expect(enteringValues, contains(1));

      exiting = true;
      Navigator.of(tester.element(find.text('Animated dialog'))).pop();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(exitingValues.any((value) => value > 0 && value < 1), isTrue);
      await tester.pumpAndSettle();
      expect(find.text('Animated dialog'), findsNothing);
      expect(exitingValues.any((value) => value == 0), isTrue);
    });

    testWidgets(
      'route barrier blocks background pointers for non-modal semantics',
      (tester) async {
        var backgroundPresses = 0;
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) => Column(
                children: [
                  TextButton(
                    onPressed: () => backgroundPresses++,
                    child: const Text('Background action'),
                  ),
                  TextButton(
                    onPressed: () => showRemixDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      transitionDuration: Duration.zero,
                      builder: (context) => const RemixDialog(
                        title: 'Semantic non-modal dialog',
                        modal: false,
                      ),
                    ),
                    child: const Text('Open non-modal semantics'),
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.tap(find.text('Open non-modal semantics'));
        await tester.pump();
        await tester.pump();
        await tester.tapAt(tester.getCenter(find.text('Background action')));
        await tester.pump();

        expect(backgroundPresses, 0);
        expect(find.text('Semantic non-modal dialog'), findsOneWidget);
      },
    );

    testWidgets('opens without a MixScope ancestor', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => TextButton(
              onPressed: () => showRemixDialog<void>(
                context: context,
                builder: (context) => const RemixDialog(title: 'Plain dialog'),
              ),
              child: const Text('Open'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.text('Plain dialog'), findsOneWidget);
    });

    testWidgets('passes a cloned MixScope to the dialog builder', (
      tester,
    ) async {
      bool builderHasScope = false;
      await tester.pumpRemixApp(
        Builder(
          builder: (context) => TextButton(
            onPressed: () => showRemixDialog<void>(
              context: context,
              builder: (context) {
                builderHasScope = MixScope.maybeOf(context) != null;
                return const RemixDialog(title: 'Scoped dialog');
              },
            ),
            child: const Text('Open'),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(builderHasScope, isTrue);
      expect(find.text('Scoped dialog'), findsOneWidget);
    });
  });

  group('RemixDialog', () {
    group('Basic Rendering', () {
      testWidgets('renders dialog with title only', (tester) async {
        await tester.pumpRemixApp(RemixDialog(title: 'Test Dialog'));
        await tester.pumpAndSettle();

        expect(find.byType(RemixDialog), findsOneWidget);
        expect(
          find.byKey(const ValueKey('remix-dialog-surface')),
          findsOneWidget,
        );
        expect(find.byType(StyledText), findsOneWidget);
        expect(find.text('Test Dialog'), findsOneWidget);
      });

      testWidgets('renders dialog with description only', (tester) async {
        await tester.pumpRemixApp(
          RemixDialog(description: 'Dialog Description'),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixDialog), findsOneWidget);
        expect(
          find.byKey(const ValueKey('remix-dialog-surface')),
          findsOneWidget,
        );
        expect(find.byType(StyledText), findsOneWidget);
        expect(find.text('Dialog Description'), findsOneWidget);
      });

      testWidgets('renders dialog with child only', (tester) async {
        final testChild = Icon(Icons.star, key: ValueKey('test_icon'));
        await tester.pumpRemixApp(RemixDialog(child: testChild));
        await tester.pumpAndSettle();

        expect(find.byType(RemixDialog), findsOneWidget);
        expect(
          find.byKey(const ValueKey('remix-dialog-surface')),
          findsOneWidget,
        );
        expect(find.byKey(ValueKey('test_icon')), findsOneWidget);
        expect(find.byIcon(Icons.star), findsOneWidget);
      });

      testWidgets('renders dialog with title and description', (tester) async {
        await tester.pumpRemixApp(
          RemixDialog(title: 'Dialog Title', description: 'Dialog Description'),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixDialog), findsOneWidget);
        expect(
          find.byKey(const ValueKey('remix-dialog-surface')),
          findsOneWidget,
        );
        expect(find.byType(StyledText), findsNWidgets(2));
        expect(find.text('Dialog Title'), findsOneWidget);
        expect(find.text('Dialog Description'), findsOneWidget);
      });

      testWidgets('renders dialog with all props', (tester) async {
        final actions = [
          TextButton(onPressed: () {}, child: Text('Cancel')),
          TextButton(onPressed: () {}, child: Text('OK')),
        ];

        await tester.pumpRemixApp(
          RemixDialog(
            title: 'Complete Dialog',
            description: 'Dialog with all elements',
            actions: actions,
            modal: true,
            semanticLabel: 'Complete Dialog',
            style: RemixDialogStyler.create(),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixDialog), findsOneWidget);
        expect(
          find.byKey(const ValueKey('remix-dialog-surface')),
          findsOneWidget,
        );
        expect(find.byType(StyledText), findsNWidgets(2));
        expect(find.byType(FlexBox), findsOneWidget);
        expect(find.text('Complete Dialog'), findsOneWidget);
        expect(find.text('Dialog with all elements'), findsOneWidget);
        expect(find.text('Cancel'), findsOneWidget);
        expect(find.text('OK'), findsOneWidget);
      });
    });

    group('Content Combinations', () {
      // child composes with other content; it must not override them.
      testWidgets('child composes with title and description', (tester) async {
        final testChild = Container(
          key: ValueKey('composed_child'),
          child: Text('Custom Child'),
        );
        await tester.pumpRemixApp(
          RemixDialog(
            title: 'Dialog Title',
            description: 'Dialog description',
            child: testChild,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixDialog), findsOneWidget);
        expect(find.byKey(ValueKey('composed_child')), findsOneWidget);
        expect(find.text('Custom Child'), findsOneWidget);
        expect(find.text('Dialog Title'), findsOneWidget);
        expect(find.text('Dialog description'), findsOneWidget);

        expect(
          tester.getTopLeft(find.text('Dialog Title')).dy,
          lessThan(tester.getTopLeft(find.text('Dialog description')).dy),
        );
        expect(
          tester.getTopLeft(find.text('Dialog description')).dy,
          lessThan(tester.getTopLeft(find.text('Custom Child')).dy),
        );
      });

      testWidgets('child composes with actions', (tester) async {
        await tester.pumpRemixApp(
          RemixDialog(
            child: Text('Body'),
            actions: [Text('Cancel'), Text('Delete')],
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Body'), findsOneWidget);
        expect(find.text('Cancel'), findsOneWidget);
        expect(find.text('Delete'), findsOneWidget);

        expect(
          tester.getTopLeft(find.text('Body')).dy,
          lessThan(tester.getTopLeft(find.text('Cancel')).dy),
        );
      });

      testWidgets('a lone child fills the container directly', (tester) async {
        await tester.pumpRemixApp(RemixDialog(child: Text('Only child')));
        await tester.pumpAndSettle();

        expect(find.text('Only child'), findsOneWidget);
        expect(
          find.descendant(
            of: find.byKey(const ValueKey('remix-dialog-surface')),
            matching: find.byType(Column),
          ),
          findsNothing,
          reason: 'a fully custom body keeps its own layout',
        );
      });

      testWidgets(
        'child composes with title, description, and actions in order',
        (tester) async {
          await tester.pumpRemixApp(
            RemixDialog(
              title: 'Title',
              description: 'Description',
              child: Text('Body'),
              actions: [TextButton(onPressed: () {}, child: Text('OK'))],
            ),
          );
          await tester.pumpAndSettle();

          final titleY = tester.getTopLeft(find.text('Title')).dy;
          final descY = tester.getTopLeft(find.text('Description')).dy;
          final bodyY = tester.getTopLeft(find.text('Body')).dy;
          final actionY = tester.getTopLeft(find.text('OK')).dy;

          expect(titleY, lessThan(descY));
          expect(descY, lessThan(bodyY));
          expect(bodyY, lessThan(actionY));
        },
      );

      testWidgets('title and description are rendered together', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          RemixDialog(
            title: 'Info Dialog',
            description: 'This is an informational dialog',
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixDialog), findsOneWidget);
        expect(
          find.byKey(const ValueKey('remix-dialog-surface')),
          findsOneWidget,
        );
        expect(find.byType(StyledText), findsNWidgets(2));
        expect(find.text('Info Dialog'), findsOneWidget);
        expect(find.text('This is an informational dialog'), findsOneWidget);
      });

      testWidgets('actions are rendered when provided', (tester) async {
        final actions = [
          TextButton(onPressed: () {}, child: Text('Action 1')),
          TextButton(onPressed: () {}, child: Text('Action 2')),
        ];

        await tester.pumpRemixApp(
          RemixDialog(title: 'Dialog with Actions', actions: actions),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixDialog), findsOneWidget);
        expect(
          find.byKey(const ValueKey('remix-dialog-surface')),
          findsOneWidget,
        );
        expect(find.byType(FlexBox), findsOneWidget);
        expect(find.text('Dialog with Actions'), findsOneWidget);
        expect(find.text('Action 1'), findsOneWidget);
        expect(find.text('Action 2'), findsOneWidget);
      });

      testWidgets('empty actions list does not render actions container', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          RemixDialog(title: 'Dialog without Actions', actions: []),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixDialog), findsOneWidget);
        expect(
          find.byKey(const ValueKey('remix-dialog-surface')),
          findsOneWidget,
        );
        expect(find.text('Dialog without Actions'), findsOneWidget);
        expect(find.byType(FlexBox), findsNothing);
      });
    });

    group('Modal Behavior', () {
      testWidgets('modal controls route-scoping accessibility semantics', (
        tester,
      ) async {
        final semantics = tester.ensureSemantics();
        try {
          await tester.pumpRemixApp(
            const RemixDialog(
              title: 'Modal content',
              semanticLabel: 'Modal route scope',
            ),
          );

          final modalData = tester
              .getSemantics(find.bySemanticsLabel('Modal route scope'))
              .getSemanticsData();
          expect(modalData.role, SemanticsRole.dialog);
          expect(modalData.flagsCollection.scopesRoute, isTrue);
          expect(modalData.flagsCollection.namesRoute, isTrue);
          expect(
            find.descendant(
              of: find.byType(RemixDialog),
              matching: find.byType(BlockSemantics),
            ),
            findsOneWidget,
          );

          await tester.pumpRemixApp(
            const RemixDialog(
              title: 'Non-modal content',
              semanticLabel: 'Non-modal semantic scope',
              modal: false,
            ),
          );

          final nonModalData = tester
              .getSemantics(find.bySemanticsLabel('Non-modal semantic scope'))
              .getSemanticsData();
          expect(nonModalData.role, SemanticsRole.dialog);
          expect(nonModalData.flagsCollection.scopesRoute, isFalse);
          expect(nonModalData.flagsCollection.namesRoute, isFalse);
          expect(
            find.descendant(
              of: find.byType(RemixDialog),
              matching: find.byType(BlockSemantics),
            ),
            findsNothing,
          );
        } finally {
          semantics.dispose();
        }
      });
    });

    group('Accessibility', () {
      testWidgets('dialog with semantic label uses provided label', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          RemixDialog(
            title: 'Dialog Title',
            semanticLabel: 'Custom Semantic Label',
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixDialog), findsOneWidget);
        expect(find.text('Dialog Title'), findsOneWidget);
      });

      testWidgets('dialog without semantic label uses title as label', (
        tester,
      ) async {
        await tester.pumpRemixApp(RemixDialog(title: 'Default Label Dialog'));
        await tester.pumpAndSettle();

        expect(find.byType(RemixDialog), findsOneWidget);
        expect(find.text('Default Label Dialog'), findsOneWidget);
      });

      testWidgets('dialog with child preserves child semantics', (
        tester,
      ) async {
        final testChild = Icon(Icons.star, semanticLabel: 'Star Icon');
        await tester.pumpRemixApp(RemixDialog(child: testChild));
        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.star), findsOneWidget);
        // Child semantics should be preserved
        final iconSemantics = tester.getSemantics(find.byIcon(Icons.star));
        expect(iconSemantics.label, contains('Star Icon'));
      });
    });

    group('Style Integration', () {
      testWidgets('applies custom style to container', (tester) async {
        final customStyle = RemixDialogStyler(
          container: BoxStyler(
            padding: EdgeInsetsGeometryMix.all(32.0),
            decoration: BoxDecorationMix(
              color: Colors.lightGreen,
              borderRadius: BorderRadiusGeometryMix.circular(16.0),
            ),
          ),
        );

        await tester.pumpRemixApp(
          RemixDialog(title: 'Styled Dialog', style: customStyle),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixDialog), findsOneWidget);
        expect(
          find.byKey(const ValueKey('remix-dialog-surface')),
          findsOneWidget,
        );
        expect(find.text('Styled Dialog'), findsOneWidget);
      });

      testWidgets('applies custom title style', (tester) async {
        final customStyle = RemixDialogStyler(
          title: TextStyler(
            style: TextStyleMix(
              color: Colors.red,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        );

        await tester.pumpRemixApp(
          RemixDialog(title: 'Styled Title', style: customStyle),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixDialog), findsOneWidget);
        expect(find.byType(StyledText), findsOneWidget);
        expect(find.text('Styled Title'), findsOneWidget);
      });

      testWidgets('applies custom description style', (tester) async {
        final customStyle = RemixDialogStyler(
          description: TextStyler(
            style: TextStyleMix(
              color: Colors.blue,
              fontSize: 14.0,
              fontStyle: FontStyle.italic,
            ),
          ),
        );

        await tester.pumpRemixApp(
          RemixDialog(description: 'Styled Description', style: customStyle),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixDialog), findsOneWidget);
        expect(find.byType(StyledText), findsOneWidget);
        expect(find.text('Styled Description'), findsOneWidget);
      });

      testWidgets('applies custom actions style', (tester) async {
        final customStyle = RemixDialogStyler(
          actions: FlexBoxStyler(
            spacing: 16.0,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        );

        final actions = [
          TextButton(onPressed: () {}, child: Text('Left')),
          TextButton(onPressed: () {}, child: Text('Right')),
        ];

        await tester.pumpRemixApp(
          RemixDialog(
            title: 'Styled Actions',
            actions: actions,
            style: customStyle,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixDialog), findsOneWidget);
        expect(find.byType(FlexBox), findsOneWidget);
        expect(find.text('Styled Actions'), findsOneWidget);
        expect(find.text('Left'), findsOneWidget);
        expect(find.text('Right'), findsOneWidget);
      });

      testWidgets('uses default style when none provided', (tester) async {
        await tester.pumpRemixApp(RemixDialog(title: 'Default Style Dialog'));
        await tester.pumpAndSettle();

        expect(find.byType(RemixDialog), findsOneWidget);
        expect(
          find.byKey(const ValueKey('remix-dialog-surface')),
          findsOneWidget,
        );
        expect(find.byType(StyledText), findsOneWidget);
        expect(find.text('Default Style Dialog'), findsOneWidget);
      });
    });

    group('Layout and Sizing', () {
      testWidgets('dialog adapts to content size', (tester) async {
        await tester.pumpRemixApp(RemixDialog(title: 'Short'));
        await tester.pumpAndSettle();

        final shortSize = tester.getSize(
          find.byKey(const ValueKey('remix-dialog-surface')),
        );

        await tester.pumpRemixApp(
          RemixDialog(
            title:
                'Much Longer Dialog Title That Should Make The Container Wider',
          ),
        );
        await tester.pumpAndSettle();

        final longSize = tester.getSize(
          find.byKey(const ValueKey('remix-dialog-surface')),
        );

        expect(longSize.width, greaterThan(shortSize.width));
      });

      testWidgets('dialog with actions is taller than title-only', (
        tester,
      ) async {
        await tester.pumpRemixApp(RemixDialog(title: 'Title Only'));
        await tester.pumpAndSettle();

        final titleOnlySize = tester.getSize(
          find.byKey(const ValueKey('remix-dialog-surface')),
        );

        final actions = [TextButton(onPressed: () {}, child: Text('Action'))];

        await tester.pumpRemixApp(
          RemixDialog(title: 'Title Only', actions: actions),
        );
        await tester.pumpAndSettle();

        final withActionsSize = tester.getSize(
          find.byKey(const ValueKey('remix-dialog-surface')),
        );

        expect(withActionsSize.height, greaterThan(titleOnlySize.height));
      });

      testWidgets('dialog with child adapts to child size', (tester) async {
        final smallChild = Icon(Icons.star, size: 16.0);
        await tester.pumpRemixApp(RemixDialog(child: smallChild));
        await tester.pumpAndSettle();

        final smallSize = tester.getSize(
          find.byKey(const ValueKey('remix-dialog-surface')),
        );

        final largeChild = Icon(Icons.star, size: 32.0);
        await tester.pumpRemixApp(RemixDialog(child: largeChild));
        await tester.pumpAndSettle();

        final largeSize = tester.getSize(
          find.byKey(const ValueKey('remix-dialog-surface')),
        );

        expect(largeSize.width, greaterThan(smallSize.width));
        expect(largeSize.height, greaterThan(smallSize.height));
      });
    });

    group('Edge Cases', () {
      testWidgets('handles empty title gracefully', (tester) async {
        await tester.pumpRemixApp(RemixDialog(title: ''));
        await tester.pumpAndSettle();

        expect(find.byType(RemixDialog), findsOneWidget);
        expect(
          find.byKey(const ValueKey('remix-dialog-surface')),
          findsOneWidget,
        );
        expect(find.byType(StyledText), findsOneWidget);
      });

      testWidgets('handles empty description gracefully', (tester) async {
        await tester.pumpRemixApp(RemixDialog(description: ''));
        await tester.pumpAndSettle();

        expect(find.byType(RemixDialog), findsOneWidget);
        expect(
          find.byKey(const ValueKey('remix-dialog-surface')),
          findsOneWidget,
        );
        expect(find.byType(StyledText), findsOneWidget);
      });

      testWidgets('handles null actions gracefully', (tester) async {
        await tester.pumpRemixApp(
          RemixDialog(title: 'No Actions', actions: null),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixDialog), findsOneWidget);
        expect(
          find.byKey(const ValueKey('remix-dialog-surface')),
          findsOneWidget,
        );
        expect(find.text('No Actions'), findsOneWidget);
        expect(find.byType(FlexBox), findsNothing);
      });

      test('assertion error when all content is null', () {
        expect(() => RemixDialog(), throwsAssertionError);
      });

      test(
        'assertion error when child, title, and description are all null',
        () {
          expect(
            () => RemixDialog(child: null, title: null, description: null),
            throwsAssertionError,
          );
        },
      );
    });
  });
}
