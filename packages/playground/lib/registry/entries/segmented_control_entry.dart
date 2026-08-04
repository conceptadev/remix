import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

Widget buildSegmentedControlExample() {
  return const SizedBox(width: 340, child: _RemixSegmentedControlPreview());
}

class _RemixSegmentedControlPreview extends StatefulWidget {
  const _RemixSegmentedControlPreview();

  @override
  State<_RemixSegmentedControlPreview> createState() =>
      _RemixSegmentedControlPreviewState();
}

class _RemixSegmentedControlPreviewState
    extends State<_RemixSegmentedControlPreview> {
  String _period = 'week';
  String _view = 'grid';
  String _density = 'comfortable';

  // Deliberate: this preview hand-rolls a style instead of reaching for a
  // themed preset. No Fortal recipe ships for the segmented control in v1, so
  // an unstyled RemixSegmentedControl would render as bare text. Replace this
  // with the Fortal preset once one exists.
  SegmentedControlStyler _style(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final disabledForeground = colors.onSurface.withValues(alpha: 0.35);
    final selectedShadow = RemixBoxEffectsMix(
      behindContent: RemixBoxEffectLayerMix(
        shadows: [
          RemixBoxShadowMix(
            color: colors.shadow.withValues(alpha: 0.18),
            offset: const Offset(0, 1),
            blurRadius: 3,
          ),
          RemixBoxShadowMix(
            kind: RemixBoxShadowKind.inset,
            color: colors.outlineVariant,
            spreadRadius: 1,
          ),
        ],
      ),
    );

    return SegmentedControlStyler()
        .paddingAll(4)
        .borderRadius(BorderRadiusGeometryMix.circular(10))
        .color(colors.surfaceContainerHighest)
        .item(
          SegmentedControlItemStyler()
              .paddingX(12)
              .paddingY(8)
              .spacing(6)
              .borderRadius(BorderRadiusGeometryMix.circular(7))
              .labelColor(colors.onSurfaceVariant)
              .iconColor(colors.onSurfaceVariant)
              .onSelected(
                .color(colors.surface)
                    .labelColor(colors.onSurface)
                    .iconColor(colors.onSurface)
                    .containerEffects(selectedShadow),
              )
              .onHovered(.color(colors.onSurface.withValues(alpha: 0.06)))
              .onPressed(.color(colors.onSurface.withValues(alpha: 0.1)))
              .onFocused(
                .containerEffects(
                  RemixBoxEffectsMix(
                    outline: BorderSideMix(
                      color: colors.primary,
                      width: 2,
                      strokeAlign: BorderSide.strokeAlignInside,
                    ),
                    outlineOffset: 2,
                  ),
                ),
              )
              .onDisabled(
                .label(
                  TextStyler().color(disabledForeground),
                ).iconColor(disabledForeground),
              ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final style = _style(context);

    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        RemixSegmentedControl<String>(
          semanticLabel: 'Reporting period',
          items: const [
            RemixSegmentedControlItem(value: 'day', label: 'Day'),
            RemixSegmentedControlItem(value: 'week', label: 'This week'),
            RemixSegmentedControlItem(value: 'month', label: 'Month'),
            RemixSegmentedControlItem(
              value: 'year',
              label: 'Year',
              enabled: false,
            ),
          ],
          selectedValue: _period,
          onChanged: (value) => setState(() => _period = value),
          style: style,
        ),
        const SizedBox(height: 8),
        Text('Selected: $_period'),
        const SizedBox(height: 20),
        RemixSegmentedControl<String>(
          semanticLabel: 'Layout',
          items: const [
            RemixSegmentedControlItem(
              value: 'list',
              icon: Icons.view_list,
              semanticLabel: 'List view',
            ),
            RemixSegmentedControlItem(
              value: 'grid',
              icon: Icons.grid_view,
              semanticLabel: 'Grid view',
            ),
            RemixSegmentedControlItem(
              value: 'board',
              icon: Icons.view_kanban,
              semanticLabel: 'Board view',
            ),
          ],
          selectedValue: _view,
          onChanged: (value) => setState(() => _view = value),
          style: style,
        ),
        const SizedBox(height: 20),
        RemixSegmentedControl<String>(
          semanticLabel: 'Density',
          orientation: Axis.vertical,
          items: const [
            RemixSegmentedControlItem(value: 'compact', label: 'Compact'),
            RemixSegmentedControlItem(
              value: 'comfortable',
              label: 'Comfortable',
            ),
            RemixSegmentedControlItem(value: 'spacious', label: 'Spacious'),
          ],
          selectedValue: _density,
          onChanged: (value) => setState(() => _density = value),
          style: style,
        ),
      ],
    );
  }
}
