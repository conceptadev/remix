import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../utils/text.dart';
import '../widgets/action_menu.dart';
import '../widgets/toast.dart';
import '../widgets/typography.dart';
import 'dashboard_page.dart';
import 'dashboard_shell_layout.dart';
import 'navigation_list.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key, required this.selected, required this.onSelected});

  final DashboardPage selected;
  final ValueChanged<DashboardPage> onSelected;

  @override
  Widget build(BuildContext context) {
    return Box(
      style: BoxStyler()
          .width(dashboardSidebarWidth)
          .color(FortalTokens.colorPanelSolid())
          .border(
            BoxBorderMix.right(
              BorderSideMix(
                color: FortalTokens.grayA5(),
                width: FortalTokens.borderWidth1(),
              ),
            ),
          ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            const _Brand(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(12, 16, 12, 20),
                child: DashboardNavigationList(
                  sections: dashboardNavSections,
                  selected: selected,
                  onSelected: onSelected,
                ),
              ),
            ),
            const FortalDivider(size: .size4),
            const _Profile(),
          ],
        ),
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand();

  @override
  Widget build(BuildContext context) {
    return DashboardShellHeader(
      key: const ValueKey('dashboard-brand'),
      horizontalPadding: FortalTokens.space4(),
      child: const FortalText('Dashboard', size: .size5, weight: .bold),
    );
  }
}

class _Profile extends StatelessWidget {
  const _Profile();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: DashboardActionMenu(
        key: const ValueKey('sidebar-account-trigger'),
        semanticLabel: 'Workspace account menu',
        trigger: Row(
          spacing: 10,
          children: [
            const FortalAvatar(label: 'LF', size: .size2),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  const FortalText('Leo Farias', size: .size2, weight: .medium),
                  StyledText(
                    'leo@remix.dev',
                    style: dashboardText(.size1, tone: .muted),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.more_horiz,
              size: 18,
              color: MixScope.tokenOf(FortalTokens.gray11, context),
            ),
          ],
        ),
        actions: const [
          DashboardAction(value: 'profile', label: 'View profile'),
          DashboardAction(value: 'preferences', label: 'Preferences'),
          DashboardAction(
            value: 'signout',
            label: 'Sign out',
            dividerBefore: true,
          ),
        ],
        onSelected: (value) => showToast(
          context,
          message: value == 'signout'
              ? 'Signed out of demo'
              : '${capitalize(value)} opened',
        ),
      ),
    );
  }
}
