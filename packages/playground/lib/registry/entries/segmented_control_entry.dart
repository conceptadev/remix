import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

Widget buildSegmentedControlExample() {
  return const SizedBox(width: 340, child: _RemixSegmentedControlPreview());
}

class _RemixSegmentedControlPreview extends StatefulWidget {
  const _RemixSegmentedControlPreview();

  @override
  State<_RemixSegmentedControlPreview> createState() =>
      _RemixSegmentedControlPreviewState();
}

class _RemixSegmentedControlPreviewState
    extends State<_RemixSegmentedControlPreview> {
  String _period = 'week';
  String _view = 'grid';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        FortalSegmentedControl<String>.surface(
          semanticLabel: 'Reporting period',
          items: const [
            RemixSegmentedControlItem(value: 'day', label: 'Day'),
            RemixSegmentedControlItem(value: 'week', label: 'This week'),
            RemixSegmentedControlItem(value: 'month', label: 'Month'),
            RemixSegmentedControlItem(
              value: 'year',
              label: 'Year',
              enabled: false,
            ),
          ],
          selectedValue: _period,
          onChanged: (value) => setState(() => _period = value),
        ),
        const SizedBox(height: 8),
        Text('Selected: $_period'),
        const SizedBox(height: 20),
        FortalSegmentedControl<String>.classic(
          semanticLabel: 'Layout',
          items: const [
            RemixSegmentedControlItem(
              value: 'list',
              icon: Icons.view_list,
              semanticLabel: 'List view',
            ),
            RemixSegmentedControlItem(
              value: 'grid',
              icon: Icons.grid_view,
              semanticLabel: 'Grid view',
            ),
            RemixSegmentedControlItem(
              value: 'board',
              icon: Icons.view_kanban,
              semanticLabel: 'Board view',
            ),
          ],
          selectedValue: _view,
          onChanged: (value) => setState(() => _view = value),
        ),
      ],
    );
  }
}
