import 'package:flutter/material.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../../utils/text.dart';
import '../../widgets/gallery_scaffold.dart';
import '../../widgets/toast.dart';

/// The five Fortal typography families on one page.
///
/// Everything here is a `Fortal*` widget: the dashboard's own `dashboardText`
/// helper exists only to add a neutral tone, and none of these samples want
/// one.
class GalleryTypographyPage extends StatelessWidget {
  const GalleryTypographyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GalleryPage(
      title: 'Typography',
      intro: 'Text, headings, code, keys, and links on one shared scale.',
      sections: [
        GallerySection(
          label: 'Text scale',
          description:
              'The nine-step Radix scale, from 12 to 60 logical pixels.',
          child: Column(
            crossAxisAlignment: .start,
            spacing: 6,
            children: [
              for (final size in FortalTextSize.values)
                Row(
                  crossAxisAlignment: .baseline,
                  textBaseline: TextBaseline.alphabetic,
                  spacing: 14,
                  children: [
                    SizedBox(
                      width: 64,
                      child: FortalCode.ghost(enumLabel(size), size: .size1),
                    ),
                    Flexible(
                      child: FortalText(
                        'The quick brown fox',
                        size: size,
                        truncate: true,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        GallerySection(
          label: 'Weights',
          description:
              'Light, regular, medium, and bold are shared by every family.',
          child: GalleryMatrix(
            rows: const ['Text', 'Heading', 'Code', 'Link'],
            columns: FortalTextWeight.values.map(enumLabel).toList(),
            cellWidth: 130,
            cellBuilder: (context, row, column) {
              final weight = FortalTextWeight.values[column];
              return switch (row) {
                0 => FortalText('Aa', size: .size4, weight: weight),
                1 => FortalHeading(
                  'Aa',
                  headingLevel: 3,
                  size: .size4,
                  weight: weight,
                ),
                2 => FortalCode.soft('Aa', size: .size4, weight: weight),
                _ => FortalLink(
                  'Aa',
                  size: .size4,
                  weight: weight,
                  onPressed: () =>
                      showToast(context, message: 'Link activated'),
                ),
              };
            },
          ),
        ),
        GallerySection(
          label: 'Heading level and size',
          description:
              'The accessibility level is independent of the visual size, '
              'exactly as Radix separates its element from its size.',
          child: Column(
            crossAxisAlignment: .start,
            spacing: 8,
            children: [
              for (final (level, size) in const [
                (1, FortalTextSize.size6),
                (2, FortalTextSize.size4),
                (3, FortalTextSize.size3),
              ])
                FortalHeading(
                  'Level $level heading at size ${size.name.substring(4)}',
                  headingLevel: level,
                  size: size,
                  weight: level == 1 ? .bold : .medium,
                ),
            ],
          ),
        ),
        GallerySection(
          label: 'Code',
          description: 'Solid, soft, outline, and ghost inline code.',
          child: GalleryMatrix(
            rows: FortalCodeVariant.values.map(enumLabel).toList(),
            columns: const ['Default', 'High contrast'],
            cellWidth: 170,
            cellBuilder: (_, row, column) => FortalCode(
              'const x = 1;',
              variant: FortalCodeVariant.values[row],
              size: .size2,
              accent: true,
              highContrast: column == 1,
            ),
          ),
        ),
        GallerySection(
          label: 'Keyboard keys',
          description:
              'Classic key caps and the flat soft variant, at four sizes.',
          child: GalleryMatrix(
            rows: FortalKbdVariant.values.map(enumLabel).toList(),
            columns: const ['Size 1', 'Size 3', 'Size 5', 'Size 7'],
            cellWidth: 130,
            cellBuilder: (_, row, column) => FortalKbd(
              '⌘K',
              variant: FortalKbdVariant.values[row],
              size: const [
                FortalTextSize.size1,
                FortalTextSize.size3,
                FortalTextSize.size5,
                FortalTextSize.size7,
              ][column],
              semanticLabel: 'Command K',
            ),
          ),
        ),
        GallerySection(
          label: 'Links',
          description:
              'Only a link with a callback becomes focusable and underlined; '
              'an inert link is styled text.',
          child: Wrap(
            spacing: 20,
            runSpacing: 14,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              for (final underline in FortalLinkUnderline.values)
                FortalLink(
                  enumLabel(underline),
                  underline: underline,
                  onPressed: () => showToast(
                    context,
                    message: '${enumLabel(underline)} link activated',
                  ),
                ),
              FortalLink(
                'High contrast',
                highContrast: true,
                onPressed: () =>
                    showToast(context, message: 'High contrast activated'),
              ),
              FortalLink('Disabled', enabled: false, onPressed: () {}),
              const FortalLink('Inert'),
              FortalLink(
                'Documentation',
                linkUrl: Uri.parse('https://docs.page/btwld/remix/fortal'),
                semanticHint: 'Opens the Fortal documentation',
                onPressed: () =>
                    showToast(context, message: 'Navigation is the caller\'s'),
              ),
            ],
          ),
        ),
        GallerySection(
          label: 'Accent and high contrast',
          description:
              'Accent text takes accent-a11; high contrast promotes it to '
              'accent-12. Setting high contrast alone does nothing.',
          child: Wrap(
            spacing: 20,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: const [
              FortalText('Inherited', size: .size3),
              FortalText('Accent', size: .size3, accent: true),
              FortalText(
                'Accent high contrast',
                size: .size3,
                accent: true,
                highContrast: true,
              ),
              FortalHeading(
                'Accent heading',
                headingLevel: 3,
                size: .size3,
                weight: .medium,
                accent: true,
              ),
            ],
          ),
        ),
        const GallerySection(
          label: 'Wrapping and truncation',
          description:
              'Truncate deliberately wins over softWrap and holds one '
              'ellipsized line.',
          // Both samples are pinned to the same narrow box: at full page width
          // the sentence fits on one line and the two settings look identical.
          child: Wrap(
            spacing: 32,
            runSpacing: 16,
            children: [
              SizedBox(
                width: 260,
                child: FortalText(
                  'Wrap keeps the complete sentence, across as many lines as '
                  'it needs.',
                  size: .size2,
                ),
              ),
              SizedBox(
                width: 260,
                child: FortalText(
                  'Truncate keeps exactly one line, across as many lines as '
                  'it needs.',
                  size: .size2,
                  truncate: true,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
