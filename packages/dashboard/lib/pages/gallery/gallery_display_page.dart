import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

import '../../widgets/gallery_scaffold.dart';

class GalleryDisplayPage extends StatefulWidget {
  const GalleryDisplayPage({super.key});

  @override
  State<GalleryDisplayPage> createState() => _GalleryDisplayPageState();
}

class _GalleryDisplayPageState extends State<GalleryDisplayPage> {
  bool _spinnersRunning = false;

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
            rows: FortalAvatarVariant.values.map(galleryLabel).toList(),
            columns: FortalAvatarSize.values.map(galleryLabel).toList(),
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
            rows: FortalBadgeVariant.values.map(galleryLabel).toList(),
            columns: FortalBadgeSize.values.map(galleryLabel).toList(),
            cellBuilder: (_, row, column) => FortalBadge(
              variant: FortalBadgeVariant.values[row],
              size: FortalBadgeSize.values[column],
              child: const Text('Active'),
            ),
          ),
        ),
        GallerySection(
          label: 'Card',
          description:
              'Surface, classic, and ghost containers across five spacing sizes.',
          child: GalleryMatrix(
            rows: FortalCardVariant.values.map(galleryLabel).toList(),
            columns: FortalCardSize.values.map(galleryLabel).toList(),
            cellWidth: 200,
            cellBuilder: (_, row, column) => SizedBox(
              width: 160,
              child: FortalCard(
                variant: FortalCardVariant.values[row],
                size: FortalCardSize.values[column],
                onTap: () {},
                child: const Text('Card content'),
              ),
            ),
          ),
        ),
        GallerySection(
          label: 'Callout',
          description: 'Contextual information in every variant and size.',
          child: GalleryMatrix(
            rows: FortalCalloutVariant.values.map(galleryLabel).toList(),
            columns: FortalCalloutSize.values.map(galleryLabel).toList(),
            cellWidth: 230,
            cellBuilder: (_, row, column) => SizedBox(
              width: 200,
              child: FortalCallout(
                variant: FortalCalloutVariant.values[row],
                size: FortalCalloutSize.values[column],
                child: const Text('A helpful callout message.'),
              ),
            ),
          ),
        ),
        GallerySection(
          label: 'Progress',
          description:
              'Determinate progress with classic, surface, and soft treatments.',
          child: GalleryMatrix(
            rows: FortalProgressVariant.values.map(galleryLabel).toList(),
            columns: FortalProgressSize.values.map(galleryLabel).toList(),
            cellWidth: 210,
            cellBuilder: (_, row, column) => SizedBox(
              width: 170,
              child: FortalProgress(
                variant: FortalProgressVariant.values[row],
                size: FortalProgressSize.values[column],
                value: 68,
                semanticLabel: '68 percent complete',
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
              FortalButton(
                variant: .soft,
                size: .size1,
                onPressed: () =>
                    setState(() => _spinnersRunning = !_spinnersRunning),
                child: Text(_spinnersRunning ? 'Stop' : 'Start'),
              ),
              for (final size in FortalSpinnerSize.values)
                FortalSpinner(
                  size: size,
                  loading: _spinnersRunning,
                  semanticLabel: 'Loading example',
                  child: const Icon(Icons.check, size: 16),
                ),
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
                    SizedBox(width: 64, child: Text(galleryLabel(size))),
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
