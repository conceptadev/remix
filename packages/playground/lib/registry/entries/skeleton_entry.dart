import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

import '../../widgets/spaced_column.dart';

Widget buildSkeletonExample() {
  return const SizedBox(width: 320, child: _SkeletonPreview());
}

class _SkeletonPreview extends StatefulWidget {
  const _SkeletonPreview();

  @override
  State<_SkeletonPreview> createState() => _SkeletonPreviewState();
}

class _SkeletonPreviewState extends State<_SkeletonPreview> {
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;
    final base = SkeletonStyler()
        .container(BoxStyler().color(onSurface.withValues(alpha: 0.08)))
        .pulseColor(onSurface.withValues(alpha: 0.16));

    return SpacedColumn(
      spacing: 24,
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        Row(
          mainAxisSize: .min,
          spacing: 12,
          children: [
            Switch(
              value: _loading,
              onChanged: (value) => setState(() => _loading = value),
            ),
            Text(_loading ? 'Loading' : 'Loaded'),
          ],
        ),

        // Child-sized: the child keeps sizing the skeleton in both states, so
        // flipping the switch must not move anything below it.
        _Section(
          title: 'Child-sized — no layout shift',
          children: [
            RemixSkeleton(
              loading: _loading,
              style: base.container(BoxStyler().borderRounded(4)),
              child: const Text('Jane Appleseed — jane@example.com'),
            ),
            RemixSkeleton(
              loading: _loading,
              style: base.container(BoxStyler().borderRounded(6)),
              child: RemixButton(label: 'Open profile', onPressed: () {}),
            ),
          ],
        ),

        // Standalone: the container's own constraints decide the size, and a
        // childless skeleton collapses to nothing once loading ends. These stay
        // in the loading state so the shapes remain visible.
        _Section(
          title: 'Standalone shapes',
          children: [
            Row(
              spacing: 16,
              crossAxisAlignment: .start,
              children: [
                RemixSkeleton(
                  style: base.container(BoxStyler().size(40, 40).shapeCircle()),
                ),
                SpacedColumn(
                  spacing: 8,
                  mainAxisSize: .min,
                  crossAxisAlignment: .start,
                  children: [
                    RemixSkeleton(
                      style: base.container(
                        BoxStyler().size(180, 12).borderRounded(6),
                      ),
                    ),
                    RemixSkeleton(
                      style: base.container(
                        BoxStyler().size(120, 12).borderRounded(6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            RemixSkeleton(
              style: base.container(BoxStyler().size(320, 88).borderRounded(8)),
            ),
          ],
        ),

        Text(
          'The pulse honours the platform reduced-motion preference: with '
          '"Reduce motion" enabled the placeholders paint their base frame and '
          'stop animating. Hidden children stay measured but cannot be tapped, '
          'focused, or read by assistive technology.',
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SpacedColumn(
      spacing: 12,
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleSmall),
        ...children,
      ],
    );
  }
}
