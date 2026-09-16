import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import '../../ui/ui.dart';

import '../../widgets/gallery_scaffold.dart';

class GalleryActionsPage extends StatefulWidget {
  const GalleryActionsPage({super.key});

  @override
  State<GalleryActionsPage> createState() => _GalleryActionsPageState();
}

class _GalleryActionsPageState extends State<GalleryActionsPage> {
  bool _selected = true;

  @override
  Widget build(BuildContext context) {
    return GalleryPage(
      title: 'Actions',
      intro: 'Interactive actions across every Fortal variant and size.',
      sections: [
        GallerySection(
          label: 'Button',
          description:
              'Classic, solid, soft, surface, outline, and ghost actions.',
          child: GalleryEnumMatrix(
            rows: UiButtonVariant.values,
            columns: UiButtonSize.values,
            cellBuilder: (context, variant, size) => UiButton(
              variant: variant,
              size: size,
              onPressed: () => showRemixToast(
                context,
                RemixToastData(
                  title: 'Button pressed',
                  icon: Icons.check_circle_outline,
                ),
              ),
              label: 'Button',
            ),
          ),
        ),
        GallerySection(
          label: 'Icon button',
          description:
              'Compact icon-only controls with complete focus semantics.',
          child: GalleryEnumMatrix(
            rows: UiIconButtonVariant.values,
            columns: UiIconButtonSize.values,
            cellBuilder: (context, variant, size) => UiIconButton(
              variant: variant,
              size: size,
              semanticLabel: 'Add item',
              onPressed: () => showRemixToast(
                context,
                RemixToastData(
                  title: 'Item added',
                  icon: Icons.check_circle_outline,
                ),
              ),
              icon: Icons.add,
            ),
          ),
        ),
        GallerySection(
          label: 'Toggle',
          description: 'Ghost and outline toggles remain fully interactive.',
          child: GalleryEnumMatrix(
            rows: UiToggleVariant.values,
            columns: UiToggleSize.values,
            cellBuilder: (_, variant, size) => UiToggle(
              variant: variant,
              size: size,
              selected: _selected,
              icon: Icons.format_bold,
              label: 'Bold',
              onChanged: (value) => setState(() => _selected = value),
            ),
          ),
        ),
        GallerySection(
          label: 'States',
          description:
              'Disabled and loading behavior uses the same component API.',
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              const UiButton(
                enabled: false,
                onPressed: null,
                label: 'Disabled',
              ),
              UiButton(loading: true, onPressed: () {}, label: 'Saving'),
              UiIconButton(
                enabled: false,
                semanticLabel: 'Disabled favorite',
                onPressed: () {},
                icon: Icons.favorite_border,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
