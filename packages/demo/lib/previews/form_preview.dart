import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:remix/remix.dart';

import 'preview_helper.dart';

@Preview(name: 'Checkbox States', size: Size(300, 200))
Widget previewCheckboxStates() {
  return createRemixPreview(
    const Column(
      mainAxisAlignment: .center,
      children: [
        _PreviewCheckbox(selected: false, label: 'Unchecked'),
        SizedBox(height: 12),
        _PreviewCheckbox(selected: true, label: 'Checked'),
        SizedBox(height: 12),
        _PreviewCheckbox(selected: false, enabled: false, label: 'Disabled'),
      ],
    ),
  );
}

@Preview(name: 'Switch States', size: Size(300, 200))
Widget previewSwitchStates() {
  return createRemixPreview(
    Column(
      mainAxisAlignment: .center,
      children: [
        RemixSwitch(selected: true, onChanged: (value) {}),
        const SizedBox(height: 12),
        RemixSwitch(selected: false, onChanged: (value) {}),
        const SizedBox(height: 12),
        RemixSwitch(selected: true, enabled: false, onChanged: (value) {}),
        const SizedBox(height: 12),
        RemixSwitch(selected: false, enabled: false, onChanged: (value) {}),
      ],
    ),
  );
}

@Preview(name: 'Radio Group', size: Size(300, 250))
Widget previewRadioGroup() {
  return createRemixPreview(
    RemixRadioGroup<String>(
      groupValue: 'option1',
      onChanged: (value) {},
      child: const Column(
        mainAxisAlignment: .center,
        children: [
          _PreviewRadio(value: 'option1', label: 'Selected Option'),
          _PreviewRadio(value: 'option2', label: 'Unselected Option'),
          _PreviewRadio(value: 'option3', label: 'Another Option'),
          _PreviewRadio(
            value: 'option4',
            label: 'Disabled Option',
            enabled: false,
          ),
        ],
      ),
    ),
  );
}

class _PreviewCheckbox extends StatelessWidget {
  const _PreviewCheckbox({
    required this.selected,
    required this.label,
    this.enabled = true,
  });

  final bool selected;
  final String label;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: .min,
      children: [
        RemixCheckbox(
          selected: selected,
          enabled: enabled,
          onChanged: (_) {},
          semanticLabel: label,
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}

class _PreviewRadio extends StatelessWidget {
  const _PreviewRadio({
    required this.value,
    required this.label,
    this.enabled = true,
  });

  final String value;
  final String label;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisSize: .min,
        children: [
          RemixRadio<String>(value: value, enabled: enabled),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}

@Preview(name: 'Text Fields', size: Size(400, 350))
Widget previewTextFields() {
  return createRemixPreview(
    const SizedBox(
      width: 350,
      child: Column(
        mainAxisAlignment: .center,
        children: [
          RemixTextField(hintText: 'Enter your name'),
          SizedBox(height: 16),
          RemixTextField(
            hintText: 'Enter your email',
            leading: Icon(Icons.email),
          ),
          SizedBox(height: 16),
          RemixTextField(
            hintText: 'Enter password',
            obscureText: true,
            trailing: Icon(Icons.visibility),
          ),
          SizedBox(height: 16),
          RemixTextField(hintText: 'This field is disabled', enabled: false),
        ],
      ),
    ),
  );
}

@Preview(name: 'Slider Examples', size: Size(350, 200))
Widget previewSliders() {
  return createRemixPreview(
    SizedBox(
      width: 300,
      child: Column(
        mainAxisAlignment: .center,
        children: [
          const Text('Volume: 50%'),
          RemixSlider(value: 0.5, onChanged: (value) {}),
          const SizedBox(height: 20),
          const Text('Brightness: 75%'),
          RemixSlider(value: 0.75, onChanged: (value) {}),
          const SizedBox(height: 20),
          const Text('Disabled Slider'),
          RemixSlider(value: 0.3, enabled: false, onChanged: (value) {}),
        ],
      ),
    ),
  );
}

@Preview(name: 'Select Dropdown', size: Size(350, 200))
Widget previewSelect() {
  return createRemixPreview(
    RemixSelect<String>(
      trigger: const RemixSelectTrigger(placeholder: 'Select an option'),
      selectedValue: 'option1',
      items: const [
        RemixSelectItem(value: 'option1', label: 'First Option'),
        RemixSelectItem(value: 'option2', label: 'Second Option'),
        RemixSelectItem(value: 'option3', label: 'Third Option'),
      ],
      onChanged: (value) {},
    ),
  );
}
