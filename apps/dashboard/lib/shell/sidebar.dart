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
    this.onToggle,
  });

  final bool collapsed;

  /// Collapses or expands the desktop panel; null hides the control (drawer).
  final VoidCallback? onToggle;

  final DashboardPage selected;
  final ValueChanged<DashboardPage> onSelected;

  @override
  Widget build(BuildContext context) {
    // Placement stays here: FortalSidebar owns no display edge. Passing the
    // device insets into the generated wrapper keeps them inside its painted
    // surface instead of putting a SafeArea around that surface.
    final insets = MediaQuery.paddingOf(context);

    // `Sidebar` stays self-sizing (rather than deferring width entirely to
    // `FortalSidebarLayout`'s row) so it keeps working the way `sidebar_test`
    // exercises it: standalone, in a bare `Row` with no imposed width. The
    // shell's own row wraps this same width in an `AnimatedContainer` using
    // the identical constants and the identical `collapsed` trigger, so the
    // two transitions move together.
    return FortalSidebar<DashboardPage>(
      collapsed: collapsed,
      expandedWidth: dashboardSidebarWidth,
      collapsedWidth: dashboardSidebarCollapsedWidth,
      panelPadding: insets,
      header: _Brand(collapsed: collapsed, onToggle: onToggle),
      sections: dashboardSidebarSections,
      selectedValue: selected,
      onSelected: onSelected,
      footer: const _Profile(),
      semanticLabel: 'Dashboard navigation',
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand({required this.collapsed, required this.onToggle});

  final bool collapsed;
  final VoidCallback? onToggle;

  @override
  Widget build(BuildContext context) {
    final motion = RemixSidebar.animationOf(context);
    final inset = FortalTokens.space3.resolve(context);
    final label = collapsed ? 'Expand navigation' : 'Collapse navigation';
    return DashboardShellHeader(
      key: const ValueKey('dashboard-brand'),
      horizontalPadding: FortalTokens.space3(),
      child: RowBox(
        children: [
          Expanded(
            child: Semantics(
              label: 'Dashboard',
              excludeSemantics: true,
              // The wordmark starts where expanded destination icons start.
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  start: FortalTokens.space4.resolve(context),
                ),
                child: _SidebarTextReveal(
                  motion: motion,
                  child: const FortalText(
                    'Dashboard',
                    size: .size5,
                    weight: .bold,
                  ),
                ),
              ),
            ),
          ),
          if (onToggle case final onToggle?) ...[
            FortalTooltip(
              positioning: OverlayPositionConfig(
                side: Directionality.of(context) == TextDirection.ltr
                    ? OverlaySide.right
                    : OverlaySide.left,
                alignment: OverlayAlignment.center,
              ),
              tooltipChild: ExcludeSemantics(child: Text(label)),
              child: RemixIconButton(
                key: const ValueKey('dashboard-sidebar-toggle'),
                semanticLabel: label,
                style: dashboardToolbarButtonStyle,
                onPressed: onToggle,
                icon: collapsed ? Icons.menu : Icons.menu_open,
              ),
            ),
            // The toggle rides the trailing edge and settles on the rail's
            // center line with the destination icons.
            SizedBox(
              width:
                  (_railCenter(context) -
                          inset -
                          dashboardToolbarButtonSize / 2)
                      .clamp(0.0, double.infinity),
            ),
          ],
        ],
      ),
    );
  }
}

/// Center line of the collapsed rail, where destination icons settle.
double _railCenter(BuildContext context) =>
    (dashboardSidebarCollapsedWidth -
        FortalTokens.borderWidth1.resolve(context)) /
    2;

class _Profile extends StatelessWidget {
  const _Profile();

  @override
  Widget build(BuildContext context) {
    final motion = RemixSidebar.animationOf(context);
    final inset = FortalTokens.space2.resolve(context);
    // The avatar stays on the rail's center line in both presentations.
    final lead =
        (_railCenter(context) -
                inset -
                FortalTokens.space6.resolve(context) / 2)
            .clamp(0.0, double.infinity);
    return Box(
      style: BoxStyler().padding(
        .symmetric(
          horizontal: FortalTokens.space2(),
          vertical: FortalTokens.space3(),
        ),
      ),
      child: DashboardActionMenu(
        key: const ValueKey('sidebar-account-trigger'),
        semanticLabel: 'Workspace account menu',
        trigger: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48),
          child: RowBox(
            children: [
              SizedBox(width: lead),
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
