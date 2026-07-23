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
          onPressed: null, // No-op for preview
          child: Text('Primary Button'),
        ),
        SizedBox(height: 12),
        RemixButton(
          onPressed: null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [Icon(Icons.star), Text('Button with Icon')],
          ),
        ),
        SizedBox(height: 12),
        RemixButton(
          onPressed: null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [Text('Trailing Icon'), Icon(Icons.arrow_forward)],
          ),
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
        RemixButton(onPressed: null, child: Text('Enabled Button')),
        SizedBox(height: 12),
        RemixButton(onPressed: null, child: Text('Disabled Button')),
        SizedBox(height: 12),
        RemixButton(
          loading: true,
          onPressed: null,
          child: Text('Loading Button'),
        ),
        SizedBox(height: 12),
        RemixButton(
          loading: true,
          onPressed: null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [Icon(Icons.download), Text('Icon Loading')],
          ),
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
        RemixIconButton(
          semanticLabel: 'Add',
          onPressed: null,
          icon: Icon(Icons.add),
        ),
        SizedBox(width: 12),
        RemixIconButton(
          semanticLabel: 'Edit',
          onPressed: null,
          icon: Icon(Icons.edit),
        ),
        SizedBox(width: 12),
        RemixIconButton(
          semanticLabel: 'Delete',
          onPressed: null,
          icon: Icon(Icons.delete),
        ),
        SizedBox(width: 12),
        RemixIconButton(
          semanticLabel: 'Settings',
          onPressed: null,
          icon: Icon(Icons.settings),
        ),
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
              onPressed: null,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [Icon(Icons.save), Text('Save')],
              ),
            ),
            SizedBox(width: 12),
            RemixButton(onPressed: null, child: Text('Cancel')),
          ],
        ),
        SizedBox(height: 16),
        RemixButton(
          onPressed: null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [Icon(Icons.download), Text('Download File')],
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: .center,
          children: [
            RemixIconButton(
              semanticLabel: 'Like',
              onPressed: null,
              icon: Icon(Icons.thumb_up),
            ),
            SizedBox(width: 8),
            RemixIconButton(
              semanticLabel: 'Dislike',
              onPressed: null,
              icon: Icon(Icons.thumb_down),
            ),
            SizedBox(width: 8),
            RemixIconButton(
              semanticLabel: 'Share',
              onPressed: null,
              icon: Icon(Icons.share),
            ),
          ],
        ),
        SizedBox(height: 16),
        RemixButton(
          loading: true,
          onPressed: null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [Icon(Icons.sync), Text('Processing...')],
          ),
        ),
      ],
    ),
  );
}
