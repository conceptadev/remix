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

/// An example-local action surface for product controls whose trigger is
/// richer than the data-driven trigger supported by [FortalMenu].
///
/// The component gallery continues to use [FortalMenu] directly. This
/// composition keeps dashboard-specific avatar and kebab triggers on the
/// current public Remix API without expanding the library surface.
class DashboardActionPopover extends StatefulWidget {
  const DashboardActionPopover({
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
  final double width;

  @override
  State<DashboardActionPopover> createState() => _DashboardActionPopoverState();
}

class _DashboardActionPopoverState extends State<DashboardActionPopover> {
  final MenuController _controller = MenuController();

  @override
  Widget build(BuildContext context) {
    return FortalPopover(
      size: .size1,
      controller: _controller,
      semanticLabel: widget.semanticLabel,
      positioning: widget.positioning,
      popoverChild: SizedBox(
        width: widget.width,
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .stretch,
          spacing: 2,
          children: [
            for (final action in widget.actions) ...[
              if (action.dividerBefore)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: FortalDivider(size: .size4),
                ),
              RemixButton(
                key: ValueKey('dashboard-action-${action.value}'),
                label: action.label,
                onPressed: () {
                  _controller.close();
                  widget.onSelected(action.value);
                },
                style: fortalButtonStyle(
                  variant: .ghost,
                  size: .size1,
                ).mainAxisSize(.max).mainAxisAlignment(.start),
              ),
            ],
          ],
        ),
      ),
      child: widget.trigger,
    );
  }
}

/// Positioning for a [DashboardActionPopover] anchored to a data table's
/// trailing "actions" column: it expands from the row's end edge instead of
/// [DashboardActionPopover.positioning]'s default start edge, so the popover
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
