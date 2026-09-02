import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../utils/text.dart';
import '../widgets/action_menu.dart';
import '../widgets/toast.dart';
import '../widgets/typography.dart';
import 'dashboard_page.dart';
import 'dashboard_shell_layout.dart';
import 'sidebar_sections.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key, required this.selected, required this.onSelected});

  final DashboardPage selected;
  final ValueChanged<DashboardPage> onSelected;

  @override
  Widget build(BuildContext context) {
    // Placement stays here: RemixSidebar owns no display edge. The panel paints
    // to that edge, so device insets become panel padding rather than a
    // SafeArea wrapped around the painted surface.
    final insets = MediaQuery.paddingOf(context);

    return SizedBox(
      width: dashboardSidebarWidth,
      child: RemixSidebar<DashboardPage>(
        style: fortalSidebarStyle().padding(
          EdgeInsetsGeometryMix.only(
            left: insets.left,
            right: insets.right,
            top: insets.top,
            bottom: insets.bottom,
          ),
        ),
        header: const _Brand(),
        sections: dashboardSidebarSections,
        selectedValue: selected,
        onSelected: onSelected,
        footer: const _Profile(),
        semanticLabel: 'Dashboard navigation',
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
