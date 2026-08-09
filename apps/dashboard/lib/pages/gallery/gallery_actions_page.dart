import 'package:flutter/material.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../../utils/text.dart';
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
          child: GalleryMatrix(
            rows: FortalButtonVariant.values.map(enumLabel).toList(),
            columns: FortalButtonSize.values.map(enumLabel).toList(),
            cellBuilder: (context, row, column) => FortalButton(
              variant: FortalButtonVariant.values[row],
              size: FortalButtonSize.values[column],
              onPressed: () => showToast(context, message: 'Button pressed'),
              label: 'Button',
            ),
          ),
        ),
        GallerySection(
          label: 'Icon button',
          description:
              'Compact icon-only controls with complete focus semantics.',
          child: GalleryMatrix(
            rows: FortalIconButtonVariant.values.map(enumLabel).toList(),
            columns: FortalIconButtonSize.values.map(enumLabel).toList(),
            cellBuilder: (context, row, column) => FortalIconButton(
              variant: FortalIconButtonVariant.values[row],
              size: FortalIconButtonSize.values[column],
              semanticLabel: 'Add item',
              onPressed: () => showToast(context, message: 'Item added'),
              icon: Icons.add,
            ),
          ),
        ),
        GallerySection(
          label: 'Toggle',
          description: 'Ghost and outline toggles remain fully interactive.',
          child: GalleryMatrix(
            rows: FortalToggleVariant.values.map(enumLabel).toList(),
            columns: FortalToggleSize.values.map(enumLabel).toList(),
            cellBuilder: (_, row, column) => FortalToggle(
              variant: FortalToggleVariant.values[row],
              size: FortalToggleSize.values[column],
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
