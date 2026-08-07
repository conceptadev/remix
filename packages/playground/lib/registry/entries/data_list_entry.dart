import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

import '../../widgets/comparison_view.dart';

Widget buildDataListExample() {
  const metadata = [
    RemixDataListItem(label: 'Name', value: 'Leo Farias'),
    RemixDataListItem(label: 'Email', value: 'leo@example.com'),
    RemixDataListItem(
      label: 'Bio',
      value: 'Building composable Flutter design systems with Mix and Remix.',
    ),
  ];

  Widget materialRow(String label, String value) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      crossAxisAlignment: .start,
      children: [
        SizedBox(
          width: 96,
          child: Text(label, style: const TextStyle(color: Colors.grey)),
        ),
        const SizedBox(width: 24),
        Expanded(child: Text(value)),
      ],
    ),
  );

  return SizedBox(
    width: 640,
    child: ComparisonView(
      remix: [
        // Horizontal: one shared label column, wrapping values, and custom
        // value children (a display-only badge and an interactive button).
        SizedBox(
          width: 280,
          child: FortalDataList(
            semanticLabel: 'Account details',
            items: [
              ...metadata,
              const RemixDataListItem(
                label: 'Status',
                semanticValue: 'Authorized',
                alignment: RemixDataListItemAlignment.center,
                child: FortalBadge(label: 'Authorized'),
              ),
              RemixDataListItem(
                label: 'API key',
                alignment: RemixDataListItemAlignment.center,
                child: FortalButton.soft(
                  size: .size1,
                  label: 'Reveal',
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
        // Vertical: the caller-owned fallback for narrow widths.
        SizedBox(
          width: 200,
          child: FortalDataList(orientation: Axis.vertical, items: metadata),
        ),
      ],
      material: [
        SizedBox(
          width: 280,
          child: Column(
            mainAxisSize: .min,
            children: [
              materialRow('Name', 'Leo Farias'),
              materialRow('Email', 'leo@example.com'),
              materialRow(
                'Bio',
                'Building composable Flutter design systems with Mix and '
                    'Remix.',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
