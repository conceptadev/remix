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
  const Sidebar({
    super.key,
    required this.selected,
    required this.onSelected,
    this.collapsed = false,
  });

  final bool collapsed;

  final DashboardPage selected;
  final ValueChanged<DashboardPage> onSelected;

  @override
  Widget build(BuildContext context) {
    // Placement stays here: FortalSidebar owns no display edge. Passing the
    // device insets into the generated wrapper keeps them inside its painted
    // surface instead of putting a SafeArea around that surface.
    final insets = MediaQuery.paddingOf(context);

    return FortalSidebar<DashboardPage>(
      collapsed: collapsed,
      expandedWidth: dashboardSidebarWidth,
      collapsedWidth: dashboardSidebarCollapsedWidth,
      panelPadding: insets,
      header: const _Brand(),
      sections: dashboardSidebarSections,
      selectedValue: selected,
      onSelected: onSelected,
      footer: const _Profile(),
      semanticLabel: 'Dashboard navigation',
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand();

  @override
  Widget build(BuildContext context) {
    final motion = RemixSidebar.animationOf(context);
    return DashboardShellHeader(
      key: const ValueKey('dashboard-brand'),
      horizontalPadding: FortalTokens.space4(),
      child: Semantics(
        label: 'Dashboard',
        excludeSemantics: true,
        child: Stack(
          alignment: AlignmentDirectional.centerStart,
          children: [
            Opacity(
              opacity: 1 - motion.labelOpacity,
              child: const FortalText('D', size: .size5, weight: .bold),
            ),
            _SidebarTextReveal(
              motion: motion,
              child: const FortalText('Dashboard', size: .size5, weight: .bold),
            ),
          ],
        ),
      ),
    );
  }
}

class _Profile extends StatelessWidget {
  const _Profile();

  @override
  Widget build(BuildContext context) {
    final motion = RemixSidebar.animationOf(context);
    return Box(
      style: BoxStyler().padding(.all(8 + 6 * motion.expansion)),
      child: DashboardActionMenu(
        key: const ValueKey('sidebar-account-trigger'),
        semanticLabel: 'Workspace account menu',
        trigger: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48),
          child: LayoutBuilder(
            builder: (context, constraints) => RowBox(
              children: [
                SizedBox(
                  width:
                      ((constraints.maxWidth -
                                  FortalTokens.space6.resolve(context)) /
                              2)
                          .clamp(0.0, double.infinity) *
                      (1 - motion.expansion),
                ),
                const FortalAvatar(label: 'LF', size: .size2),
                SizedBox(width: 10 * motion.expansion),
                Expanded(
                  child: _SidebarTextReveal(
                    motion: motion,
                    child: ColumnBox(
                      style: FlexBoxStyler()
                          .mainAxisSize(.min)
                          .crossAxisAlignment(.start),
                      children: [
                        const FortalText(
                          'Leo Farias',
                          size: .size2,
                          weight: .medium,
                        ),
                        StyledText(
                          'leo@remix.dev',
                          style: dashboardText(
                            .size1,
                            tone: .muted,
                          ).maxLines(1).softWrap(false),
                        ),
                      ],
                    ),
                  ),
                ),
                _SidebarTextReveal(
                  motion: motion,
                  child: Icon(
                    Icons.more_horiz,
                    size: 18,
                    color: MixScope.tokenOf(FortalTokens.gray11, context),
                  ),
                ),
              ],
            ),
          ),
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

/// Clips only non-interactive text; the surrounding menu and focus ring remain.
class _SidebarTextReveal extends StatelessWidget {
  const _SidebarTextReveal({required this.motion, required this.child});
  final SidebarAnimation motion;
  final Widget child;

  @override
  Widget build(BuildContext context) => ClipRect(
    child: Align(
      alignment: AlignmentDirectional.centerStart,
      widthFactor: motion.expansion,
      child: Opacity(
        opacity: motion.labelOpacity,
        child: Offstage(offstage: motion.expansion == 0, child: child),
      ),
    ),
  );
}
