import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

import '../../widgets/gallery_scaffold.dart';

class GalleryFormsPage extends StatefulWidget {
  const GalleryFormsPage({super.key});

  @override
  State<GalleryFormsPage> createState() => _GalleryFormsPageState();
}

class _GalleryFormsPageState extends State<GalleryFormsPage> {
  bool _checked = true;
  bool _switched = true;
  int _radio = 1;
  String _alignment = 'left';
  List<double> _slider = [58];

  @override
  Widget build(BuildContext context) {
    final selectVariants = [
      for (final trigger in FortalSelectTriggerVariant.values)
        for (final content in FortalSelectContentVariant.values)
          (trigger: trigger, content: content),
    ];
    return GalleryPage(
      title: 'Forms & Inputs',
      intro: 'Production-ready fields and selection controls in every preset.',
      sections: [
        GallerySection(
          label: 'Text field',
          description:
              'All field variants and sizes, with labels and helper content.',
          child: GalleryMatrix(
            rows: FortalTextFieldVariant.values.map(galleryLabel).toList(),
            columns: FortalTextFieldSize.values.map(galleryLabel).toList(),
            cellWidth: 210,
            cellBuilder: (_, row, column) => FortalTextField(
              variant: FortalTextFieldVariant.values[row],
              size: FortalTextFieldSize.values[column],
              hintText: 'Type something…',
              leading: const Icon(Icons.search, size: 16),
            ),
          ),
        ),
        GallerySection(
          label: 'Select',
          description:
              'Every trigger/content combination across the three sizes.',
          child: GalleryMatrix(
            rows: selectVariants
                .map(
                  (value) =>
                      '${galleryLabel(value.trigger)} / ${galleryLabel(value.content)}',
                )
                .toList(),
            columns: FortalSelectSize.values.map(galleryLabel).toList(),
            cellBuilder: (_, row, column) {
              final variant = selectVariants[row];
              return FortalSelect<String>(
                triggerVariant: variant.trigger,
                contentVariant: variant.content,
                size: FortalSelectSize.values[column],
                trigger: const RemixSelectTrigger(placeholder: 'Fruit'),
                entries: const [
                  RemixSelectLabel(label: 'Fruit'),
                  RemixSelectItem(value: 'apple', label: 'Apple'),
                  RemixSelectItem(value: 'orange', label: 'Orange'),
                  RemixSelectSeparator(),
                  RemixSelectItem(value: 'pear', label: 'Pear'),
                ],
                selectedValue: 'apple',
                onChanged: (_) {},
              );
            },
          ),
        ),
        GallerySection(
          label: 'Toggle group',
          description:
              'Single-selection groups in soft and surface treatments.',
          child: GalleryMatrix(
            rows: FortalToggleGroupVariant.values.map(galleryLabel).toList(),
            columns: FortalToggleGroupSize.values.map(galleryLabel).toList(),
            cellWidth: 230,
            cellBuilder: (_, row, column) => FortalToggleGroup<String>(
              variant: FortalToggleGroupVariant.values[row],
              size: FortalToggleGroupSize.values[column],
              selectedValue: _alignment,
              semanticLabel: 'Text alignment',
              items: const [
                RemixToggleGroupItem(
                  value: 'left',
                  icon: Icons.format_align_left,
                  semanticLabel: 'Left',
                ),
                RemixToggleGroupItem(
                  value: 'center',
                  icon: Icons.format_align_center,
                  semanticLabel: 'Center',
                ),
                RemixToggleGroupItem(
                  value: 'right',
                  icon: Icons.format_align_right,
                  semanticLabel: 'Right',
                ),
              ],
              onChanged: (value) {
                if (value != null) setState(() => _alignment = value);
              },
            ),
          ),
        ),
        GallerySection(
          label: 'Checkbox',
          description: 'Classic, surface, and soft checkbox recipes.',
          child: GalleryMatrix(
            rows: FortalCheckboxVariant.values.map(galleryLabel).toList(),
            columns: FortalCheckboxSize.values.map(galleryLabel).toList(),
            cellBuilder: (_, row, column) => FortalCheckbox(
              variant: FortalCheckboxVariant.values[row],
              size: FortalCheckboxSize.values[column],
              selected: _checked,
              semanticLabel: 'Example checkbox',
              onChanged: (value) => setState(() => _checked = value ?? false),
            ),
          ),
        ),
        GallerySection(
          label: 'Radio',
          description: 'Radio selection shown across every variant and size.',
          child: GalleryMatrix(
            rows: FortalRadioVariant.values.map(galleryLabel).toList(),
            columns: FortalRadioSize.values.map(galleryLabel).toList(),
            cellBuilder: (_, row, column) => FortalRadioGroup<int>(
              value: _radio,
              onChanged: (value) {
                if (value != null) setState(() => _radio = value);
              },
              child: FortalRadio<int>(
                variant: FortalRadioVariant.values[row],
                size: FortalRadioSize.values[column],
                value: 1,
              ),
            ),
          ),
        ),
        GallerySection(
          label: 'Switch',
          description: 'Binary settings controls with all visual treatments.',
          child: GalleryMatrix(
            rows: FortalSwitchVariant.values.map(galleryLabel).toList(),
            columns: FortalSwitchSize.values.map(galleryLabel).toList(),
            cellBuilder: (_, row, column) => FortalSwitch(
              variant: FortalSwitchVariant.values[row],
              size: FortalSwitchSize.values[column],
              selected: _switched,
              semanticLabel: 'Example switch',
              onChanged: (value) => setState(() => _switched = value),
            ),
          ),
        ),
        GallerySection(
          label: 'Slider',
          description: 'Discrete single-thumb sliders in every Fortal recipe.',
          child: GalleryMatrix(
            rows: FortalSliderVariant.values.map(galleryLabel).toList(),
            columns: FortalSliderSize.values.map(galleryLabel).toList(),
            cellWidth: 210,
            cellBuilder: (_, row, column) => SizedBox(
              width: 170,
              child: FortalSlider(
                variant: FortalSliderVariant.values[row],
                size: FortalSliderSize.values[column],
                values: _slider,
                step: 1,
                semanticLabels: const ['Example slider'],
                onChanged: (value) => setState(() => _slider = value),
              ),
            ),
          ),
        ),
        const GallerySection(
          label: 'States',
          description: 'Validation, disabled, and indeterminate states.',
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              SizedBox(
                width: 240,
                child: FortalTextField(
                  error: true,
                  label: 'Workspace slug',
                  hintText: 'remix',
                  helperText: 'That slug is already in use.',
                ),
              ),
              FortalCheckbox(
                selected: null,
                tristate: true,
                semanticLabel: 'Indeterminate checkbox',
              ),
              FortalSwitch(
                selected: false,
                enabled: false,
                semanticLabel: 'Disabled switch',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
