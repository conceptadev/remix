import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../data/activity.dart';
import '../theme/theme_scope.dart';
import '../widgets/action_menu.dart';
import '../widgets/theme_panel.dart';
import '../widgets/toast.dart';
import '../widgets/typography.dart';
import 'dashboard_page.dart';
import 'dashboard_shell_layout.dart';

class TopBar extends StatefulWidget {
  const TopBar({
    super.key,
    required this.page,
    required this.onSearchChanged,
    this.onMenuPressed,
    this.onSidebarToggle,
    this.sidebarCollapsed = false,
  });

  final DashboardPage page;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onSidebarToggle;
  final bool sidebarCollapsed;

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  final _notificationsController = MenuController();
  final _themeController = MenuController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final compact = width < dashboardCompactBreakpoint;
    final toolbarButtonStyle = fortalIconButtonStyle(variant: .ghost)
        .width(40)
        .height(40)
        .padding(.all(0))
        .margin(.all(0))
        .container(.alignment(.center));
    final navigationLabel = widget.sidebarCollapsed
        ? 'Expand navigation'
        : 'Collapse navigation';
    return DashboardShellHeader(
      horizontalPadding: compact
          ? FortalTokens.space3()
          : FortalTokens.space5(),
      child: RowBox(
        style: FlexBoxStyler().spacing(FortalTokens.space2()),
        children: [
          if (widget.onMenuPressed case final onMenuPressed?)
            RemixIconButton(
              key: const ValueKey('dashboard-menu'),
              semanticLabel: 'Open navigation',
              style: toolbarButtonStyle,
              onPressed: onMenuPressed,
              icon: Icons.menu,
            ),
          if (widget.onSidebarToggle case final onToggle?)
            FortalTooltip(
              tooltipChild: ExcludeSemantics(child: Text(navigationLabel)),
              child: RemixIconButton(
                key: const ValueKey('dashboard-sidebar-toggle'),
                semanticLabel: navigationLabel,
                style: toolbarButtonStyle,
                onPressed: onToggle,
                icon: widget.sidebarCollapsed ? Icons.menu : Icons.menu_open,
              ),
            ),
          Expanded(
            child: RowBox(
              style: FlexBoxStyler().spacing(FortalTokens.space3()),
              children: [
                if (width > 900) ...[
                  StyledText(
                    widget.page.section.label,
                    style: dashboardText(.size2, tone: .muted),
                  ),
                  StyledIcon(
                    icon: Directionality.of(context) == TextDirection.ltr
                        ? Icons.chevron_right
                        : Icons.chevron_left,
                    style: IconStyler().size(14).color(FortalTokens.gray8()),
                  ),
                ],
                Flexible(
                  // Context repeats the page heading; it is not another heading
                  // or a workspace-switching control.
                  child: StyledText(
                    widget.page.label,
                    style: dashboardTextLine(.size4, weight: .bold),
                  ),
                ),
              ],
            ),
          ),
          if (width > 1000)
            Box(
              style: BoxStyler().width(260),
              child: FortalTextField(
                key: const ValueKey('global-search'),
                leading: const Icon(Icons.search, size: 18),
                hintText: 'Search…',
                onChanged: widget.onSearchChanged,
              ),
            ),
          RemixIconButton(
            key: const ValueKey('theme-quick-toggle'),
            semanticLabel: 'Toggle dark mode',
            style: toolbarButtonStyle,
            onPressed: () {
              final theme = ThemeScope.of(context);
              final isDark = FortalTheme.of(context).isDark;
              theme.onChanged(
                theme.settings.copyWith(appearance: isDark ? .light : .dark),
              );
            },
            icon: FortalTheme.of(context).isDark
                ? Icons.light_mode_outlined
                : Icons.dark_mode_outlined,
          ),
          FortalPopover(
            controller: _notificationsController,
            openOnTap: false,
            semanticLabel: 'Notifications',
            positioning: const OverlayPositionConfig(
              side: .bottom,
              alignment: .end,
              sideOffset: 8,
            ),
            popoverChild: Box(
              key: const ValueKey('topbar-notifications-content'),
              style: BoxStyler().width(330),
              child: ColumnBox(
                style: FlexBoxStyler()
                    .mainAxisSize(.min)
                    .crossAxisAlignment(.stretch)
                    .spacing(10),
                children: [
                  RowBox(
                    children: [
                      const Expanded(
                        child: FortalHeading(
                          'Notifications',
                          headingLevel: 2,
                          size: .size3,
                          weight: .medium,
                        ),
                      ),
                      FortalButton.ghost(
                        size: .size1,
                        onPressed: () {
                          _notificationsController.close();
                          showToast(
                            context,
                            message: 'All notifications marked read',
                          );
                        },
                        label: 'Mark all read',
                      ),
                    ],
                  ),
                  for (final event in activityEvents.take(4))
                    RowBox(
                      style: FlexBoxStyler()
                          .crossAxisAlignment(.start)
                          .spacing(9),
                      children: [
                        Box(
                          style: BoxStyler()
                              .width(7)
                              .height(7)
                              .margin(.top(6))
                              .color(FortalTokens.accent9())
                              .borderRadius(.circular(4)),
                        ),
                        Expanded(
                          child: ColumnBox(
                            style: FlexBoxStyler()
                                .crossAxisAlignment(.start)
                                .spacing(2),
                            children: [
                              FortalText(
                                event.title,
                                size: .size2,
                                weight: .medium,
                              ),
                              StyledText(
                                event.relativeTime,
                                style: dashboardText(.size1, tone: .muted),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            child: RemixIconButton(
              semanticLabel: 'Notifications',
              style: toolbarButtonStyle,
              onPressed: _toggleNotifications,
              icon: Icons.notifications_none,
              iconBuilder: (context, spec, icon) => Stack(
                clipBehavior: .none,
                children: [
                  StyledIcon(
                    icon: icon,
                    styleSpec: StyleSpec(spec: spec),
                  ),
                  Positioned(
                    right: -1,
                    top: -1,
                    child: Box(
                      style: BoxStyler()
                          .width(7)
                          .height(7)
                          .color(FortalTokens.accent9())
                          .borderRadius(.circular(4)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          FortalPopover(
            controller: _themeController,
            openOnTap: false,
            semanticLabel: 'Theme settings',
            positioning: const OverlayPositionConfig(
              side: .bottom,
              alignment: .end,
              sideOffset: 8,
            ),
            popoverChild: Box(
              style: BoxStyler().width(400).maxHeight(650),
              child: const SingleChildScrollView(child: ThemePanel()),
            ),
            child: RemixIconButton(
              key: const ValueKey('theme-panel-trigger'),
              semanticLabel: 'Theme settings',
              style: toolbarButtonStyle,
              onPressed: _toggleTheme,
              icon: Icons.palette_outlined,
            ),
          ),
          DashboardActionMenu(
            key: const ValueKey('topbar-account-trigger'),
            semanticLabel: 'Account menu',
            positioning: const OverlayPositionConfig(
              side: .bottom,
              alignment: .end,
              sideOffset: 8,
            ),
            trigger: const FortalAvatar(label: 'LF', size: .size2),
            actions: const [
              DashboardAction(value: 'profile', label: 'Profile'),
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
                  : 'Opened $value',
            ),
          ),
        ],
      ),
    );
  }

  void _toggleNotifications() {
    _notificationsController.isOpen
        ? _notificationsController.close()
        : _notificationsController.open();
  }

  void _toggleTheme() {
    _themeController.isOpen
        ? _themeController.close()
        : _themeController.open();
  }
}
