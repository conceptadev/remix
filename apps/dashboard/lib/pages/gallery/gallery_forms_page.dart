import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../../utils/text.dart';
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
  String _density = 'comfortable';
  Set<String> _channels = {'email'};
  double _slider = 58;

  @override
  Widget build(BuildContext context) {
    return GalleryPage(
      title: 'Forms & Inputs',
      intro: 'Production-ready fields and selection controls in every preset.',
      sections: [
        GallerySection(
          label: 'Text field',
          description:
              'All field variants and sizes, with labels and helper content.',
          child: GalleryMatrix(
            rows: FortalTextFieldVariant.values.map(enumLabel).toList(),
            columns: FortalTextFieldSize.values.map(enumLabel).toList(),
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
          label: 'Text area',
          description:
              'Multi-line input sharing the text field variants and sizes.',
          child: GalleryMatrix(
            rows: FortalTextAreaVariant.values.map(enumLabel).toList(),
            columns: FortalTextAreaSize.values.map(enumLabel).toList(),
            cellWidth: 230,
            cellBuilder: (_, row, column) => FortalTextArea(
              variant: FortalTextAreaVariant.values[row],
              size: FortalTextAreaSize.values[column],
              hintText: 'Add a note…',
            ),
          ),
        ),
        GallerySection(
          label: 'Segmented control',
          description: 'Exclusive selection in surface and classic treatments.',
          child: GalleryMatrix(
            rows: FortalSegmentedControlVariant.values.map(enumLabel).toList(),
            columns: FortalSegmentedControlSize.values.map(enumLabel).toList(),
            cellWidth: 250,
            cellBuilder: (_, row, column) => FortalSegmentedControl<String>(
              variant: FortalSegmentedControlVariant.values[row],
              size: FortalSegmentedControlSize.values[column],
              selectedValue: _density,
              semanticLabel: 'Row density',
              items: const [
                RemixSegmentedControlItem(value: 'compact', label: 'Compact'),
                RemixSegmentedControlItem(value: 'comfortable', label: 'Cozy'),
              ],
              onChanged: (value) => setState(() => _density = value),
            ),
          ),
        ),
        GallerySection(
          label: 'Select',
          description: 'Every visual variant across the three sizes.',
          child: GalleryMatrix(
            rows: FortalSelectVariant.values.map(enumLabel).toList(),
            columns: FortalSelectSize.values.map(enumLabel).toList(),
            cellBuilder: (_, row, column) => FortalSelect<String>(
              variant: FortalSelectVariant.values[row],
              size: FortalSelectSize.values[column],
              trigger: const RemixSelectTrigger(placeholder: 'Fruit'),
              items: const [
                RemixSelectItem(value: 'apple', label: 'Apple'),
                RemixSelectItem(value: 'orange', label: 'Orange'),
                RemixSelectItem(value: 'pear', label: 'Pear'),
              ],
              selectedValue: 'apple',
              onChanged: (_) {},
            ),
          ),
        ),
        GallerySection(
          label: 'Toggle group',
          description:
              'Single-selection groups in soft and surface treatments.',
          child: GalleryMatrix(
            rows: FortalToggleGroupVariant.values.map(enumLabel).toList(),
            columns: FortalToggleGroupSize.values.map(enumLabel).toList(),
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
            rows: FortalCheckboxVariant.values.map(enumLabel).toList(),
            columns: FortalCheckboxSize.values.map(enumLabel).toList(),
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
          label: 'Checkbox group',
          description:
              'Labelled options whose text shares the checkbox tap target.',
          child: RemixCheckboxGroup<String>(
            values: _channels,
            semanticLabel: 'Notification channels',
            onChanged: (values) => setState(() => _channels = values),
            child: Wrap(
              spacing: 18,
              runSpacing: 6,
              children: [
                for (final (value, label) in const [
                  ('email', 'Email'),
                  ('sms', 'SMS'),
                  ('push', 'Push'),
                ])
                  FortalCheckboxGroupItem<String>(value: value, label: label),
              ],
            ),
          ),
        ),
        GallerySection(
          label: 'Radio',
          description: 'Radio selection shown across every variant and size.',
          child: GalleryMatrix(
            rows: FortalRadioVariant.values.map(enumLabel).toList(),
            columns: FortalRadioSize.values.map(enumLabel).toList(),
            cellBuilder: (_, row, column) => RemixRadioGroup<int>(
              groupValue: _radio,
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
            rows: FortalSwitchVariant.values.map(enumLabel).toList(),
            columns: FortalSwitchSize.values.map(enumLabel).toList(),
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
            rows: FortalSliderVariant.values.map(enumLabel).toList(),
            columns: FortalSliderSize.values.map(enumLabel).toList(),
            cellWidth: 210,
            cellBuilder: (_, row, column) => SizedBox(
              width: 170,
              child: FortalSlider(
                variant: FortalSliderVariant.values[row],
                size: FortalSliderSize.values[column],
                value: _slider,
                min: 0,
                max: 100,
                snapDivisions: 100,
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
              FortalCheckbox(selected: true, label: 'Labelled'),
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
