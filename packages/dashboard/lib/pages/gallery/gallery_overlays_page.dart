import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

import '../../widgets/gallery_scaffold.dart';
import '../../widgets/toast.dart';

class GalleryOverlaysPage extends StatelessWidget {
  const GalleryOverlaysPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GalleryPage(
      title: 'Overlays',
      intro:
          'Real dialog, popover, tooltip, and menu triggers for every recipe.',
      sections: [
        GallerySection(
          label: 'Dialog',
          description:
              'Start and center alignment across all four dialog sizes.',
          child: GalleryMatrix(
            rows: FortalDialogAlign.values.map(galleryLabel).toList(),
            columns: FortalDialogSize.values.map(galleryLabel).toList(),
            cellBuilder: (context, row, column) => FortalButton.soft(
              size: .size1,
              onPressed: () => showRemixDialog<void>(
                context: context,
                builder: (dialogContext) => FortalDialog(
                  size: FortalDialogSize.values[column],
                  align: FortalDialogAlign.values[row],
                  title: 'Invite teammates',
                  description: 'Share this workspace with your collaborators.',
                  actions: [
                    FortalButton.soft(
                      onPressed: () => Navigator.of(dialogContext).pop(),
                      child: const Text('Cancel'),
                    ),
                    FortalButton(
                      onPressed: () => Navigator.of(dialogContext).pop(),
                      child: const Text('Send invite'),
                    ),
                  ],
                  child: const Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: FortalTextField(hintText: 'teammate@example.com'),
                  ),
                ),
              ),
              child: const Text('Open'),
            ),
          ),
        ),
        GallerySection(
          label: 'Popover',
          description: 'Anchored content with all four padding presets.',
          child: Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
              for (final size in FortalPopoverSize.values)
                FortalPopover(
                  size: size,
                  width: 250,
                  matchTriggerWidth: false,
                  semanticLabel: 'Open ${galleryLabel(size)} popover',
                  popoverChild: const Column(
                    crossAxisAlignment: .start,
                    spacing: 8,
                    children: [
                      Text('Quick note'),
                      Text('Popover content inherits the active Fortal scope.'),
                    ],
                  ),
                  child: _OverlayTrigger('Popover ${galleryLabel(size)}'),
                ),
            ],
          ),
        ),
        GallerySection(
          label: 'Tooltip',
          description:
              'Hover or long-press the trigger to reveal contextual help.',
          child: FortalTooltip(
            tooltipSemantics: 'Keyboard shortcut Command K',
            tooltipChild: const Text('Search · ⌘K'),
            child: const _OverlayTrigger('Hover for shortcut'),
          ),
        ),
        GallerySection(
          label: 'Menu',
          description: 'Solid and soft menus at both supported density sizes.',
          child: GalleryMatrix(
            rows: FortalMenuVariant.values.map(galleryLabel).toList(),
            columns: FortalMenuSize.values.map(galleryLabel).toList(),
            cellBuilder: (context, row, column) => FortalMenu<String>(
              variant: FortalMenuVariant.values[row],
              size: FortalMenuSize.values[column],
              semanticLabel: 'Open actions menu',
              trigger: const _OverlayTrigger('Open menu'),
              items: const [
                RemixMenuLabel(child: Text('Document')),
                RemixMenuAction(value: 'duplicate', child: Text('Duplicate')),
                RemixMenuAction(value: 'share', child: Text('Share')),
                RemixMenuSeparator(),
                RemixMenuAction(value: 'archive', child: Text('Archive')),
              ],
              onSelected: (value) =>
                  showToast(context, message: '$value selected'),
            ),
          ),
        ),
      ],
    );
  }
}

class _OverlayTrigger extends StatelessWidget {
  const _OverlayTrigger(this.label);
  final String label;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: MixScope.tokenOf(FortalTokens.accentA3, context),
      border: Border.all(
        color: MixScope.tokenOf(FortalTokens.accentA6, context),
      ),
      borderRadius: BorderRadius.all(
        MixScope.tokenOf(FortalTokens.radius3, context),
      ),
    ),
    child: StyledText(
      label,
      style: TextStyler(
        style: FortalTokens.text2.mix(),
      ).fontWeight(.w500).color(FortalTokens.accent11()),
    ),
  );
}
