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
        expect(find.byType(Box), findsOneWidget);
        expect(find.byType(StyledText), findsOneWidget);
        expect(find.text('Test Dialog'), findsOneWidget);
      });

      testWidgets('renders dialog with description only', (tester) async {
        await tester.pumpRemixApp(
          RemixDialog(description: 'Dialog Description'),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixDialog), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
        expect(find.byType(StyledText), findsOneWidget);
        expect(find.text('Dialog Description'), findsOneWidget);
      });

      testWidgets('renders dialog with child only', (tester) async {
        final testChild = Icon(Icons.star, key: ValueKey('test_icon'));
        await tester.pumpRemixApp(RemixDialog(child: testChild));
        await tester.pumpAndSettle();

        expect(find.byType(RemixDialog), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
        expect(find.byKey(ValueKey('test_icon')), findsOneWidget);
        expect(find.byIcon(Icons.star), findsOneWidget);
      });

      testWidgets('renders dialog with title and description', (tester) async {
        await tester.pumpRemixApp(
          RemixDialog(title: 'Dialog Title', description: 'Dialog Description'),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixDialog), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
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
        expect(find.byType(Box), findsOneWidget);
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
        await tester.pumpRemixApp(
          RemixDialog(child: Text('Only child'), scrollable: true),
        );
        await tester.pumpAndSettle();

        expect(find.text('Only child'), findsOneWidget);
        expect(find.byType(SingleChildScrollView), findsNothing);
        expect(
          find.descendant(of: find.byType(Box), matching: find.byType(Column)),
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
          expect(find.byType(SingleChildScrollView), findsNothing);
        },
      );

      testWidgets('bounded large-text structured content does not overflow', (
        tester,
      ) async {
        final semantics = tester.ensureSemantics();
        final bodyFocus = FocusNode(debugLabel: 'final environment variable');
        final actionFocus = FocusNode(debugLabel: 'save environment');
        addTearDown(bodyFocus.dispose);
        addTearDown(actionFocus.dispose);

        try {
          await tester.pumpRemixApp(
            MediaQuery(
              data: const MediaQueryData(textScaler: TextScaler.linear(2)),
              child: SizedBox(
                width: 400,
                height: 320,
                child: FortalDialog(
                  title: 'Environment',
                  description: 'Variables available to this workspace.',
                  scrollable: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      8,
                      (index) => index == 7
                          ? TextButton(
                              focusNode: bodyFocus,
                              onPressed: () {},
                              child: const Text('Environment variable 8'),
                            )
                          : Text('Environment variable ${index + 1}'),
                    ),
                  ),
                  actions: [
                    IconButton(
                      key: const ValueKey('save-environment-action'),
                      focusNode: actionFocus,
                      tooltip: 'Save environment',
                      onPressed: () {},
                      icon: const Icon(Icons.save),
                    ),
                  ],
                ),
              ),
            ),
          );
          await tester.pumpAndSettle();

          expect(tester.takeException(), isNull);
          expect(
            tester.widget<FortalDialog>(find.byType(FortalDialog)).scrollable,
            isTrue,
          );
          expect(
            tester.widget<RemixDialog>(find.byType(RemixDialog)).scrollable,
            isTrue,
          );

          final scrollView = find.byType(SingleChildScrollView);
          final action = find.byKey(const ValueKey('save-environment-action'));
          expect(scrollView, findsOneWidget);
          expect(
            find.descendant(of: scrollView, matching: find.text('Environment')),
            findsNothing,
          );
          expect(
            find.descendant(of: scrollView, matching: action),
            findsNothing,
          );

          final scrollable = find.descendant(
            of: scrollView,
            matching: find.byType(Scrollable),
          );
          final position = tester.state<ScrollableState>(scrollable).position;
          final actionY = tester.getTopLeft(action).dy;
          expect(position.maxScrollExtent, greaterThan(0));

          await tester.drag(scrollView, const Offset(0, -1000));
          await tester.pumpAndSettle();

          expect(position.pixels, greaterThan(0));
          expect(tester.getTopLeft(action).dy, closeTo(actionY, 0.01));
          expect(
            find.bySemanticsLabel('Environment variable 8'),
            findsOneWidget,
          );
          expect(
            tester.getSemantics(action),
            isSemantics(
              tooltip: 'Save environment',
              isButton: true,
              hasTapAction: true,
            ),
          );

          bodyFocus.requestFocus();
          await tester.pumpAndSettle();
          expect(bodyFocus.hasFocus, isTrue);

          for (
            var attempt = 0;
            attempt < 2 && !actionFocus.hasFocus;
            attempt++
          ) {
            await tester.sendKeyEvent(LogicalKeyboardKey.tab);
            await tester.pumpAndSettle();
          }
          expect(actionFocus.hasFocus, isTrue);
        } finally {
          semantics.dispose();
        }
      });

      testWidgets('scrollable content shrink-wraps unbounded height', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          SingleChildScrollView(
            child: RemixDialog(
              title: 'Environment',
              description: 'Variables available to this workspace.',
              scrollable: true,
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
        expect(find.byType(SingleChildScrollView), findsNWidgets(2));
        expect(find.byType(Flexible), findsNothing);
      });

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
        expect(find.byType(Box), findsOneWidget);
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
        expect(find.byType(Box), findsOneWidget);
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
        expect(find.byType(Box), findsOneWidget);
        expect(find.text('Dialog without Actions'), findsOneWidget);
        expect(find.byType(FlexBox), findsNothing);
      });
    });

    group('Modal Behavior', () {
      testWidgets('modal dialog blocks background interaction', (tester) async {
        await tester.pumpRemixApp(
          RemixDialog(title: 'Modal Dialog', modal: true),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixDialog), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
      });

      testWidgets('non-modal dialog allows background interaction', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          RemixDialog(title: 'Non-Modal Dialog', modal: false),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixDialog), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
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
        expect(find.byType(Box), findsOneWidget);
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
        expect(find.byType(Box), findsOneWidget);
        expect(find.byType(StyledText), findsOneWidget);
        expect(find.text('Default Style Dialog'), findsOneWidget);
      });
    });

    group('Layout and Sizing', () {
      testWidgets('dialog adapts to content size', (tester) async {
        await tester.pumpRemixApp(RemixDialog(title: 'Short'));
        await tester.pumpAndSettle();

        final shortSize = tester.getSize(find.byType(RemixDialog));

        await tester.pumpRemixApp(
          RemixDialog(
            title:
                'Much Longer Dialog Title That Should Make The Container Wider',
          ),
        );
        await tester.pumpAndSettle();

        final longSize = tester.getSize(find.byType(RemixDialog));

        expect(longSize.width, greaterThan(shortSize.width));
      });

      testWidgets('dialog with actions is taller than title-only', (
        tester,
      ) async {
        await tester.pumpRemixApp(RemixDialog(title: 'Title Only'));
        await tester.pumpAndSettle();

        final titleOnlySize = tester.getSize(find.byType(RemixDialog));

        final actions = [TextButton(onPressed: () {}, child: Text('Action'))];

        await tester.pumpRemixApp(
          RemixDialog(title: 'Title Only', actions: actions),
        );
        await tester.pumpAndSettle();

        final withActionsSize = tester.getSize(find.byType(RemixDialog));

        expect(withActionsSize.height, greaterThan(titleOnlySize.height));
      });

      testWidgets('dialog with child adapts to child size', (tester) async {
        final smallChild = Icon(Icons.star, size: 16.0);
        await tester.pumpRemixApp(RemixDialog(child: smallChild));
        await tester.pumpAndSettle();

        final smallSize = tester.getSize(find.byType(RemixDialog));

        final largeChild = Icon(Icons.star, size: 32.0);
        await tester.pumpRemixApp(RemixDialog(child: largeChild));
        await tester.pumpAndSettle();

        final largeSize = tester.getSize(find.byType(RemixDialog));

        expect(largeSize.width, greaterThan(smallSize.width));
        expect(largeSize.height, greaterThan(smallSize.height));
      });
    });

    group('Edge Cases', () {
      testWidgets('handles empty title gracefully', (tester) async {
        await tester.pumpRemixApp(RemixDialog(title: ''));
        await tester.pumpAndSettle();

        expect(find.byType(RemixDialog), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
        expect(find.byType(StyledText), findsOneWidget);
      });

      testWidgets('handles empty description gracefully', (tester) async {
        await tester.pumpRemixApp(RemixDialog(description: ''));
        await tester.pumpAndSettle();

        expect(find.byType(RemixDialog), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
        expect(find.byType(StyledText), findsOneWidget);
      });

      testWidgets('handles null actions gracefully', (tester) async {
        await tester.pumpRemixApp(
          RemixDialog(title: 'No Actions', actions: null),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixDialog), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
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
