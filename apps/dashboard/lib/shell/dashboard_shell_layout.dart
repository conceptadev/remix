import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

const dashboardCompactBreakpoint = 720.0;
const dashboardSidebarWidth = 256.0;
const dashboardSidebarCollapsedWidth = 72.0;
const dashboardShellHeaderHeight = 64.0;
const dashboardToolbarButtonSize = 40.0;

/// Square ghost target shared by top bar and sidebar header actions.
final dashboardToolbarButtonStyle = fortalIconButtonStyle(variant: .ghost)
    .width(dashboardToolbarButtonSize)
    .height(dashboardToolbarButtonSize)
    .padding(.all(0))
    .margin(.all(0))
    .container(.alignment(.center));

class DashboardShellHeader extends StatelessWidget {
  const DashboardShellHeader({
    super.key,
    required this.horizontalPadding,
    required this.child,
  });

  final double horizontalPadding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Box(
      style: BoxStyler()
          .height(dashboardShellHeaderHeight)
          .alignment(AlignmentDirectional.centerStart)
          .padding(.horizontal(horizontalPadding))
          .color(FortalTokens.colorPanelSolid())
          .border(
            .bottom(
              .color(FortalTokens.grayA6()).width(FortalTokens.borderWidth1()),
            ),
          ),
      child: child,
    );
  }
}
