import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

import '../data/activity.dart';
import '../theme/theme_scope.dart';
import '../widgets/theme_panel.dart';
import '../widgets/toast.dart';
import 'dashboard_page.dart';

class TopBar extends StatefulWidget {
  const TopBar({
    super.key,
    required this.page,
    required this.onSearchChanged,
    this.onMenuPressed,
  });

  final DashboardPage page;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback? onMenuPressed;

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  final _notificationsController = MenuController();
  final _themeController = MenuController();

  @override
  Widget build(BuildContext context) {
    final border = MixScope.tokenOf(FortalTokens.grayA6, context);
    final compact =
        MediaQuery.sizeOf(context).width < dashboardCompactBreakpoint;
    return Container(
      height: 64,
      padding: EdgeInsets.symmetric(horizontal: compact ? 12 : 24),
      decoration: BoxDecoration(
        color: MixScope.tokenOf(FortalTokens.colorPanelSolid, context),
        border: Border(bottom: BorderSide(color: border)),
      ),
      child: Row(
        spacing: 12,
        children: [
          if (widget.onMenuPressed case final onMenuPressed?)
            FortalIconButton.ghost(
              key: const ValueKey('dashboard-menu'),
              semanticLabel: 'Open navigation',
              onPressed: onMenuPressed,
              icon: Icons.menu,
            ),
          if (MediaQuery.sizeOf(context).width > 900) ...[
            StyledText(
              widget.page.section.label,
              style: TextStyler(
                style: FortalTokens.text2.mix(),
              ).color(FortalTokens.gray11()),
            ),
            Icon(
              Icons.chevron_right,
              size: 14,
              color: MixScope.tokenOf(FortalTokens.gray8, context),
            ),
          ],
          Flexible(
            child: StyledText(
              widget.page.label,
              style: TextStyler(style: FortalTokens.text4.mix())
                  .fontWeight(.w700)
                  .color(FortalTokens.gray12())
                  .maxLines(1)
                  .overflow(.ellipsis),
            ),
          ),
          const Spacer(),
          if (MediaQuery.sizeOf(context).width > 1000)
            SizedBox(
              width: 260,
              child: FortalTextField(
                key: const ValueKey('global-search'),
                leading: const Icon(Icons.search, size: 18),
                hintText: 'Search…',
                onChanged: widget.onSearchChanged,
              ),
            ),
          FortalIconButton.ghost(
            key: const ValueKey('theme-quick-toggle'),
            semanticLabel: 'Toggle dark mode',
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
            width: 330,
            matchTriggerWidth: false,
            semanticLabel: 'Notifications',
            positioning: const OverlayPositionConfig(
              side: .bottom,
              alignment: .end,
              sideOffset: 8,
            ),
            popoverChild: Column(
              crossAxisAlignment: .stretch,
              spacing: 10,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: StyledText(
                        'Notifications',
                        style: TextStyler(
                          style: FortalTokens.text3.mix(),
                        ).fontWeight(.w600).color(FortalTokens.gray12()),
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
                      child: const Text('Mark all read'),
                    ),
                  ],
                ),
                for (final event in activityEvents.take(4))
                  Row(
                    crossAxisAlignment: .start,
                    spacing: 9,
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        margin: const EdgeInsets.only(top: 6),
                        decoration: BoxDecoration(
                          color: MixScope.tokenOf(
                            FortalTokens.accent9,
                            context,
                          ),
                          shape: .circle,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: .start,
                          spacing: 2,
                          children: [
                            StyledText(
                              event.title,
                              style: TextStyler(
                                style: FortalTokens.text2.mix(),
                              ).fontWeight(.w600).color(FortalTokens.gray12()),
                            ),
                            StyledText(
                              event.relativeTime,
                              style: TextStyler(
                                style: FortalTokens.text1.mix(),
                              ).color(FortalTokens.gray11()),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            child: FortalIconButton.ghost(
              semanticLabel: 'Notifications',
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
                    child: Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: MixScope.tokenOf(FortalTokens.accent9, context),
                        shape: .circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          FortalPopover(
            controller: _themeController,
            openOnTap: false,
            width: 400,
            maxHeight: 650,
            matchTriggerWidth: false,
            semanticLabel: 'Theme settings',
            positioning: const OverlayPositionConfig(
              side: .bottom,
              alignment: .end,
              sideOffset: 8,
            ),
            popoverChild: const ThemePanel(),
            child: FortalIconButton.ghost(
              key: const ValueKey('theme-panel-trigger'),
              semanticLabel: 'Theme settings',
              onPressed: _toggleTheme,
              icon: Icons.palette_outlined,
            ),
          ),
          FortalMenu<String>(
            semanticLabel: 'Account menu',
            trigger: const FortalAvatar(label: 'LF', size: .size2),
            items: const [
              RemixMenuAction(value: 'profile', child: Text('Profile')),
              RemixMenuAction(value: 'preferences', child: Text('Preferences')),
              RemixMenuSeparator(),
              RemixMenuAction(value: 'signout', child: Text('Sign out')),
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
