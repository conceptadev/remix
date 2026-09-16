import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import '../../ui/ui.dart';

import '../../utils/text.dart';
import '../../widgets/gallery_scaffold.dart';

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
              for (final size in UiTextSize.values)
                Row(
                  crossAxisAlignment: .baseline,
                  textBaseline: TextBaseline.alphabetic,
                  spacing: 14,
                  children: [
                    SizedBox(
                      width: 64,
                      child: UiCode.ghost(enumLabel(size), size: .size1),
                    ),
                    Flexible(
                      child: UiText(
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
            columns: UiTextWeight.values,
            cellWidth: 130,
            cellBuilder: (context, family, weight) {
              return switch (family) {
                .text => UiText('Aa', size: .size4, weight: weight),
                .heading => UiHeading(
                  'Aa',
                  headingLevel: 3,
                  size: .size4,
                  weight: weight,
                ),
                .code => UiCode.soft('Aa', size: .size4, weight: weight),
                .link => UiLink(
                  'Aa',
                  size: .size4,
                  weight: weight,
                  onPressed: () => showRemixToast(
                    context,
                    RemixToastData(
                      title: 'Link activated',
                      icon: Icons.check_circle_outline,
                    ),
                  ),
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
                (1, UiTextSize.size6),
                (2, UiTextSize.size4),
                (3, UiTextSize.size3),
              ])
                UiHeading(
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
          child: GalleryMatrix<UiCodeVariant, bool>(
            rows: UiCodeVariant.values,
            columns: const [false, true],
            rowLabelBuilder: enumLabel,
            columnLabelBuilder: (highContrast) =>
                highContrast ? 'High contrast' : 'Default',
            cellWidth: 170,
            cellBuilder: (_, variant, highContrast) => UiCode(
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
            rows: UiKbdVariant.values,
            columns: UiTextSize.values,
            cellWidth: 130,
            cellBuilder: (_, variant, size) => UiKbd(
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
              for (final underline in UiLinkUnderline.values)
                UiLink(
                  enumLabel(underline),
                  underline: underline,
                  onPressed: () => showRemixToast(
                    context,
                    RemixToastData(
                      title: '${enumLabel(underline)} link activated',
                      icon: Icons.check_circle_outline,
                    ),
                  ),
                ),
              UiLink(
                'High contrast',
                highContrast: true,
                onPressed: () => showRemixToast(
                  context,
                  RemixToastData(
                    title: 'High contrast activated',
                    icon: Icons.check_circle_outline,
                  ),
                ),
              ),
              // Two spellings of the same state: a null callback disables the
              // link exactly as `enabled: false` does.
              UiLink('Disabled', enabled: false, onPressed: () {}),
              const UiLink('Disabled (no callback)'),
              UiLink(
                'Documentation',
                linkUrl: Uri.parse('https://docs.page/btwld/remix/fortal'),
                semanticHint: 'Opens the Fortal documentation',
                onPressed: () => showRemixToast(
                  context,
                  RemixToastData(
                    title: 'Navigation is the caller\'s',
                    icon: Icons.check_circle_outline,
                  ),
                ),
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
              UiText('Neutral', size: .size3),
              UiText('High contrast alone', size: .size3, highContrast: true),
              UiText('Accent', size: .size3, accent: true),
              UiText(
                'Accent high contrast',
                size: .size3,
                accent: true,
                highContrast: true,
              ),
              UiHeading(
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
                child: UiText(
                  'Wrap keeps the complete sentence, across as many lines as '
                  'it needs.',
                  size: .size2,
                ),
              ),
              SizedBox(
                width: 260,
                child: UiText(
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
