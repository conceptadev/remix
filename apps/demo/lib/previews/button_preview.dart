import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:remix/remix.dart';

import 'preview_helper.dart';

@Preview(name: 'Basic Buttons', size: Size(350, 200))
Widget previewBasicButtons() {
  return createRemixPreview(
    const Column(
      mainAxisAlignment: .center,
      children: [
        RemixButton(
          label: 'Primary Button',
          onPressed: null, // No-op for preview
        ),
        SizedBox(height: 12),
        RemixButton(
          label: 'Button with Icon',
          leadingIcon: Icons.star,
          onPressed: null,
        ),
        SizedBox(height: 12),
        RemixButton(
          label: 'Trailing Icon',
          trailingIcon: Icons.arrow_forward,
          onPressed: null,
        ),
      ],
    ),
  );
}

@Preview(name: 'Button States', size: Size(350, 250))
Widget previewButtonStates() {
  return createRemixPreview(
    const Column(
      mainAxisAlignment: .center,
      children: [
        RemixButton(label: 'Enabled Button', onPressed: null),
        SizedBox(height: 12),
        RemixButton(label: 'Disabled Button', onPressed: null),
        SizedBox(height: 12),
        RemixButton(label: 'Loading Button', loading: true, onPressed: null),
        SizedBox(height: 12),
        RemixButton(
          label: 'Icon Loading',
          leadingIcon: Icons.download,
          loading: true,
          onPressed: null,
        ),
      ],
    ),
  );
}

@Preview(name: 'Icon-Only Buttons', size: Size(350, 150))
Widget previewIconButtons() {
  return createRemixPreview(
    const Row(
      mainAxisAlignment: .center,
      children: [
        RemixIconButton(icon: Icons.add, onPressed: null),
        SizedBox(width: 12),
        RemixIconButton(icon: Icons.edit, onPressed: null),
        SizedBox(width: 12),
        RemixIconButton(icon: Icons.delete, onPressed: null),
        SizedBox(width: 12),
        RemixIconButton(icon: Icons.settings, onPressed: null),
      ],
    ),
  );
}

@Preview(name: 'Button Variations', size: Size(400, 300))
Widget previewButtonVariations() {
  return createRemixPreview(
    const Column(
      mainAxisAlignment: .center,
      children: [
        Row(
          mainAxisAlignment: .center,
          children: [
            RemixButton(
              label: 'Save',
              leadingIcon: Icons.save,
              onPressed: null,
            ),
            SizedBox(width: 12),
            RemixButton(label: 'Cancel', onPressed: null),
          ],
        ),
        SizedBox(height: 16),
        RemixButton(
          label: 'Download File',
          leadingIcon: Icons.download,
          onPressed: null,
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: .center,
          children: [
            RemixIconButton(icon: Icons.thumb_up, onPressed: null),
            SizedBox(width: 8),
            RemixIconButton(icon: Icons.thumb_down, onPressed: null),
            SizedBox(width: 8),
            RemixIconButton(icon: Icons.share, onPressed: null),
          ],
        ),
        SizedBox(height: 16),
        RemixButton(
          label: 'Processing...',
          leadingIcon: Icons.sync,
          loading: true,
          onPressed: null,
        ),
      ],
    ),
  );
}
