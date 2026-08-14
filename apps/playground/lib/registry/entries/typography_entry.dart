import 'package:flutter/material.dart';
import 'package:remix_fortal/remix_fortal.dart';

Widget buildTypographyExample() {
  return SizedBox(
    width: 820,
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FortalHeading('Fortal typography', size: FortalTextSize.size8),
          const SizedBox(height: 8),
          const FortalText(
            'Text, headings, code, keys, and links on one shared scale.',
            size: FortalTextSize.size3,
          ),
          const SizedBox(height: 28),
          const _SectionLabel('Nine-step text scale'),
          const SizedBox(height: 12),
          for (final (index, size) in FortalTextSize.values.indexed)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  SizedBox(width: 52, child: FortalCode.ghost('${index + 1}')),
                  FortalText('The quick brown fox', size: size),
                ],
              ),
            ),
          const SizedBox(height: 24),
          const _SectionLabel('Semantic level is independent from size'),
          const SizedBox(height: 12),
          const FortalHeading(
            'Visual size 5, semantic heading level 2',
            headingLevel: 2,
            size: FortalTextSize.size5,
          ),
          const SizedBox(height: 24),
          const _SectionLabel('Code and keyboard variants'),
          const SizedBox(height: 12),
          const Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              FortalCode.solid('solid'),
              FortalCode.soft('soft'),
              FortalCode.outline('outline'),
              FortalCode.ghost('ghost'),
              FortalKbd.classic('⌘K', semanticLabel: 'Command K'),
              FortalKbd.soft('Esc', semanticLabel: 'Escape'),
            ],
          ),
          const SizedBox(height: 24),
          const _SectionLabel('Link underline and action states'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 18,
            runSpacing: 14,
            children: [
              FortalLink('Auto', onPressed: () {}),
              FortalLink(
                'Always',
                underline: FortalLinkUnderline.always,
                onPressed: () {},
              ),
              FortalLink(
                'Hover',
                underline: FortalLinkUnderline.hover,
                onPressed: () {},
              ),
              FortalLink(
                'None',
                underline: FortalLinkUnderline.none,
                onPressed: () {},
              ),
              // Two spellings of the same state: a null callback disables the
              // link exactly as `enabled: false` does.
              FortalLink('Disabled', enabled: false, onPressed: () {}),
              const FortalLink('Disabled (no callback)'),
            ],
          ),
          const SizedBox(height: 24),
          const _SectionLabel('Accent and high contrast'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 18,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const FortalText('Accent text', accent: true),
              const FortalText(
                'Accent high contrast',
                accent: true,
                highContrast: true,
              ),
              const FortalCode.soft('accent code', highContrast: true),
              // Actionable on purpose: this row is about accent colour, and a
              // callback-less link would show the disabled treatment instead.
              FortalLink('Accent link', highContrast: true, onPressed: () {}),
            ],
          ),
          const SizedBox(height: 24),
          const _SectionLabel('Wrapping and truncation'),
          const SizedBox(height: 12),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 240,
                child: FortalText(
                  'Wrap keeps the complete sentence in narrow space.',
                ),
              ),
              SizedBox(width: 24),
              SizedBox(
                width: 240,
                child: FortalText(
                  'Truncate keeps exactly one line in narrow space.',
                  truncate: true,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => FortalText(
    text,
    size: FortalTextSize.size2,
    weight: FortalTextWeight.medium,
    accent: true,
    highContrast: true,
  );
}
