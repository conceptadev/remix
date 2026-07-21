import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

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
                    style: TextStyler(
                      style: FortalTokens.text2.mix(),
                    ).color(FortalTokens.gray11()),
                  ),
                ),
                Container(
                  width: 34,
                  height: 34,
                  alignment: .center,
                  decoration: BoxDecoration(
                    color: MixScope.tokenOf(FortalTokens.accentA3, context),
                    borderRadius: BorderRadius.all(
                      MixScope.tokenOf(FortalTokens.radius3, context),
                    ),
                  ),
                  child: Icon(
                    icon,
                    size: 18,
                    color: MixScope.tokenOf(FortalTokens.accent11, context),
                  ),
                ),
              ],
            ),
            StyledText(
              value,
              style: TextStyler(
                style: FortalTokens.text7.mix(),
              ).fontWeight(.w700).color(FortalTokens.gray12()),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                FortalBadge(
                  color: positive ? .green : .red,
                  child: Text(
                    '${positive ? '↑' : '↓'} ${delta.abs().toStringAsFixed(1)}%',
                  ),
                ),
                StyledText(
                  'vs last month',
                  style: TextStyler(
                    style: FortalTokens.text1.mix(),
                  ).color(FortalTokens.gray11()),
                ),
              ],
            ),
            if (progress case final value?)
              FortalProgress(
                value: value,
                max: 100,
                size: .size1,
                semanticLabel: '$label progress',
              ),
          ],
        ),
      ),
    );
  }
}
