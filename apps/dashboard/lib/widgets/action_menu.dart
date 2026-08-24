import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

@immutable
class DashboardAction {
  const DashboardAction({
    required this.value,
    required this.label,
    this.dividerBefore = false,
  });

  final String value;
  final String label;
  final bool dividerBefore;
}

/// An example-local action menu for product controls whose trigger is richer
/// than the standard label/icon surface.
///
/// The component gallery continues to use [FortalMenu] directly. This wrapper
/// names a repeated product concept and centralizes the width and action
/// mapping for avatar, profile-row, and kebab triggers.
class DashboardActionMenu extends StatelessWidget {
  const DashboardActionMenu({
    super.key,
    required this.semanticLabel,
    required this.trigger,
    required this.actions,
    required this.onSelected,
    this.positioning = const OverlayPositionConfig(
      side: OverlaySide.bottom,
      alignment: OverlayAlignment.start,
      sideOffset: 4,
      collisionPadding: EdgeInsets.all(10),
    ),
    this.width = 180,
  });

  final String semanticLabel;
  final Widget trigger;
  final List<DashboardAction> actions;
  final ValueChanged<String> onSelected;
  final OverlayPositionConfig positioning;

  /// Menu overlay width. Size-1 content insets are subtracted and applied
  /// as each item's width so the panel stays this wide under Fortal scaling.
  final double width;

  @override
  Widget build(BuildContext context) {
    final contentInset = FortalTokens.space1.resolve(context);
    final itemWidth = width - contentInset * 2;

    return FortalMenu<String>(
      size: .size1,
      semanticLabel: semanticLabel,
      positioning: positioning,
      trigger: RemixMenuTrigger.builder(
        label: semanticLabel,
        builder: (context, state, defaultTrigger) => trigger,
      ),
      items: [
        for (final action in actions) ...[
          if (action.dividerBefore) const RemixMenuDivider(),
          RemixMenuItem(
            key: ValueKey('dashboard-action-${action.value}'),
            value: action.value,
            label: action.label,
            style: MenuItemStyler().width(itemWidth),
          ),
        ],
      ],
      onSelected: onSelected,
    );
  }
}

/// Positioning for a [DashboardActionMenu] anchored to a data table's
/// trailing "actions" column: it expands from the row's end edge instead of
/// [DashboardActionMenu.positioning]'s default start edge, so the menu
/// never overshoots the table when the column sits at the table's own edge.
const dataTableActionsPositioning = OverlayPositionConfig(
  side: OverlaySide.bottom,
  alignment: OverlayAlignment.end,
  sideOffset: 4,
);

/// The compact kebab trigger shared by every data table actions column.
const dataTableActionsTrigger = Padding(
  padding: EdgeInsets.all(6),
  child: Icon(Icons.more_horiz, size: 18),
);
