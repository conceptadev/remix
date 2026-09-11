import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_agent/remix_agent.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('decision actions exist only while permission is pending', (
    tester,
  ) async {
    Widget permission(AgentPermissionStatus status) => AgentPermission(
      tool: 'tool',
      status: status,
      onAllowOnce: () {},
      onAlwaysAllow: () {},
      onDeny: () {},
    );

    await pumpAgent(tester, permission(AgentPermissionStatus.pending));
    expect(find.text('Allow once'), findsOneWidget);
    expect(find.text('Always allow'), findsOneWidget);
    expect(find.text('Deny'), findsOneWidget);

    await pumpAgent(tester, permission(AgentPermissionStatus.running));
    expect(find.text('Allow once'), findsNothing);
    expect(find.text('Always allow'), findsNothing);
    expect(find.text('Deny'), findsNothing);
  });

  testWidgets('initial deciding status starts with details open', (
    tester,
  ) async {
    await pumpAgent(
      tester,
      const AgentPermission(
        tool: 'tool',
        status: AgentPermissionStatus.deciding,
        parameters: [RemixDataListItem(label: 'Command', value: 'test')],
      ),
    );

    expect(find.text('test'), findsOneWidget);
  });

  testWidgets('details use the requested parameter orientation', (
    tester,
  ) async {
    await pumpAgent(
      tester,
      const AgentPermission(
        tool: 'tool',
        defaultDetailsExpanded: true,
        parameterOrientation: Axis.vertical,
        parameters: [RemixDataListItem(label: 'Command', value: 'test')],
      ),
    );

    expect(
      tester.widget<RemixDataList>(find.byType(RemixDataList)).orientation,
      Axis.vertical,
    );
  });

  testWidgets('status and indicator builders replace functional defaults', (
    tester,
  ) async {
    await pumpAgent(
      tester,
      AgentPermission(
        tool: 'tool',
        parameters: const [RemixDataListItem(label: 'Command', value: 'test')],
        statusBuilder: (context, status) =>
            const SizedBox(key: ValueKey('custom-permission-status')),
        indicatorBuilder: (context, expanded) =>
            const SizedBox(key: ValueKey('custom-permission-indicator')),
      ),
    );

    expect(
      find.byKey(const ValueKey('custom-permission-status')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('custom-permission-indicator')),
      findsOneWidget,
    );
  });
}
