import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import 'page_header.dart';

/// Dashboard surface shared by overview and gallery charts.
///
/// Mix charts have no intrinsic height, so the plot is given a finite
/// [plotHeight]. Auto Grid rows then size to the card (title + plot +
/// optional legend) instead of a padded-card magic number.
class DashboardChartCard extends StatelessWidget {
  const DashboardChartCard({
    super.key,
    required this.title,
    required this.description,
    required this.chart,
    this.legend,
    this.chartPadding,
    this.chartPaddingKey,
    this.plotHeight = 220,
  });

  final String title;
  final String description;
  final Widget chart;
  final Widget? legend;
  final EdgeInsets? chartPadding;
  final Key? chartPaddingKey;

  /// Logical plot height, scaled by the live Fortal scaling factor.
  final double plotHeight;

  @override
  Widget build(BuildContext context) {
    final gap = MixScope.tokenOf(FortalTokens.space4, context);
    final defaultInset = MixScope.tokenOf(FortalTokens.space2, context);
    final scaledPlot = plotHeight * FortalTheme.of(context).scaling.factor;

    return FortalCard(
      size: .size2,
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          CardHeading(title: title, description: description),
          SizedBox(height: gap),
          SizedBox(
            height: scaledPlot,
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
