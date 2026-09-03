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
              'Text, heading, code, and link share all four weight presets.',
          child: GalleryEnumMatrix(
            rows: _TypographyFamily.values,
            columns: FortalTextWeight.values,
            cellWidth: 130,
            cellBuilder: (context, family, weight) {
              return switch (family) {
                .text => FortalText('Aa', size: .size4, weight: weight),
                .heading => FortalHeading(
                  'Aa',
                  headingLevel: 3,
                  size: .size4,
                  weight: weight,
                ),
                .code => FortalCode.soft('Aa', size: .size4, weight: weight),
                .link => FortalLink(
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
          child: GalleryMatrix<FortalCodeVariant, bool>(
            rows: FortalCodeVariant.values,
            columns: const [false, true],
            rowLabelBuilder: enumLabel,
            columnLabelBuilder: (highContrast) =>
                highContrast ? 'High contrast' : 'Default',
            cellWidth: 170,
            cellBuilder: (_, variant, highContrast) => FortalCode(
              'const x = 1;',
              variant: variant,
              size: .size2,
              accent: true,
              highContrast: highContrast,
            ),
          ),
        ),
        GallerySection(
          label: 'Keyboard keys',
          description:
              'Classic key caps and the flat soft variant at all nine sizes.',
          child: GalleryEnumMatrix(
            rows: FortalKbdVariant.values,
            columns: FortalTextSize.values,
            cellWidth: 130,
            cellBuilder: (_, variant, size) => FortalKbd(
              '⌘K',
              variant: variant,
              size: size,
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
              // Two spellings of the same state: a null callback disables the
              // link exactly as `enabled: false` does.
              FortalLink('Disabled', enabled: false, onPressed: () {}),
              const FortalLink('Disabled (no callback)'),
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
              FortalText('Neutral', size: .size3),
              FortalText(
                'High contrast alone',
                size: .size3,
                highContrast: true,
              ),
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

enum _TypographyFamily { text, heading, code, link }
