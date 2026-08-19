import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_agent/remix_agent.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('pending offers allow once, always allow, and deny', (
    tester,
  ) async {
    final decisions = <String>[];
    await pumpAgent(
      tester,
      SizedBox(
        width: 420,
        child: AgentPermission(
          tool: 'terminal.run',
          description: 'Run the test suite.',
          parameters: const [
            AgentPermissionParameter(
              id: 'cmd',
              label: 'Command',
              value: 'flutter test',
            ),
          ],
          onAllowOnce: () => decisions.add('once'),
          onAlwaysAllow: () => decisions.add('always'),
          onDeny: () => decisions.add('deny'),
        ),
      ),
    );

    expect(find.text('Allow this tool to run?'), findsOneWidget);
    expect(find.text('Allow terminal.run to run?'), findsNothing);
    expect(find.text('Permission required'), findsOneWidget);
    expect(find.text('View details'), findsOneWidget);
    expect(find.text('Details'), findsNothing);
    expect(find.text('Allow once'), findsOneWidget);
    expect(find.text('Always allow'), findsOneWidget);
    expect(find.text('Deny'), findsOneWidget);
    expect(find.text('Command'), findsNothing);
    expect(find.text('flutter test'), findsNothing);
    expect(find.byType(RemixDataList), findsNothing);
    expect(find.byType(RemixBadge), findsOneWidget);

    await tester.tap(find.text('View details'));
    await tester.pump();
    expect(find.text('Command'), findsOneWidget);
    expect(find.text('flutter test'), findsOneWidget);
    expect(find.text('Commandflutter test'), findsNothing);

    await tester.tap(find.text('Allow once'));
    await tester.pump();
    expect(decisions, ['once']);
  });

  testWidgets('denied hides actions and stays in the transcript', (
    tester,
  ) async {
    var denied = false;
    await pumpAgent(
      tester,
      SizedBox(
        width: 420,
        child: AgentPermission(
          tool: 'fs.write',
          status: AgentPermissionStatus.denied,
          onDeny: () => denied = true,
        ),
      ),
    );

    expect(find.text('Deny'), findsNothing);
    expect(find.text('Allow once'), findsNothing);
    expect(find.text('Permission required'), findsNothing);
    expect(find.text('Denied'), findsOneWidget);
    expect(denied, isFalse);
  });

  testWidgets('deny callback fires from the shipped button', (tester) async {
    var denied = false;
    await pumpAgent(
      tester,
      SizedBox(
        width: 420,
        child: AgentPermission(tool: 'net.fetch', onDeny: () => denied = true),
      ),
    );

    expect(find.text('Always allow'), findsNothing);
    expect(
      find.byKey(const ValueKey('agent-permission-always-allow')),
      findsNothing,
    );

    await tester.tap(find.byKey(const ValueKey('agent-permission-deny')));
    await tester.pump();
    expect(denied, isTrue);
  });

  testWidgets('deciding keeps details open and not toggleable', (tester) async {
    await pumpAgent(
      tester,
      const SizedBox(
        width: 420,
        child: AgentPermission(
          tool: 'terminal.run',
          status: AgentPermissionStatus.deciding,
          parameters: [
            AgentPermissionParameter(
              id: 'cmd',
              label: 'Command',
              value: 'flutter test',
            ),
          ],
        ),
      ),
    );

    expect(find.text('Command'), findsOneWidget);
    await tester.tap(find.text('View details'));
    await tester.pump();
    expect(find.text('Command'), findsOneWidget);
  });

  testWidgets('uses a 32px well, title-row chip, and 7rem-max label', (
    tester,
  ) async {
    await pumpAgent(
      tester,
      const SizedBox(
        width: 420,
        child: AgentPermission(
          tool: 'terminal.run',
          description: 'Run the test suite.',
          detailsOpen: true,
          parameters: [
            AgentPermissionParameter(
              id: 'cmd',
              label: 'Command',
              value: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
            ),
            AgentPermissionParameter(
              id: 'dir',
              label: 'WorkingDirectoryPathName',
              value: 'packages/remix_agent',
            ),
          ],
        ),
      ),
    );

    final card = find.descendant(
      of: find.byType(AgentPermission),
      matching: find.byType(RemixCard),
    );
    final cardRect = tester.getRect(card);
    final titleRect = tester.getRect(find.text('Allow this tool to run?'));
    expect(titleRect.left - cardRect.left, closeTo(60, 1.5));
    expect(titleRect.top - cardRect.top, closeTo(16, 1.5));

    final well = tester.getSize(
      find.byKey(const ValueKey('agent-permission-status-well')),
    );
    expect(well.width, 32);
    expect(well.height, 32);

    expect(find.byType(ClipPath), findsWidgets);

    expect(
      find.byKey(const ValueKey('agent-permission-footer')),
      findsOneWidget,
    );
    final footer = tester.widget<DecoratedBox>(
      find.byKey(const ValueKey('agent-permission-footer')),
    );
    final border = (footer.decoration as BoxDecoration).border as Border;
    expect(border.top.width, greaterThan(0));

    final label = tester.getSize(
      find.byKey(const ValueKey('agent-permission-label-cmd')),
    );
    final longLabel = tester.getSize(
      find.byKey(const ValueKey('agent-permission-label-dir')),
    );
    expect(label.width, closeTo(112, 1.5));
    expect(longLabel.width, closeTo(112, 1.5));
    expect(
      tester
          .getTopLeft(find.byKey(const ValueKey('agent-permission-label-cmd')))
          .dx,
      closeTo(
        tester
            .getTopLeft(
              find.byKey(const ValueKey('agent-permission-label-dir')),
            )
            .dx,
        0.5,
      ),
    );

    final trigger = tester.getRect(find.text('View details'));
    final parameters = tester.getRect(
      find.byKey(const ValueKey('agent-permission-parameters')),
    );
    expect(parameters.top - trigger.bottom, closeTo(16, 1.5));

    final value = tester.getSize(
      find.byKey(const ValueKey('agent-permission-value-cmd')),
    );
    expect(value.height, greaterThan(16));

    final allow = tester.renderObject<RenderParagraph>(find.text('Allow once'));
    expect(allow.text.style?.fontSize, 12);
  });

  testWidgets('view details hovers muted to ink', (tester) async {
    await pumpAgent(
      tester,
      const SizedBox(
        width: 420,
        child: AgentPermission(
          tool: 'terminal.run',
          parameters: [
            AgentPermissionParameter(
              id: 'cmd',
              label: 'Command',
              value: 'flutter test',
            ),
          ],
        ),
      ),
    );

    final idle = tester
        .renderObject<RenderParagraph>(find.text('View details'))
        .text
        .style!
        .color!;
    expect(idle, isNot(const Color(0xFF18181B)));

    final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await gesture.addPointer(location: Offset.zero);
    addTearDown(gesture.removePointer);
    await tester.pump();
    await gesture.moveTo(tester.getCenter(find.text('View details')));
    await tester.pump();

    final hovered = tester
        .renderObject<RenderParagraph>(find.text('View details'))
        .text
        .style!
        .color!;
    expect(hovered, const Color(0xFF18181B));
  });

  testWidgets('view details paints a 2px focus-visible ring', (tester) async {
    await pumpAgent(
      tester,
      const SizedBox(
        width: 420,
        child: AgentPermission(
          tool: 'terminal.run',
          parameters: [
            AgentPermissionParameter(
              id: 'cmd',
              label: 'Command',
              value: 'flutter test',
            ),
          ],
        ),
      ),
    );

    FocusManager.instance.highlightStrategy =
        FocusHighlightStrategy.alwaysTraditional;
    addTearDown(() {
      FocusManager.instance.highlightStrategy =
          FocusHighlightStrategy.automatic;
    });

    final node = Focus.of(
      tester.element(
        find.byKey(const ValueKey('agent-permission-details-trigger')),
      ),
    );
    node.requestFocus();
    await tester.pump();
    await tester.pump();

    final ringed = tester
        .widgetList<Container>(
          find.descendant(
            of: find.byKey(const ValueKey('agent-permission-details-trigger')),
            matching: find.byType(Container),
          ),
        )
        .where((container) => container.foregroundDecoration != null);
    expect(ringed, isNotEmpty);
    final decoration = ringed.first.foregroundDecoration! as BoxDecoration;
    final border = decoration.border! as Border;
    expect(border.top.width, kAgentFocusRingWidth);
    expect(border.top.color, const Color(0xFF18181B));
    expect(decoration.borderRadius, BorderRadius.circular(6));
  });
}
