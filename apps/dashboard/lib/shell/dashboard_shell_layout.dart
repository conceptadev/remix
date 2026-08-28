import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

const dashboardCompactBreakpoint = 720.0;
const dashboardSidebarWidth = 256.0;
const dashboardShellHeaderHeight = 64.0;

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
          .alignment(.centerLeft)
          .padding(.horizontal(horizontalPadding))
          .color(FortalTokens.colorPanelSolid())
          .border(
            BoxBorderMix.bottom(
              BorderSideMix(
                color: FortalTokens.grayA6(),
                width: FortalTokens.borderWidth1(),
              ),
            ),
          ),
      child: child,
    );
  }
}
