import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import '../../ui/ui.dart';

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
            rows: UiAvatarVariant.values,
            columns: UiAvatarSize.values,
            // Size9 is 160px; preserve its 20px cell padding and divider.
            cellWidth: 181,
            cellBuilder: (_, variant, size) =>
                UiAvatar(variant: variant, size: size, label: 'RF'),
          ),
        ),
        GallerySection(
          label: 'Badge',
          description:
              'Status labels in solid, soft, surface, and outline variants.',
          child: GalleryEnumMatrix(
            rows: UiBadgeVariant.values,
            columns: UiBadgeSize.values,
            cellBuilder: (_, variant, size) =>
                UiBadge(variant: variant, size: size, label: 'Active'),
          ),
        ),
        GallerySection(
          label: 'Card',
          description:
              'Surface, classic, and ghost containers across five spacing sizes.',
          child: GalleryEnumMatrix(
            rows: UiCardVariant.values,
            columns: UiCardSize.values,
            cellWidth: 200,
            cellBuilder: (_, variant, size) => SizedBox(
              width: 160,
              child: UiCard(
                variant: variant,
                size: size,
                child: const UiText('Card content', size: .size2),
              ),
            ),
          ),
        ),
        GallerySection(
          label: 'Callout',
          description: 'Contextual information in every variant and size.',
          child: GalleryEnumMatrix(
            rows: UiCalloutVariant.values,
            columns: UiCalloutSize.values,
            cellWidth: 230,
            cellBuilder: (_, variant, size) => SizedBox(
              width: 200,
              child: UiCallout(
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
            columns: UiDataListSize.values,
            cellWidth: 250,
            cellBuilder: (_, orientation, size) => UiDataList(
              size: size,
              orientation: orientation,
              items: const [
                RemixDataListItem(
                  label: 'Status',
                  child: UiBadge(highContrast: true, label: 'Active'),
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
              UiButton.soft(
                size: .size1,
                onPressed: () =>
                    setState(() => _skeletonLoading = !_skeletonLoading),
                label: _skeletonLoading ? 'Show content' : 'Show skeleton',
              ),
              UiSkeleton(
                loading: _skeletonLoading,
                child: const UiAvatar(label: 'RF', size: .size5),
              ),
              UiSkeleton(
                loading: _skeletonLoading,
                child: const UiText(
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
            rows: UiProgressVariant.values,
            columns: UiProgressSize.values,
            cellWidth: 210,
            cellBuilder: (_, variant, size) => SizedBox(
              width: 170,
              child: UiProgress(
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
              UiButton.soft(
                size: .size1,
                onPressed: () =>
                    setState(() => _spinnersRunning = !_spinnersRunning),
                label: _spinnersRunning ? 'Stop' : 'Start',
              ),
              for (final size in UiSpinnerSize.values)
                if (_spinnersRunning)
                  UiSpinner(size: size, semanticsLabel: 'Loading example')
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
              for (final size in UiDividerSize.values)
                Row(
                  spacing: 12,
                  children: [
                    SizedBox(
                      width: 64,
                      child: UiText(enumLabel(size), size: .size2),
                    ),
                    Expanded(child: UiDivider(size: size)),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
