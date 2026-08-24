import 'package:flutter/material.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../../widgets/gallery_scaffold.dart';
import '../../widgets/toast.dart';

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
            rows: FortalButtonVariant.values,
            columns: FortalButtonSize.values,
            cellBuilder: (context, variant, size) => FortalButton(
              variant: variant,
              size: size,
              onPressed: () => showToast(context, message: 'Button pressed'),
              label: 'Button',
            ),
          ),
        ),
        GallerySection(
          label: 'Icon button',
          description:
              'Compact icon-only controls with complete focus semantics.',
          child: GalleryEnumMatrix(
            rows: FortalIconButtonVariant.values,
            columns: FortalIconButtonSize.values,
            cellBuilder: (context, variant, size) => FortalIconButton(
              variant: variant,
              size: size,
              semanticLabel: 'Add item',
              onPressed: () => showToast(context, message: 'Item added'),
              icon: Icons.add,
            ),
          ),
        ),
        GallerySection(
          label: 'Toggle',
          description: 'Ghost and outline toggles remain fully interactive.',
          child: GalleryEnumMatrix(
            rows: FortalToggleVariant.values,
            columns: FortalToggleSize.values,
            cellBuilder: (_, variant, size) => FortalToggle(
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
              const FortalButton(
                enabled: false,
                onPressed: null,
                label: 'Disabled',
              ),
              FortalButton(loading: true, onPressed: () {}, label: 'Saving'),
              FortalIconButton(
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
