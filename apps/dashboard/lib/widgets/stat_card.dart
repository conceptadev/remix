import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import 'typography.dart';

class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.label,
    required this.value,
    required this.delta,
    required this.icon,
    this.progress,
  });

  final String label;
  final String value;
  final double delta;
  final IconData icon;
  final double? progress;

  @override
  Widget build(BuildContext context) {
    final positive = delta >= 0;
    return FortalCard(
      size: .size2,
      child: SizedBox(
        width: 220,
        child: Column(
          crossAxisAlignment: .stretch,
          spacing: 12,
          children: [
            Row(
              children: [
                Expanded(
                  child: StyledText(
                    label,
                    style: dashboardText(.size2, tone: .muted),
                  ),
                ),
                FortalAvatar.soft(icon: icon, size: .size2),
              ],
            ),
            DashboardTextTone(
              child: FortalText(value, size: .size7, weight: .bold),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                FortalScope(
                  accent: positive ? .green : .red,
                  hasBackground: false,
                  child: FortalBadge(
                    label:
                        '${positive ? '↑' : '↓'} ${delta.abs().toStringAsFixed(1)}%',
                  ),
                ),
                StyledText(
                  'vs last month',
                  style: dashboardText(.size1, tone: .muted),
                ),
              ],
            ),
            if (progress case final value?)
              FortalProgress(
                value: value / 100,
                size: .size1,
                semanticsLabel: '$label progress',
              ),
          ],
        ),
      ),
    );
  }
}
