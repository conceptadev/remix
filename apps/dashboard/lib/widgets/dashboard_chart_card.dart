import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import 'page_header.dart';

/// Dashboard surface shared by overview and gallery charts.
class DashboardChartCard extends StatelessWidget {
  const DashboardChartCard({
    super.key,
    required this.title,
    required this.description,
    required this.chart,
    this.legend,
    this.chartPadding,
    this.chartPaddingKey,
  });

  final String title;
  final String description;
  final Widget chart;
  final Widget? legend;
  final EdgeInsets? chartPadding;
  final Key? chartPaddingKey;

  @override
  Widget build(BuildContext context) {
    final gap = MixScope.tokenOf(FortalTokens.space4, context);
    final defaultInset = MixScope.tokenOf(FortalTokens.space2, context);

    return FortalCard(
      size: .size2,
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          CardHeading(title: title, description: description),
          SizedBox(height: gap),
          Expanded(
            child: Padding(
              key: chartPaddingKey,
              padding:
                  chartPadding ?? EdgeInsets.symmetric(vertical: defaultInset),
              child: chart,
            ),
          ),
          if (legend case final legend?) ...[SizedBox(height: gap), legend],
        ],
      ),
    );
  }
}
