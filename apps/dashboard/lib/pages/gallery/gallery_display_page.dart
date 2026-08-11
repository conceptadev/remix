import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../../utils/text.dart';
import '../../widgets/gallery_scaffold.dart';

class GalleryDisplayPage extends StatefulWidget {
  const GalleryDisplayPage({super.key});

  @override
  State<GalleryDisplayPage> createState() => _GalleryDisplayPageState();
}

class _GalleryDisplayPageState extends State<GalleryDisplayPage> {
  bool _spinnersRunning = false;
  bool _skeletonLoading = true;

  @override
  Widget build(BuildContext context) {
    return GalleryPage(
      title: 'Data Display',
      intro: 'Rich surfaces and status components for product interfaces.',
      sections: [
        GallerySection(
          label: 'Avatar',
          description:
              'Two visual variants across all nine Radix-compatible sizes.',
          child: GalleryMatrix(
            rows: FortalAvatarVariant.values.map(enumLabel).toList(),
            columns: FortalAvatarSize.values.map(enumLabel).toList(),
            cellWidth: 120,
            cellBuilder: (_, row, column) => FortalAvatar(
              variant: FortalAvatarVariant.values[row],
              size: FortalAvatarSize.values[column],
              label: 'RF',
            ),
          ),
        ),
        GallerySection(
          label: 'Badge',
          description:
              'Status labels in solid, soft, surface, and outline variants.',
          child: GalleryMatrix(
            rows: FortalBadgeVariant.values.map(enumLabel).toList(),
            columns: FortalBadgeSize.values.map(enumLabel).toList(),
            cellBuilder: (_, row, column) => FortalBadge(
              variant: FortalBadgeVariant.values[row],
              size: FortalBadgeSize.values[column],
              label: 'Active',
            ),
          ),
        ),
        GallerySection(
          label: 'Card',
          description:
              'Surface, classic, and ghost containers across five spacing sizes.',
          child: GalleryMatrix(
            rows: FortalCardVariant.values.map(enumLabel).toList(),
            columns: FortalCardSize.values.map(enumLabel).toList(),
            cellWidth: 200,
            cellBuilder: (_, row, column) => SizedBox(
              width: 160,
              child: FortalCard(
                variant: FortalCardVariant.values[row],
                size: FortalCardSize.values[column],
                child: const FortalText('Card content', size: .size2),
              ),
            ),
          ),
        ),
        GallerySection(
          label: 'Callout',
          description: 'Contextual information in every variant and size.',
          child: GalleryMatrix(
            rows: FortalCalloutVariant.values.map(enumLabel).toList(),
            columns: FortalCalloutSize.values.map(enumLabel).toList(),
            cellWidth: 230,
            cellBuilder: (_, row, column) => SizedBox(
              width: 200,
              child: FortalCallout(
                variant: FortalCalloutVariant.values[row],
                size: FortalCalloutSize.values[column],
                text: 'A helpful callout message.',
              ),
            ),
          ),
        ),
        GallerySection(
          label: 'Data list',
          description:
              'Label and value pairs at every size, horizontal and vertical.',
          child: GalleryMatrix(
            rows: const ['Horizontal', 'Vertical'],
            columns: FortalDataListSize.values.map(enumLabel).toList(),
            cellWidth: 250,
            cellBuilder: (_, row, column) => FortalDataList(
              size: FortalDataListSize.values[column],
              orientation: row == 0 ? Axis.horizontal : Axis.vertical,
              items: const [
                RemixDataListItem(
                  label: 'Status',
                  child: FortalBadge(label: 'Active'),
                ),
                RemixDataListItem(label: 'Plan', value: 'Enterprise'),
                RemixDataListItem(label: 'Seats', value: '48'),
              ],
            ),
          ),
        ),
        GallerySection(
          label: 'Skeleton',
          description:
              'Placeholder shapes that keep the loaded layout measurements.',
          child: Column(
            crossAxisAlignment: .start,
            spacing: 14,
            children: [
              FortalButton.soft(
                size: .size1,
                onPressed: () =>
                    setState(() => _skeletonLoading = !_skeletonLoading),
                label: _skeletonLoading ? 'Show content' : 'Show skeleton',
              ),
              FortalSkeleton(
                loading: _skeletonLoading,
                child: const FortalAvatar(label: 'RF', size: .size5),
              ),
              FortalSkeleton(
                loading: _skeletonLoading,
                child: const FortalText(
                  'Loaded content replaces the placeholder.',
                  size: .size2,
                ),
              ),
            ],
          ),
        ),
        GallerySection(
          label: 'Progress',
          description:
              'Determinate progress with classic, surface, and soft treatments.',
          child: GalleryMatrix(
            rows: FortalProgressVariant.values.map(enumLabel).toList(),
            columns: FortalProgressSize.values.map(enumLabel).toList(),
            cellWidth: 210,
            cellBuilder: (_, row, column) => SizedBox(
              width: 170,
              child: FortalProgress(
                variant: FortalProgressVariant.values[row],
                size: FortalProgressSize.values[column],
                value: 0.68,
                semanticsLabel: '68 percent complete',
              ),
            ),
          ),
        ),
        GallerySection(
          label: 'Spinner',
          description:
              'Animation is stopped by default so automated tests remain settleable.',
          child: Row(
            spacing: 18,
            children: [
              FortalButton.soft(
                size: .size1,
                onPressed: () =>
                    setState(() => _spinnersRunning = !_spinnersRunning),
                label: _spinnersRunning ? 'Stop' : 'Start',
              ),
              for (final size in FortalSpinnerSize.values)
                if (_spinnersRunning)
                  FortalSpinner(size: size, semanticsLabel: 'Loading example')
                else
                  const Icon(Icons.check, size: 16),
            ],
          ),
        ),
        GallerySection(
          label: 'Divider',
          description: 'Horizontal dividers at all four inset sizes.',
          child: Column(
            spacing: 14,
            children: [
              for (final size in FortalDividerSize.values)
                Row(
                  spacing: 12,
                  children: [
                    SizedBox(
                      width: 64,
                      child: FortalText(enumLabel(size), size: .size2),
                    ),
                    Expanded(child: FortalDivider(size: size)),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
