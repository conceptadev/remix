import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Workspace navigation', type: RemixSidebar)
Widget buildSidebarUseCase(BuildContext context) => const SidebarExample();

class SidebarExample extends StatefulWidget {
  const SidebarExample({super.key});

  @override
  State<SidebarExample> createState() => _SidebarExampleState();
}

class _SidebarExampleState extends State<SidebarExample> {
  String _selected = 'Overview';

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: SizedBox(
        width: 256,
        height: 320,
        child: FortalSidebar<String>(
          sections: const [
            RemixSidebarSection(
              label: 'Workspace',
              destinations: [
                RemixSidebarDestination(
                  value: 'Overview',
                  label: 'Overview',
                  icon: Icons.space_dashboard_outlined,
                ),
                RemixSidebarDestination(
                  value: 'Settings',
                  label: 'Settings',
                  icon: Icons.settings_outlined,
                ),
                RemixSidebarDestination(
                  value: 'Billing',
                  label: 'Billing',
                  icon: Icons.credit_card,
                  enabled: false,
                ),
              ],
            ),
          ],
          selectedValue: _selected,
          onSelected: (value) => setState(() => _selected = value),
          semanticLabel: 'Workspace navigation',
          footer: Text('Selected: $_selected'),
        ),
      ),
    ),
  );
}
