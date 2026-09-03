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
          child: GalleryEnumMatrix(
            rows: FortalAvatarVariant.values,
            columns: FortalAvatarSize.values,
            // Size9 is 160px; preserve its 20px cell padding and divider.
            cellWidth: 181,
            cellBuilder: (_, variant, size) =>
                FortalAvatar(variant: variant, size: size, label: 'RF'),
          ),
        ),
        GallerySection(
          label: 'Badge',
          description:
              'Status labels in solid, soft, surface, and outline variants.',
          child: GalleryEnumMatrix(
            rows: FortalBadgeVariant.values,
            columns: FortalBadgeSize.values,
            cellBuilder: (_, variant, size) =>
                FortalBadge(variant: variant, size: size, label: 'Active'),
          ),
        ),
        GallerySection(
          label: 'Card',
          description:
              'Surface, classic, and ghost containers across five spacing sizes.',
          child: GalleryEnumMatrix(
            rows: FortalCardVariant.values,
            columns: FortalCardSize.values,
            cellWidth: 200,
            cellBuilder: (_, variant, size) => SizedBox(
              width: 160,
              child: FortalCard(
                variant: variant,
                size: size,
                child: const FortalText('Card content', size: .size2),
              ),
            ),
          ),
        ),
        GallerySection(
          label: 'Callout',
          description: 'Contextual information in every variant and size.',
          child: GalleryEnumMatrix(
            rows: FortalCalloutVariant.values,
            columns: FortalCalloutSize.values,
            cellWidth: 230,
            cellBuilder: (_, variant, size) => SizedBox(
              width: 200,
              child: FortalCallout(
                variant: variant,
                size: size,
                text: 'A helpful callout message.',
              ),
            ),
          ),
        ),
        GallerySection(
          label: 'Data list',
          description:
              'Label and value pairs at every size, horizontal and vertical.',
          child: GalleryEnumMatrix(
            rows: Axis.values,
            columns: FortalDataListSize.values,
            cellWidth: 250,
            cellBuilder: (_, orientation, size) => FortalDataList(
              size: size,
              orientation: orientation,
              items: const [
                RemixDataListItem(
                  label: 'Status',
                  child: FortalBadge(highContrast: true, label: 'Active'),
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
          child: GalleryEnumMatrix(
            rows: FortalProgressVariant.values,
            columns: FortalProgressSize.values,
            cellWidth: 210,
            cellBuilder: (_, variant, size) => SizedBox(
              width: 170,
              child: FortalProgress(
                variant: variant,
                size: size,
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
