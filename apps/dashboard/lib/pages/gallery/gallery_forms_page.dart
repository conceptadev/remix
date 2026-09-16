import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import '../../ui/ui.dart';

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
              'All field variants and sizes with a leading icon and placeholder.',
          child: GalleryEnumMatrix(
            rows: UiTextFieldVariant.values,
            columns: UiTextFieldSize.values,
            cellWidth: 210,
            cellBuilder: (_, variant, size) => UiTextField(
              variant: variant,
              size: size,
              hintText: 'Type something…',
              leading: const Icon(Icons.search, size: 16),
            ),
          ),
        ),
        GallerySection(
          label: 'Text area',
          description:
              'Multi-line input sharing the text field variants and sizes.',
          child: GalleryEnumMatrix(
            rows: UiTextAreaVariant.values,
            columns: UiTextAreaSize.values,
            cellWidth: 230,
            cellBuilder: (_, variant, size) => UiTextArea(
              variant: variant,
              size: size,
              hintText: 'Add a note…',
            ),
          ),
        ),
        GallerySection(
          label: 'Segmented control',
          description: 'Exclusive selection in surface and classic treatments.',
          child: GalleryEnumMatrix(
            rows: UiSegmentedControlVariant.values,
            columns: UiSegmentedControlSize.values,
            cellWidth: 250,
            cellBuilder: (_, variant, size) => UiSegmentedControl<String>(
              variant: variant,
              size: size,
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
          child: GalleryEnumMatrix(
            rows: UiSelectVariant.values,
            columns: UiSelectSize.values,
            cellBuilder: (_, variant, size) => UiSelect<String>(
              variant: variant,
              size: size,
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
          child: GalleryEnumMatrix(
            rows: UiToggleGroupVariant.values,
            columns: UiToggleGroupSize.values,
            cellWidth: 230,
            cellBuilder: (_, variant, size) => UiToggleGroup<String>(
              variant: variant,
              size: size,
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
          child: GalleryEnumMatrix(
            rows: UiCheckboxVariant.values,
            columns: UiCheckboxSize.values,
            cellBuilder: (_, variant, size) => UiCheckbox(
              variant: variant,
              size: size,
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
                  UiCheckboxGroupItem<String>(value: value, label: label),
              ],
            ),
          ),
        ),
        GallerySection(
          label: 'Radio',
          description: 'Radio selection shown across every variant and size.',
          child: GalleryEnumMatrix(
            rows: UiRadioVariant.values,
            columns: UiRadioSize.values,
            cellBuilder: (_, variant, size) => RemixRadioGroup<int>(
              groupValue: _radio,
              onChanged: (value) {
                if (value != null) setState(() => _radio = value);
              },
              child: UiRadio<int>(
                variant: variant,
                size: size,
                value: 1,
                semanticLabel: 'Option',
              ),
            ),
          ),
        ),
        GallerySection(
          label: 'Switch',
          description: 'Binary settings controls with all visual treatments.',
          child: GalleryEnumMatrix(
            rows: UiSwitchVariant.values,
            columns: UiSwitchSize.values,
            cellBuilder: (_, variant, size) => UiSwitch(
              variant: variant,
              size: size,
              selected: _switched,
              semanticLabel: 'Example switch',
              onChanged: (value) => setState(() => _switched = value),
            ),
          ),
        ),
        GallerySection(
          label: 'Slider',
          description: 'Discrete single-thumb sliders in every Fortal recipe.',
          child: GalleryEnumMatrix(
            rows: UiSliderVariant.values,
            columns: UiSliderSize.values,
            cellWidth: 210,
            cellBuilder: (_, variant, size) => SizedBox(
              width: 170,
              child: UiSlider(
                variant: variant,
                size: size,
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
                child: UiTextField(
                  error: true,
                  label: 'Workspace slug',
                  hintText: 'remix',
                  helperText: 'That slug is already in use.',
                ),
              ),
              UiCheckbox(
                selected: null,
                tristate: true,
                semanticLabel: 'Indeterminate checkbox',
              ),
              UiCheckbox(selected: true, label: 'Labelled'),
              UiSwitch(
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
